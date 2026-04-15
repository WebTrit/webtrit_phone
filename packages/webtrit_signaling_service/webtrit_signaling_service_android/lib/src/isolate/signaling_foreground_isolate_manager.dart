import 'dart:async';
import 'dart:convert';

import 'dart:ui' show CallbackHandle, PluginUtilities;
import 'package:flutter/foundation.dart' show VoidCallback, visibleForTesting;
import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';
import 'package:ssl_certificates/ssl_certificates.dart';

import '../hub/signaling_hub.dart';
import '../messages.g.dart';

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
    this.isPushBound = false,
    this.pushBoundNoSubscriberGrace = const Duration(seconds: 10),
    @visibleForTesting SignalingModuleFactory? moduleFactory,
    @visibleForTesting SignalingHubFactory? hubFactory,
    @visibleForTesting VoidCallback? stopServiceOverride,
  }) : _testModuleFactory = moduleFactory,
       _testHubFactory = hubFactory,
       _testStopService = stopServiceOverride;

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

  /// Whether the service was started in pushBound mode.
  ///
  /// In pushBound mode the service lifetime is tied to the Activity: it should
  /// stop automatically when no subscriber (Activity or push-notification isolate)
  /// remains connected after a short grace period. Without this guard the service
  /// becomes orphaned when a call is declined before the Activity connects.
  final bool isPushBound;

  /// How long to wait after the last subscriber disconnects before stopping
  /// the service in pushBound mode.
  ///
  /// Allows time for the Activity to start and subscribe after a normal incoming
  /// call. If a subscriber arrives within this window the timer is cancelled and
  /// the service continues normally. Exposed as a constructor parameter so it
  /// can be overridden in tests without sleeping.
  final Duration pushBoundNoSubscriberGrace;

  /// Overrides handle-based [SignalingModule] creation in tests.
  final SignalingModuleFactory? _testModuleFactory;

  /// Overrides [SignalingHub] construction in tests to avoid [IsolateNameServer].
  final SignalingHubFactory? _testHubFactory;

  /// Overrides [PSignalingServiceHostApi().stopService()] in tests to avoid
  /// binary-messenger dependency.
  final VoidCallback? _testStopService;

  SignalingModule? _signalingModule;
  SignalingHub? _hub;

  StreamSubscription<SignalingModuleEvent>? _eventsSubscription;
  Timer? _reconnectTimer;

  /// Scheduled in pushBound mode when [SignalingHub.hasSubscribers] drops to
  /// false. Fires [_requestServiceStop] after [_pushBoundNoSubscriberGrace] if
  /// no new subscriber arrives. Cancelled when a subscriber connects.
  Timer? _pushBoundCleanupTimer;

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
      // Hub and module are already initialized. Cancel any pending
      // persistent-mode auto-reconnect timer — the caller (main isolate or
      // network-restore handler) takes responsibility for the connection now.
      _reconnectTimer?.cancel();
      _reconnectTimer = null;
      if (!(_signalingModule?.isConnected ?? false)) {
        _logger.info('SignalingForegroundIsolateManager already started but not connected, reconnecting');
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
    if (isPushBound) {
      _hub!.onHasSubscribersChanged = _onHubHasSubscribersChanged;
    }
    _hub!.start();
    if (isPushBound && !_hub!.hasSubscribers) {
      // No subscriber at start time (typical push-started service where the
      // Activity has not connected yet). Schedule the cleanup timer now so
      // the service stops if the Activity never launches.
      _onHubHasSubscribersChanged(false);
    }

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
    _pushBoundCleanupTimer?.cancel();
    _pushBoundCleanupTimer = null;
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
        _logger.warning('IsolateManager: connection failed -- $error');
        if (!(_hub?.hasSubscribers ?? false)) {
          // No main-isolate subscriber — app is closed (persistent-service mode).
          // Reconnect locally; when the app opens and subscribes, the main isolate
          // takes over reconnect decisions via SignalingReconnectController.
          _scheduleReconnect(recommendedReconnectDelay);
        }
      // else: delegated to SignalingReconnectController in the main isolate.
      case SignalingHandshakeReceived(:final handshake):
        _logger.info('IsolateManager: handshake lines=${handshake.lines}');
      case SignalingProtocolEvent(:final event):
        _logger.info('IsolateManager: protocol event ${event.runtimeType}');
        if (event is IncomingCallEvent) {
          _dispatchIncomingCall(event);
        }
      case SignalingDisconnected(:final code, :final reason, :final recommendedReconnectDelay):
        _logger.info('IsolateManager: disconnected code=$code reason=$reason');
        if (!(_hub?.hasSubscribers ?? false)) {
          // No main-isolate subscriber — app is closed (persistent-service mode).
          _scheduleReconnect(recommendedReconnectDelay);
        }
      // else: delegated to SignalingReconnectController in the main isolate.
      default:
        break;
    }
  }

  /// Called by [SignalingHub] when [hasSubscribers] transitions.
  ///
  /// In pushBound mode: schedules a cleanup timer when the last subscriber
  /// leaves, and cancels it when a new subscriber arrives. When the timer fires
  /// with no subscriber present the service is asked to stop — it means the
  /// Activity never connected (call declined/missed before it launched).
  void _onHubHasSubscribersChanged(bool hasSubscribers) {
    if (hasSubscribers) {
      _pushBoundCleanupTimer?.cancel();
      _pushBoundCleanupTimer = null;
      _logger.info('pushBound: subscriber arrived — cleanup timer cancelled');
    } else {
      _pushBoundCleanupTimer?.cancel();
      _pushBoundCleanupTimer = Timer(pushBoundNoSubscriberGrace, _requestServiceStop);
      _logger.info('pushBound: no subscribers — scheduling stop in ${pushBoundNoSubscriberGrace.inSeconds}s');
    }
  }

  /// Asks Kotlin to stop the foreground service via the existing Pigeon HostApi.
  ///
  /// Called when the pushBound cleanup timer fires (no subscriber for the full
  /// grace period). Kotlin's [SignalingForegroundService.onStartCommand] returned
  /// [START_NOT_STICKY], so after [stopService] the OS will not restart the service.
  void _requestServiceStop() {
    _logger.info('pushBound: grace period elapsed with no subscribers — requesting service stop');
    final stopOverride = _testStopService;
    if (stopOverride != null) {
      stopOverride();
    } else {
      PSignalingServiceHostApi().stopService();
    }
  }

  /// Schedules an auto-reconnect for persistent-service mode (no hub subscribers).
  ///
  /// Called only when [SignalingHub.hasSubscribers] is false — i.e. the app is
  /// closed and there is no [SignalingReconnectController] in the main isolate
  /// to drive reconnect decisions. When [delay] is null the server signalled
  /// that reconnecting is not appropriate (e.g. code 1002 protocol error), so
  /// no timer is scheduled.
  void _scheduleReconnect(Duration? delay) {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    if (delay == null) return;
    _logger.info('IsolateManager: scheduling reconnect in ${delay.inMilliseconds} ms (persistent mode)');
    _reconnectTimer = Timer(delay, () {
      _reconnectTimer = null;
      if (_started && !(_signalingModule?.isConnected ?? false)) {
        _logger.info('IsolateManager: auto-reconnecting (persistent mode)');
        _signalingModule?.connect();
      }
    });
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
