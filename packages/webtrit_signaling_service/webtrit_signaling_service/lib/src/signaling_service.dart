import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

export 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart'
    show
        SignalingModuleEvent,
        SignalingModuleFactory,
        SignalingModule,
        SignalingModuleImpl,
        SignalingClientFactory,
        SignalingConnecting,
        SignalingConnected,
        SignalingConnectionFailed,
        SignalingDisconnecting,
        SignalingDisconnected,
        SignalingHandshakeReceived,
        SignalingProtocolEvent,
        SignalingServiceConfig,
        SignalingServiceMode,
        SignalingEventBuffer,
        SignalingRequestQueue,
        createSignalingModule,
        NotConnectedException;

final _logger = Logger('WebtritSignalingService');

/// Public entry point for the signaling service plugin.
///
/// Implements [SignalingModule] so [CallBloc] can use it directly.
///
/// Lifecycle:
///   - [connect] -- starts the underlying platform service. Idempotent: if a
///     start is already in progress or the hub is already connected, the call
///     is a no-op.
///   - [disconnect] -- intentional no-op; the service stays connected while
///     the app is backgrounded so incoming calls arrive via WebSocket.
///   - [execute] -- queues requests while not connected; flushes on connect.
///   - [dispose] -- cancels the events subscription, fails all queued
///     requests, and releases platform resources.
///
/// Static setup (call once during app bootstrap before creating instances):
///   - [setModuleFactory] -- registers the [SignalingModule] factory for
///     the background isolate.
///   - [setIncomingCallHandler] -- registers the incoming call callback for
///     background handling.
///   - [updateMode] -- switches the service lifecycle mode.
class WebtritSignalingService implements SignalingModule {
  WebtritSignalingService({
    required SignalingServiceConfig config,
    SignalingServiceMode mode = SignalingServiceMode.persistent,
    Duration startPendingTimeout = const Duration(seconds: 30),
  }) : _config = config,
       _mode = mode,
       _startPendingTimeout = startPendingTimeout {
    _serviceEventsSub = SignalingServicePlatform.instance.events.listen((event) {
      switch (event) {
        case SignalingConnected():
          _isConnected = true;
          _clearStartPending();
          unawaited(
            _requestQueue.flush(execute: SignalingServicePlatform.instance.execute, isActive: () => _isConnected),
          );
        case SignalingDisconnected():
        case SignalingConnectionFailed():
          _isConnected = false;
          _clearStartPending();
        default:
          break;
      }
    });
  }

  final SignalingServiceConfig _config;
  final SignalingServiceMode _mode;
  final Duration _startPendingTimeout;
  final _requestQueue = SignalingRequestQueue();

  StreamSubscription<SignalingModuleEvent>? _serviceEventsSub;
  bool _isConnected = false;
  bool _isDisposed = false;

  /// True while [connect] has been called but a terminal event
  /// ([SignalingConnected], [SignalingDisconnected], [SignalingConnectionFailed])
  /// has not yet been received.
  ///
  /// Prevents [connect] from restarting the hub init loop while it is still
  /// running, which would clear the [IsolateNameServer] hub port and prevent
  /// the loop from completing on Android.
  bool _startPending = false;

  /// Fires [_startPendingTimeout] after [connect] is called if no terminal
  /// event arrives. Resets [_startPending] and retries [connect] to recover
  /// from a background isolate that accepted the connect command but stopped
  /// sending events (e.g. a TCP-level hang with no OS timeout).
  Timer? _startPendingTimer;

  @override
  Stream<SignalingModuleEvent> get events => SignalingServicePlatform.instance.events;

  @override
  bool get isConnected => _isConnected;

  /// Starts the signaling service and initiates a WebSocket connection.
  ///
  /// No-op when the service has been disposed ([_isDisposed]), a start is
  /// already in progress ([_startPending]), or the hub is already connected
  /// ([_isConnected]).
  ///
  /// ## Self-healing on stuck start
  ///
  /// [_startPending] is set to `true` on entry and cleared only when a terminal
  /// event ([SignalingConnected], [SignalingDisconnected], [SignalingConnectionFailed])
  /// arrives from the background isolate. In practice two failure modes can
  /// prevent that event from ever arriving:
  ///
  /// 1. **TCP-level hang**: the background isolate starts a WebSocket upgrade
  ///    whose TCP connect stalls (e.g. a middlebox drops SYN packets silently).
  ///    Android's default TCP timeout can exceed 10 minutes, so no OS error is
  ///    delivered within a reasonable time and the isolate never emits a failure
  ///    event.
  ///
  /// 2. **Background-isolate state mismatch**: after the app resumes from
  ///    background the [SignalingReconnectController] calls [connect] via a
  ///    one-shot [_reconnectTimer]. If [_startPending] is already `true` from a
  ///    prior background attempt that stalled, the call is silently discarded.
  ///    [SignalingReconnectController] has no periodic timer — it reschedules
  ///    only on terminal events or external lifecycle notifications — so the
  ///    reconnect loop goes silent until the next user-visible lifecycle change.
  ///
  /// To recover without waiting for an external trigger, a [_startPendingTimer]
  /// is armed on every [connect] call. If [_startPendingTimeout] elapses with
  /// no terminal event, [_startPending] is reset and [connect] is retried.
  /// The timer is cancelled immediately when a terminal event arrives, so it
  /// has no effect during normal operation.
  @override
  void connect() {
    if (_isDisposed || _startPending || _isConnected) return;
    _startPending = true;
    _startPendingTimer?.cancel();
    _startPendingTimer = Timer(_startPendingTimeout, () {
      _logger.warning('connect: no terminal event after $_startPendingTimeout — resetting and retrying');
      _startPending = false;
      _startPendingTimer = null;
      connect();
    });
    SignalingServicePlatform.instance.start(_config, mode: _mode).catchError((Object e, StackTrace s) {
      _logger.severe('connect: start() failed', e, s);
      _clearStartPending();
    });
  }

  void _clearStartPending() {
    _startPending = false;
    _startPendingTimer?.cancel();
    _startPendingTimer = null;
  }

  /// No-op -- intentional. The service stays connected while the app is
  /// backgrounded so incoming calls arrive via WebSocket without push.
  @override
  Future<void> disconnect() async {}

  @override
  Future<void>? execute(Request request) {
    if (_isConnected) {
      return _requestQueue
          .executeNow(
            execute: SignalingServicePlatform.instance.execute,
            request: request,
            isActive: () => _isConnected,
          )
          .catchError((Object e, StackTrace s) {
            if (e is NotConnectedException) {
              _logger.warning('execute: ghost state detected — forcing reconnect', e, s);
              _isConnected = false;
              connect();
            }
            Error.throwWithStackTrace(e, s);
          });
    }
    return _requestQueue.enqueue(request);
  }

  @override
  void cancelRequestsByCallId(String callId) {
    _requestQueue.cancelByCallId(callId);
  }

  @override
  void clearTerminatingMark(String callId) {
    _requestQueue.removeTerminatingMark(callId);
  }

  @override
  Future<void> dispose() async {
    _isDisposed = true;
    _requestQueue.failAll(NotConnectedException('WebtritSignalingService is disposed'));
    await _serviceEventsSub?.cancel();
    _serviceEventsSub = null;
    _isConnected = false;
    _clearStartPending();
    await SignalingServicePlatform.instance.dispose();
  }

  // ---------------------------------------------------------------------------
  // Static setup — configure the platform singleton during app bootstrap.
  // Must be called before creating any WebtritSignalingService instance.
  // ---------------------------------------------------------------------------

  /// Registers the factory used to create [SignalingModule] instances.
  ///
  /// On Android [factory] must be a top-level function annotated with
  /// [@pragma('vm:entry-point')] so [PluginUtilities] can serialize its handle
  /// for the foreground-service background isolate. Must be called before
  /// [WebtritSignalingService.new].
  static Future<void> setModuleFactory(SignalingModuleFactory factory) =>
      SignalingServicePlatform.instance.setModuleFactory(factory);

  /// Registers the app-side incoming call callback for background handling.
  ///
  /// [callback] must be a top-level function annotated with
  /// [@pragma('vm:entry-point')]. Must be called before
  /// [WebtritSignalingService.new].
  static Future<void> setIncomingCallHandler(Function callback) =>
      SignalingServicePlatform.instance.setIncomingCallHandler(callback);

  /// Connects to an already-running service hub without starting a new service.
  ///
  /// Call this from the main isolate when the Activity opens after a push has
  /// already started the service in [SignalingServiceMode.pushBound]. No-op on
  /// iOS.
  static Future<void> attach() => SignalingServicePlatform.instance.attach();

  /// Switches the service lifecycle mode without restarting the connection.
  static Future<void> updateMode(SignalingServiceMode mode) => SignalingServicePlatform.instance.updateMode(mode);

  /// Stops the native signaling service and clears stored credentials.
  ///
  /// Call on explicit user logout to prevent the service from reconnecting
  /// with a stale token after the session ends. No-op on iOS.
  static Future<void> stopService() => SignalingServicePlatform.instance.stopService();

  /// Restores the persistent foreground service if it was killed by the OS.
  ///
  /// Call from the push-notification callback after the temporary push WebSocket
  /// is disposed to bring back the persistent connection for future calls.
  /// No-op on iOS and when push mode is active or the service is already running.
  static Future<void> restoreService() => SignalingServicePlatform.instance.restoreService();

  /// Stops the foreground service immediately without a graceful WebSocket
  /// disconnect, simulating an abrupt OS kill.
  ///
  /// Credentials in SharedPreferences are preserved so that WorkManager and
  /// START_STICKY can restart the service automatically — the same recovery
  /// path that fires after a real OS kill.
  ///
  /// No-op on iOS. Intended for debug/QA use only to verify service-restart behaviour.
  static Future<void> simulateKill() => SignalingServicePlatform.instance.simulateKill();
}
