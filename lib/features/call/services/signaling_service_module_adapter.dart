import 'dart:async';
import 'dart:collection';

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
///     [_executeTimeoutRetryCount] retries on timeout. When not connected,
///     queues the request and sends it on the next successful connection, or
///     fails with [NotConnectedException] after [_queuedRequestTimeout].
///   - [dispose] -- cancels the service events subscription, closes the local
///     events controller, fails all queued requests, and calls
///     [WebtritSignalingService.dispose] to release Dart-side hub resources.
///     On Android the foreground service itself is NOT stopped -- its lifecycle
///     is managed by Kotlin.
final _logger = Logger('SignalingServiceModuleAdapter');

const _queuedRequestTimeout = Duration(seconds: 30);
const _executeTimeoutRetryCount = 3;

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
  final Queue<_QueuedRequest> _queuedRequests = Queue<_QueuedRequest>();

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
          unawaited(_flushQueuedRequests());
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
    if (_isConnected) return _executeWithRetry(request);
    return _enqueueRequest(request);
  }

  @override
  Future<void> dispose() async {
    _failAllQueuedRequests(NotConnectedException('Signaling service module adapter is disposed'));
    await _serviceEventsSub?.cancel();
    _serviceEventsSub = null;
    _isConnected = false;
    _startPending = false;
    _eventBuffer.clear();
    await _eventsController.close();
    await _service.dispose();
  }

  Future<void> _enqueueRequest(Request request) {
    final completer = Completer<void>();
    late final _QueuedRequest queuedRequest;
    final timer = Timer(_queuedRequestTimeout, () => _onQueuedRequestTimeout(queuedRequest));
    queuedRequest = _QueuedRequest(request: request, completer: completer, timer: timer);
    _queuedRequests.add(queuedRequest);
    return completer.future;
  }

  Future<void> _flushQueuedRequests() async {
    while (_queuedRequests.isNotEmpty && _isConnected) {
      final queuedRequest = _queuedRequests.first;
      try {
        await _executeWithRetry(queuedRequest.request);
        _queuedRequests.removeFirst();
        queuedRequest.timer.cancel();
        if (!queuedRequest.completer.isCompleted) queuedRequest.completer.complete();
      } catch (error, stackTrace) {
        if (!_isConnected) return;
        _queuedRequests.removeFirst();
        queuedRequest.timer.cancel();
        if (!queuedRequest.completer.isCompleted) {
          queuedRequest.completer.completeError(error, stackTrace);
        }
      }
    }
  }

  Future<void> _executeWithRetry(Request request, [int timeoutRetry = 0]) async {
    try {
      await _service.execute(request);
    } on WebtritSignalingTransactionTimeoutException catch (error, stackTrace) {
      if (!_isConnected || timeoutRetry >= _executeTimeoutRetryCount) {
        Error.throwWithStackTrace(error, stackTrace);
      }
      _logger.warning('_executeWithRetry timeout, retrying... (retry #$timeoutRetry)', error, stackTrace);
      return _executeWithRetry(request, timeoutRetry + 1);
    }
  }

  void _onQueuedRequestTimeout(_QueuedRequest queuedRequest) {
    if (!_queuedRequests.remove(queuedRequest)) return;
    if (!queuedRequest.completer.isCompleted) {
      queuedRequest.completer.completeError(
        NotConnectedException('Timeout waiting for signaling connection to send request: ${queuedRequest.request}'),
      );
    }
  }

  void _failAllQueuedRequests(Object error) {
    while (_queuedRequests.isNotEmpty) {
      final queuedRequest = _queuedRequests.removeFirst();
      queuedRequest.timer.cancel();
      if (!queuedRequest.completer.isCompleted) queuedRequest.completer.completeError(error);
    }
  }
}

class _QueuedRequest {
  _QueuedRequest({required this.request, required this.completer, required this.timer});

  final Request request;
  final Completer<void> completer;
  final Timer timer;
}
