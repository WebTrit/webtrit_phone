import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

/// Adapts [WebtritSignalingService] to [SignalingModule] so that
/// [CallBloc] can use the signaling service without knowing the underlying
/// transport (foreground service on Android, direct on iOS).
///
/// Lifecycle:
///   - [connect] -- starts the service via [WebtritSignalingService.start].
///     Idempotent: if [start] is already in progress or the hub is already
///     connected, the call is a no-op. This prevents [CallBloc]'s reconnect
///     timer from restarting the hub init loop while it is still running,
///     which would cause a generation-mismatch cycle where the loop is killed
///     and restarted before it can connect.
///   - [disconnect] -- intentional no-op. In persistent mode the service runs
///     inside an Android foreground service and is designed to stay connected
///     while the app is backgrounded. Honouring a disconnect would defeat the
///     purpose of the persistent service.
///   - [execute] -- when connected, sends the request immediately with up to
///     [SignalingRequestQueue.maxRetryCount] retries on timeout. When not
///     connected, queues the request and sends it on the next successful
///     connection, or fails with [NotConnectedException] after
///     [SignalingRequestQueue.requestTimeout].
///   - [dispose] -- cancels the service events subscription, closes the local
///     events controller, fails all queued requests, and calls
///     [WebtritSignalingService.dispose] to release Dart-side hub resources.
///     On Android the foreground service itself is NOT stopped -- its lifecycle
///     is managed by Kotlin.
final _logger = Logger('SignalingServiceModuleAdapter');

class SignalingServiceModuleAdapter implements SignalingModule {
  SignalingServiceModuleAdapter({
    required WebtritSignalingService service,
    required SignalingServiceConfig config,
    SignalingServiceMode mode = SignalingServiceMode.persistent,
  }) : _service = service,
       _config = config,
       _mode = mode;

  final WebtritSignalingService _service;
  final SignalingServiceConfig _config;
  final SignalingServiceMode _mode;

  final _eventsController = StreamController<SignalingModuleEvent>.broadcast();
  StreamSubscription<SignalingModuleEvent>? _serviceEventsSub;
  final _eventBuffer = SignalingEventBuffer();
  final _requestQueue = SignalingRequestQueue();

  bool _isConnected = false;

  /// True while [start] has been called but [SignalingConnected],
  /// [SignalingDisconnected], or [SignalingConnectionFailed] has not yet
  /// been received. Used to make [connect] idempotent during hub init.
  bool _startPending = false;

  @override
  Stream<SignalingModuleEvent> get events {
    return Stream.multi((sink) {
      final sub = _eventsController.stream.listen(sink.add, onError: sink.addError, onDone: sink.close);
      sink.onCancel = sub.cancel;
      for (final event in _eventBuffer.snapshot) {
        sink.add(event);
      }
    }, isBroadcast: true);
  }

  @override
  bool get isConnected => _isConnected;

  @override
  void connect() {
    // No-op if hub init is already in progress or the hub is already connected.
    // Without this guard, CallBloc's reconnect timer would call connect() on
    // every tick while the hub init loop is running, clearing the hub port
    // from IsolateNameServer each time and preventing the loop from completing.
    if (_startPending || _isConnected) return;

    _startPending = true;
    _serviceEventsSub?.cancel();
    _serviceEventsSub = _service.events.listen((event) {
      switch (event) {
        case SignalingConnected():
          _isConnected = true;
          _startPending = false;
          unawaited(_requestQueue.flush(execute: _service.execute, isActive: () => _isConnected));
        case SignalingDisconnected():
        case SignalingConnectionFailed():
          _isConnected = false;
          _startPending = false;
        default:
          break;
      }
      _eventBuffer.onEvent(event);
      _eventsController.add(event);
    }, onError: _eventsController.addError);
    _service.start(_config, mode: _mode).catchError((Object e, StackTrace s) {
      _logger.severe('start() failed', e, s);
      _startPending = false;
      _eventsController.add(
        SignalingConnectionFailed(error: e, isRepeated: false, recommendedReconnectDelay: const Duration(seconds: 5)),
      );
    });
  }

  /// No-op -- intentional. In persistent mode the service runs inside an Android
  /// foreground service and is designed to stay connected while the app is
  /// backgrounded. [CallBloc] calls [disconnect] when it goes to the background
  /// with no active calls; honouring that would defeat the purpose of the
  /// persistent service.
  @override
  Future<void> disconnect() async {}

  @override
  Future<void>? execute(Request request) {
    if (_isConnected) {
      return _requestQueue.executeNow(execute: _service.execute, request: request, isActive: () => _isConnected);
    }
    return _requestQueue.enqueue(request);
  }

  @override
  Future<void> dispose() async {
    _requestQueue.failAll(NotConnectedException('Signaling service module adapter is disposed'));
    await _serviceEventsSub?.cancel();
    _serviceEventsSub = null;
    _isConnected = false;
    _startPending = false;
    _eventBuffer.clear();
    await _eventsController.close();
    await _service.dispose();
  }
}
