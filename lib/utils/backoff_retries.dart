import 'package:logging/logging.dart';

enum RetryDelayStrategy {
  linear,
  exponential,
}

final _logger = Logger('BackoffRetries');

class BackoffRetries {
  final int? maxAttempts;
  final Duration initialDelay;
  final RetryDelayStrategy delayStrategy;
  bool _canceled = false;

  BackoffRetries({
    this.maxAttempts,
    this.initialDelay = const Duration(seconds: 2),
    this.delayStrategy = RetryDelayStrategy.exponential,
  });

  Future<T?> execute<T>(
    Future<T> Function(int attempt) action, {
    bool Function(Exception, int)? shouldRetry,
  }) async {
    int attempt = 0;
    Duration delay = initialDelay;

    while (!_canceled && (maxAttempts == null || attempt < maxAttempts!)) {
      try {
        return await action(attempt);
      } catch (e) {
        _logger.warning('Attempt $attempt failed', e);
        if (_canceled) break; // Stop if disposed

        if (e is Exception && (shouldRetry?.call(e, attempt) ?? true)) {
          attempt++;
          await Future.delayed(delay);
          if (_canceled) break; // Stop if disposed
          delay = _calculateNextDelay(delay, attempt); // Adjust delay based on strategy
        } else {
          rethrow; // Stop retrying for non-retryable errors
        }
      }
    }
    return null; // Return null if maxAttempts is reached without success
  }

  Duration _calculateNextDelay(Duration currentDelay, int attempt) {
    switch (delayStrategy) {
      case RetryDelayStrategy.linear:
        return initialDelay * (attempt + 1);
      case RetryDelayStrategy.exponential:
        return currentDelay * 2;
      default:
        return currentDelay;
    }
  }

  void cancel() {
    _canceled = true;
  }
}
