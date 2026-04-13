import 'dart:async';
import 'dart:collection';

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

final _logger = Logger('SignalingRequestQueue');

/// Queues [Request]s that arrive before a signaling connection is ready,
/// then flushes them once the connection is established.
///
/// Handles per-request timeouts, execution retries on
/// [WebtritSignalingTransactionTimeoutException], and bulk failure on dispose.
class SignalingRequestQueue {
  SignalingRequestQueue({this.requestTimeout = const Duration(seconds: 30), this.maxRetryCount = 3});

  final Duration requestTimeout;
  final int maxRetryCount;

  final Queue<_QueuedRequest> _queue = Queue();

  bool get isEmpty => _queue.isEmpty;

  bool get isNotEmpty => _queue.isNotEmpty;

  /// Adds [request] to the queue.
  ///
  /// The returned future completes when the request is sent, or fails with
  /// [NotConnectedException] if [requestTimeout] elapses before a flush.
  Future<void> enqueue(Request request) {
    final completer = Completer<void>();
    late final _QueuedRequest entry;
    final timer = Timer(requestTimeout, () => _onTimeout(entry));
    entry = _QueuedRequest(request: request, completer: completer, timer: timer);
    _queue.add(entry);
    return completer.future;
  }

  /// Drains the queue using [execute] as the sender.
  ///
  /// Stops when the queue is empty or [isActive] returns false.
  /// Each request is retried up to [maxRetryCount] times on
  /// [WebtritSignalingTransactionTimeoutException].
  Future<void> flush({required Future<void> Function(Request) execute, required bool Function() isActive}) async {
    while (_queue.isNotEmpty && isActive()) {
      final entry = _queue.first;
      try {
        await _executeWithRetry(execute, entry.request, isActive);
        _queue.removeFirst();
        entry.timer.cancel();
        if (!entry.completer.isCompleted) entry.completer.complete();
      } catch (error, stackTrace) {
        if (!isActive()) return;
        _queue.removeFirst();
        entry.timer.cancel();
        if (!entry.completer.isCompleted) entry.completer.completeError(error, stackTrace);
      }
    }
  }

  /// Executes [request] immediately via [execute] with up to [maxRetryCount] retries.
  ///
  /// Stops retrying if [isActive] returns false (e.g. the connection was replaced).
  /// A [NotConnectedException] during an inactive period is dropped silently so
  /// callers are not burdened with transient reconnect-window errors.
  Future<void> executeNow({
    required Future<void> Function(Request) execute,
    required Request request,
    required bool Function() isActive,
  }) async {
    try {
      await _executeWithRetry(execute, request, isActive);
    } on NotConnectedException {
      if (!isActive()) return;
      rethrow;
    }
  }

  /// Fails every pending request with [error] and clears the queue.
  void failAll(Object error) {
    while (_queue.isNotEmpty) {
      final entry = _queue.removeFirst();
      entry.timer.cancel();
      if (!entry.completer.isCompleted) entry.completer.completeError(error);
    }
  }

  // ---------------------------------------------------------------------------

  Future<void> _executeWithRetry(
    Future<void> Function(Request) execute,
    Request request,
    bool Function() isActive, [
    int retryCount = 0,
    int notConnectedRetryCount = 0,
  ]) async {
    try {
      await execute(request);
    } on WebtritSignalingTransactionTimeoutException catch (error) {
      if (!isActive() || retryCount >= maxRetryCount) rethrow;

      _logger.warning('_executeWithRetry retrying ${error.transactionId}, (retry #$retryCount)/$maxRetryCount');
      return _executeWithRetry(execute, request, isActive, retryCount + 1, notConnectedRetryCount);
    } on NotConnectedException {
      if (!isActive()) rethrow;
      if (notConnectedRetryCount >= maxRetryCount) rethrow;

      _logger.fine(
        '_executeWithRetry: not connected (attempt $notConnectedRetryCount/$maxRetryCount), backing off 2 s',
      );
      await Future<void>.delayed(const Duration(seconds: 2));
      if (!isActive()) rethrow;
      return _executeWithRetry(execute, request, isActive, retryCount, notConnectedRetryCount + 1);
    }
  }

  void _onTimeout(_QueuedRequest entry) {
    if (!_queue.remove(entry)) return;
    if (!entry.completer.isCompleted) {
      entry.completer.completeError(
        NotConnectedException('Timeout waiting for signaling connection to send request: ${entry.request}'),
      );
    }
  }
}

class _QueuedRequest {
  _QueuedRequest({required this.request, required this.completer, required this.timer});

  final Request request;
  final Completer<void> completer;
  final Timer timer;
}

/// Thrown when a [Request] cannot be sent because the signaling module is not connected.
class NotConnectedException implements Exception {
  NotConnectedException([this.message = 'Signaling client is not connected']);

  final String message;

  @override
  String toString() => 'NotConnectedException: $message';
}
