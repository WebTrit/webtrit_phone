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
  }) : _config = config,
       _mode = mode {
    _serviceEventsSub = SignalingServicePlatform.instance.events.listen((event) {
      switch (event) {
        case SignalingConnected():
          _isConnected = true;
          _startPending = false;
          unawaited(
            _requestQueue.flush(execute: SignalingServicePlatform.instance.execute, isActive: () => _isConnected),
          );
        case SignalingDisconnected():
        case SignalingConnectionFailed():
          _isConnected = false;
          _startPending = false;
        default:
          break;
      }
    });
  }

  final SignalingServiceConfig _config;
  final SignalingServiceMode _mode;
  final _requestQueue = SignalingRequestQueue();

  StreamSubscription<SignalingModuleEvent>? _serviceEventsSub;
  bool _isConnected = false;

  /// True while [connect] has been called but a terminal event
  /// ([SignalingConnected], [SignalingDisconnected], [SignalingConnectionFailed])
  /// has not yet been received.
  ///
  /// Prevents [connect] from restarting the hub init loop while it is still
  /// running, which would clear the [IsolateNameServer] hub port and prevent
  /// the loop from completing on Android.
  bool _startPending = false;

  @override
  Stream<SignalingModuleEvent> get events => SignalingServicePlatform.instance.events;

  @override
  bool get isConnected => _isConnected;

  @override
  void connect() {
    if (_startPending || _isConnected) return;
    _startPending = true;
    SignalingServicePlatform.instance.start(_config, mode: _mode).catchError((Object e, StackTrace s) {
      _logger.severe('connect: start() failed', e, s);
      _startPending = false;
    });
  }

  /// No-op -- intentional. The service stays connected while the app is
  /// backgrounded so incoming calls arrive via WebSocket without push.
  @override
  Future<void> disconnect() async {}

  @override
  Future<void>? execute(Request request) {
    if (_isConnected) {
      return _requestQueue.executeNow(
        execute: SignalingServicePlatform.instance.execute,
        request: request,
        isActive: () => _isConnected,
      );
    }
    return _requestQueue.enqueue(request);
  }

  @override
  Future<void> dispose() async {
    _requestQueue.failAll(NotConnectedException('WebtritSignalingService is disposed'));
    await _serviceEventsSub?.cancel();
    _serviceEventsSub = null;
    _isConnected = false;
    _startPending = false;
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
}
