import 'dart:async';
import 'dart:convert';

import 'dart:ui' show CallbackHandle, PluginUtilities;
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';
import 'package:ssl_certificates/ssl_certificates.dart';

import '../hub/signaling_hub.dart';

final _logger = Logger('SignalingForegroundIsolateManager');

/// Factory that wraps a [SignalingModule] in a [SignalingHub].
///
/// The default implementation is [SignalingHub.new]. Overridable in tests
/// to avoid [IsolateNameServer] usage.
typedef SignalingHubFactory = SignalingHub Function(SignalingModule module);

/// Manages the [SignalingModule] + [SignalingHub] lifecycle inside the
/// foreground-service background isolate.
///
/// Created once per background isolate run. [handleStatus] is called by the
/// background isolate entry point ([onSignalingServiceSync]) whenever the
/// service status changes (service enabled/disabled).
///
/// The [SignalingModule] is created via the factory callback registered
/// by the app through [WebtritSignalingService.setModuleFactory]. The raw handle
/// is resolved from [PluginUtilities] so the factory can be called in the
/// background isolate without the main isolate being alive.
///
/// When an [IncomingCallEvent] arrives and [incomingCallHandlerHandle] is
/// non-zero, the manager resolves the registered Dart callback via
/// [PluginUtilities.getCallbackFromHandle] and invokes it with the event so
/// that the app side can trigger callkeep without depending on this plugin.
class SignalingForegroundIsolateManager {
  SignalingForegroundIsolateManager({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    this.trustedCertificatesJson,
    this.incomingCallHandlerHandle = 0,
    this.moduleFactoryHandle = 0,
    @visibleForTesting SignalingModuleFactory? moduleFactory,
    @visibleForTesting SignalingHubFactory? hubFactory,
  }) : _testModuleFactory = moduleFactory,
       _testHubFactory = hubFactory;

  final String coreUrl;
  final String tenantId;
  final String token;

  /// JSON-encoded trusted certificates, serialized from the main isolate via
  /// [WebtritSignalingServiceAndroid.saveTrustedCertificates].
  /// Null when the app uses the default system trust store.
  final String? trustedCertificatesJson;

  /// Raw handle for the app-side incoming call callback.
  ///
  /// Registered by the app via [WebtritSignalingService.setIncomingCallHandler].
  /// 0 means no handler is registered -- incoming calls are only forwarded to
  /// the hub (main isolate) and silently ignored in the background.
  final int incomingCallHandlerHandle;

  /// Raw handle for the app-side [SignalingModuleFactory] callback.
  ///
  /// Registered by the app via [WebtritSignalingService.setModuleFactory].
  /// 0 means no factory is registered -- the isolate will log an error and skip start.
  final int moduleFactoryHandle;

  /// Overrides handle-based [SignalingModule] creation in tests.
  final SignalingModuleFactory? _testModuleFactory;

  /// Overrides [SignalingHub] construction in tests to avoid [IsolateNameServer].
  final SignalingHubFactory? _testHubFactory;

  SignalingModule? _signalingModule;
  SignalingHub? _hub;

  StreamSubscription<SignalingModuleEvent>? _eventsSubscription;
  Timer? _reconnectTimer;

  bool _started = false;

  /// Called by the entry point when the service status changes.
  Future<void> handleStatus({required bool enabled}) async {
    if (enabled) {
      await _start();
    } else {
      await _stop();
    }
  }

  Future<void> _start() async {
    if (_started) {
      // Hub and module are already initialized. If the module lost its
      // connection (e.g. a code-1002 close that does not auto-reconnect),
      // reconnect it now so the external start() call is not silently ignored.
      if (!(_signalingModule?.isConnected ?? false)) {
        _logger.info('SignalingForegroundIsolateManager already started but not connected, reconnecting');
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
        _signalingModule?.connect();
      }
      return;
    }

    _logger.info('SignalingForegroundIsolateManager starting (incomingCallHandler=${incomingCallHandlerHandle != 0})');

    final factory = _testModuleFactory ?? _resolveModuleFactory();
    if (factory == null) return;

    _started = true;
    final config = SignalingServiceConfig(
      coreUrl: coreUrl,
      tenantId: tenantId,
      token: token,
      trustedCertificates: _decodeTrustedCertificates(trustedCertificatesJson),
    );

    _signalingModule = factory(config);

    _hub = (_testHubFactory ?? SignalingHub.new)(_signalingModule!);
    _hub!.start();

    _eventsSubscription = _signalingModule!.events.listen(_onEvent);
    _signalingModule!.connect();

    _logger.info('SignalingForegroundIsolateManager started');
  }

  Future<void> _stop() async {
    if (!_started) return;
    _started = false;

    _logger.info('SignalingForegroundIsolateManager stopping');

    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    await _eventsSubscription?.cancel();
    await _hub?.dispose();
    await _signalingModule?.dispose();

    _eventsSubscription = null;
    _hub = null;
    _signalingModule = null;

    _logger.info('SignalingForegroundIsolateManager stopped');
  }

  /// Resolves the [SignalingModuleFactory] from the raw [moduleFactoryHandle].
  ///
  /// Returns null and logs an error when the handle is 0 or cannot be resolved.
  SignalingModuleFactory? _resolveModuleFactory() {
    if (moduleFactoryHandle == 0) {
      _logger.severe('No module factory registered -- call setModuleFactory() before start()');
      return null;
    }
    final callback = PluginUtilities.getCallbackFromHandle(CallbackHandle.fromRawHandle(moduleFactoryHandle));
    if (callback == null) {
      _logger.severe('Could not resolve module factory from handle $moduleFactoryHandle');
      return null;
    }
    return callback as SignalingModuleFactory;
  }

  void _onEvent(SignalingModuleEvent event) {
    _logger.info('IsolateManager event: ${event.runtimeType}');
    switch (event) {
      case SignalingConnecting():
        _logger.info('IsolateManager: connecting...');
      case SignalingConnected():
        _logger.info('IsolateManager: connected');
      case SignalingConnectionFailed(:final error, :final recommendedReconnectDelay):
        _logger.warning('IsolateManager: connection failed -- $error, reconnect in $recommendedReconnectDelay');
        _scheduleReconnect(recommendedReconnectDelay);
      case SignalingHandshakeReceived(:final handshake):
        _logger.info('IsolateManager: handshake lines=${handshake.lines}');
      case SignalingProtocolEvent(:final event):
        _logger.info('IsolateManager: protocol event ${event.runtimeType}');
        if (event is IncomingCallEvent) {
          _dispatchIncomingCall(event);
        }
      case SignalingDisconnected(:final code, :final reason, :final recommendedReconnectDelay):
        _logger.info('IsolateManager: disconnected code=$code reason=$reason');
        if (recommendedReconnectDelay != null) {
          _scheduleReconnect(recommendedReconnectDelay);
        }
      default:
        break;
    }
  }

  /// Invokes the app-registered incoming call callback in this background isolate.
  ///
  /// The callback is a top-level Dart function annotated with
  /// [@pragma('vm:entry-point')] that the app registered via
  /// [WebtritSignalingService.setIncomingCallHandler]. It receives the raw
  /// [IncomingCallEvent] and is responsible for callkeep integration.
  void _dispatchIncomingCall(IncomingCallEvent event) {
    if (incomingCallHandlerHandle == 0) {
      _logger.warning(
        'IsolateManager: IncomingCallEvent received but no handler registered -- call will be missed in background',
      );
      return;
    }

    final callback = PluginUtilities.getCallbackFromHandle(CallbackHandle.fromRawHandle(incomingCallHandlerHandle));
    if (callback == null) {
      _logger.severe('IsolateManager: could not resolve incoming call handler from handle $incomingCallHandlerHandle');
      return;
    }

    _logger.info('IsolateManager: dispatching IncomingCallEvent callId=${event.callId} to app handler');
    try {
      // Use Function.apply so both sync and async callbacks work.
      final dynamic result = Function.apply(callback, [event]);
      if (result is Future<dynamic>) {
        result.catchError((Object e, StackTrace st) {
          _logger.severe('IsolateManager: incoming call handler async error', e, st);
        });
      }
    } catch (e, st) {
      _logger.severe('IsolateManager: incoming call handler threw', e, st);
    }
  }

  void _scheduleReconnect(Duration? delay) {
    if (delay == null) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (_started) {
        _logger.info('SignalingForegroundIsolateManager reconnecting after $delay');
        _signalingModule?.connect();
      }
    });
  }
}

// ---------------------------------------------------------------------------
// Trusted certificates deserialization
// ---------------------------------------------------------------------------

/// Decodes a JSON-encoded certificate list produced by [_encodeTrustedCertificates]
/// in the main isolate back into a [TrustedCertificates] instance.
///
/// Returns [TrustedCertificates.empty] when [json] is null, empty, or malformed.
TrustedCertificates _decodeTrustedCertificates(String? json) {
  if (json == null || json.isEmpty) return TrustedCertificates.empty;
  try {
    final list = jsonDecode(json) as List<dynamic>;
    return TrustedCertificates(
      certificates: list.map((entry) {
        final map = entry as Map<String, dynamic>;
        return TrustCertificate(
          bytes: List<int>.from(map['bytes'] as List<dynamic>),
          password: map['password'] as String?,
        );
      }).toList(),
    );
  } catch (e, st) {
    Logger(
      'SignalingForegroundIsolateManager',
    ).severe('Failed to decode trusted certificates from JSON -- using system trust store', e, st);
    return TrustedCertificates.empty;
  }
}
