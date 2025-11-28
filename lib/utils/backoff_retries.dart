import 'dart:async';
import 'package:logging/logging.dart';

enum RetryDelayStrategy { linear, exponential }

final _logger = Logger('BackoffRetries');

class BackoffRetries {
  final int? maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final RetryDelayStrategy delayStrategy;
  final Duration? shouldRetryTimeout;
  bool _canceled = false;

  BackoffRetries({
    this.maxAttempts,
    this.initialDelay = const Duration(seconds: 2),
    this.maxDelay = const Duration(seconds: 10),
    this.shouldRetryTimeout,
    this.delayStrategy = RetryDelayStrategy.linear,
  });

  Future<T?> execute<T>(
    Future<T> Function(int attempt) action, {
    FutureOr<bool> Function(Exception, int)? shouldRetry,
  }) async {
    int attempt = 0;
    Duration delay = initialDelay;

    while (!_canceled && (maxAttempts == null || attempt < maxAttempts!)) {
      try {
        return await action(attempt);
      } catch (e) {
        _logger.warning('Attempt $attempt failed', e);
        if (_canceled) break;

        if (e is Exception) {
          // Await the result. If shouldRetry is null, default to true.
          final futureOrBool = shouldRetry?.call(e, attempt) ?? true;

          final Future<bool> shouldRetryFuture;
          if (futureOrBool is Future<bool>) {
            shouldRetryFuture = futureOrBool;
          } else {
            shouldRetryFuture = Future.value(futureOrBool);
          }
          final canRetry = await shouldRetryFuture.timeout(shouldRetryTimeout ?? const Duration(seconds: 5));

          if (canRetry) {
            attempt++;
            await Future.delayed(delay);
            if (_canceled) break;
            delay = _calculateNextDelay(delay, attempt);
          } else {
            rethrow;
          }
        } else {
          rethrow;
        }
      }
    }
    return null;
  }

  Duration _calculateNextDelay(Duration currentDelay, int attempt) {
    switch (delayStrategy) {
      case RetryDelayStrategy.linear:
        final linearDelay = initialDelay * (attempt + 1);
        return linearDelay <= maxDelay ? linearDelay : maxDelay;
      case RetryDelayStrategy.exponential:
        final exponentialDelay = currentDelay * 2;
        return exponentialDelay <= maxDelay ? exponentialDelay : maxDelay;
    }
  }

  void cancel() {
    _canceled = true;
  }
}

/// Policy for calculating retry delays after consecutive errors.
abstract class BackoffPolicy {
  /// Computes next delay.
  ///
  /// [consecutiveErrors] - number of errors in a row (0 = success),
  /// [base] - base interval,
  /// [max] - optional cap for maximum delay.
  Duration next(int consecutiveErrors, Duration base, {Duration? max});
}

/// Exponential backoff: delay doubles with each error until capped.
///
/// Examples (base=5s):
/// - 0 errors -> 5s
/// - 1 error  -> 10s
/// - 2 errors -> 20s
/// - 3 errors -> 40s
class ExponentialBackoff implements BackoffPolicy {
  const ExponentialBackoff({this.max = const Duration(minutes: 5)});

  final Duration max;

  @override
  Duration next(int consecutiveErrors, Duration base, {Duration? max}) {
    if (consecutiveErrors <= 0) return base;
    final cap = max ?? this.max;
    final factor = 1 << consecutiveErrors; // 2^n
    final ms = base.inMilliseconds * factor;
    final d = Duration(milliseconds: ms);
    return d <= cap ? d : cap;
  }
}
