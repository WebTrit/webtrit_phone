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
/// When an [IncomingCallEvent] or [HangupEvent] arrives and
/// [callEventHandlerHandle] is non-zero, the manager resolves the registered
/// Dart callback via [PluginUtilities.getCallbackFromHandle] and invokes it
/// with the event so that the app side can drive callkeep without depending on
/// the main isolate being alive.
class SignalingForegroundIsolateManager {
  SignalingForegroundIsolateManager({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    this.trustedCertificatesJson,
    this.callEventHandlerHandle = 0,
    this.moduleFactoryHandle = 0,
    this.safetyReconnectGrace = const Duration(seconds: 2),
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

  /// Raw handle for the app-side call-event callback.
  ///
  /// Registered by the app via [WebtritSignalingService.setCallEventHandler].
  /// 0 means no handler is registered -- call events are only forwarded to the
  /// hub (main isolate) and silently ignored in the background.
  /// Mutable so it can be updated in-place when the Activity re-registers the
  /// handler without requiring a WebSocket restart.
  int callEventHandlerHandle;

  /// Raw handle for the app-side [SignalingModuleFactory] callback.
  ///
  /// Registered by the app via [WebtritSignalingService.setModuleFactory].
  /// 0 means no factory is registered -- the isolate will log an error and skip start.
  /// Mutable so it can be updated in-place without requiring a WebSocket restart.
  int moduleFactoryHandle;

  /// Extra time added on top of [recommendedReconnectDelay] before the safety
  /// reconnect fires when the main isolate's sync does not arrive.
  ///
  /// Defaults to 2 s, which gives the main isolate's round-trip path
  /// (startService → onStartCommand → synchronizeIsolate → Pigeon → handleStatus)
  /// enough headroom to cancel the timer before it fires. Exposed as a
  /// constructor parameter so tests can use small values without sleeping.
  final Duration safetyReconnectGrace;

  /// Overrides handle-based [SignalingModule] creation in tests.
  final SignalingModuleFactory? _testModuleFactory;

  /// Overrides [SignalingHub] construction in tests to avoid [IsolateNameServer].
  final SignalingHubFactory? _testHubFactory;

  SignalingModule? _signalingModule;
  SignalingHub? _hub;

  StreamSubscription<SignalingModuleEvent>? _eventsSubscription;
  Timer? _reconnectTimer;

  bool _started = false;

  /// True when the hub is tracking at least one active call.
  ///
  /// Delegated to [SignalingHub.hasActiveCalls] so that [SignalingSyncHandler]
  /// can skip manager recreation while a call is in progress.
  bool get hasActiveCalls => _hub?.hasActiveCalls ?? false;

  /// Updates runtime handles in-place without restarting the WebSocket connection.
  ///
  /// Called by [SignalingSyncHandler] when only [callEventHandlerHandle] or
  /// [moduleFactoryHandle] changed — e.g. when the Activity re-registers them
  /// after opening from a push notification. Neither handle affects the live
  /// WebSocket session, so no reconnect is needed.
  void updateHandles({required int callEventHandlerHandle, required int moduleFactoryHandle}) {
    this.callEventHandlerHandle = callEventHandlerHandle;
    this.moduleFactoryHandle = moduleFactoryHandle;
    _logger.info(
      'SignalingForegroundIsolateManager handles updated in-place '
      'callEventHandlerHandle=$callEventHandlerHandle moduleFactoryHandle=$moduleFactoryHandle',
    );
  }

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

    _logger.info('SignalingForegroundIsolateManager starting (callEventHandler=${callEventHandlerHandle != 0})');

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
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
      case SignalingConnectionFailed(:final error, :final recommendedReconnectDelay):
        _logger.warning('IsolateManager: connection failed -- $error');
        if (!(_hub?.hasSubscribers ?? false)) {
          // No main-isolate subscriber — app is closed (persistent-service mode).
          // Reconnect locally; when the app opens and subscribes, the main isolate
          // takes over reconnect decisions via SignalingReconnectController.
          _scheduleReconnect(recommendedReconnectDelay);
        } else {
          // Main isolate handles reconnect via SignalingReconnectController.
          // Schedule a safety fallback in case the sync round-trip (startService →
          // onStartCommand → synchronizeIsolate → Pigeon → handleStatus) fails to
          // reach this isolate. Cancelled by _start() when the sync arrives normally.
          _scheduleSafetyReconnect(recommendedReconnectDelay);
        }
      case SignalingHandshakeReceived(:final handshake):
        _logger.info('IsolateManager: handshake lines=${handshake.lines}');
      case SignalingProtocolEvent(:final event):
        _logger.info('IsolateManager: protocol event ${event.runtimeType}');
        if (event is IncomingCallEvent || event is HangupEvent) {
          _dispatchCallEvent(event as CallEvent);
        }
      case SignalingDisconnected(:final code, :final reason, :final recommendedReconnectDelay):
        _logger.info('IsolateManager: disconnected code=$code reason=$reason');
        if (!(_hub?.hasSubscribers ?? false)) {
          // No main-isolate subscriber — app is closed (persistent-service mode).
          _scheduleReconnect(recommendedReconnectDelay);
        } else {
          // Main isolate handles reconnect via SignalingReconnectController.
          // Schedule a safety fallback in case the sync round-trip (startService →
          // onStartCommand → synchronizeIsolate → Pigeon → handleStatus) fails to
          // reach this isolate. Cancelled by _start() when the sync arrives normally.
          _scheduleSafetyReconnect(recommendedReconnectDelay);
        }
      default:
        break;
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

  /// Schedules a safety fallback reconnect for use when [SignalingHub.hasSubscribers]
  /// is true (app foreground).
  ///
  /// The main isolate's [SignalingReconnectController] drives reconnect via a
  /// round-trip: startService → onStartCommand → synchronizeIsolate (Pigeon) →
  /// handleStatus → _start. If any step in that chain fails (e.g. Pigeon message
  /// dropped on MIUI, pendingSync queue stuck), no reconnect ever fires.
  ///
  /// This timer fires [baseDelay] + [safetyReconnectGrace] after the disconnect,
  /// giving the main isolate's path priority. When the normal path works, [_start]
  /// cancels [_reconnectTimer] before this window expires. A redundant [connect]
  /// call while the module is already connected is prevented by the
  /// [!isConnected] guard in the timer callback.
  void _scheduleSafetyReconnect(Duration? baseDelay) {
    if (baseDelay == null) return;
    final safetyDelay = baseDelay + safetyReconnectGrace;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _logger.info('IsolateManager: scheduling safety reconnect in ${safetyDelay.inMilliseconds} ms');
    _reconnectTimer = Timer(safetyDelay, () {
      _reconnectTimer = null;
      if (_started && !(_signalingModule?.isConnected ?? false)) {
        _logger.warning('IsolateManager: safety reconnect triggered — main isolate sync did not arrive');
        _signalingModule?.connect();
      }
    });
  }

  /// Invokes the app-registered call-event callback in this background isolate.
  ///
  /// The callback is a top-level Dart function annotated with
  /// [@pragma('vm:entry-point')] that the app registered via
  /// [WebtritSignalingService.setCallEventHandler]. It receives a signaling
  /// [Event] and is responsible for callkeep integration - creating a call for
  /// [IncomingCallEvent] and releasing it for [HangupEvent].
  void _dispatchCallEvent(CallEvent event) {
    if (callEventHandlerHandle == 0) {
      _logger.warning(
        'IsolateManager: ${event.runtimeType} received but no call-event handler registered -- event will be ignored in background',
      );
      return;
    }

    final callback = PluginUtilities.getCallbackFromHandle(CallbackHandle.fromRawHandle(callEventHandlerHandle));
    if (callback == null) {
      _logger.severe('IsolateManager: could not resolve call-event handler from handle $callEventHandlerHandle');
      return;
    }

    _logger.info('IsolateManager: dispatching ${event.runtimeType} callId=${event.callId} to app handler');
    try {
      // Use Function.apply so both sync and async callbacks work.
      final dynamic result = Function.apply(callback, [event]);
      if (result is Future<dynamic>) {
        result.catchError((Object e, StackTrace st) {
          _logger.severe('IsolateManager: call-event handler async error', e, st);
        });
      }
    } catch (e, st) {
      _logger.severe('IsolateManager: call-event handler threw', e, st);
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
