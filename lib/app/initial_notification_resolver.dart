import 'dart:async';

/// Resolves a notification that launched the application without imposing a
/// deadline on startup.
///
/// [onSlow] is only a watchdog signal: a slow [load] keeps running and a late
/// value is still delivered. Resolver, delivery and observer failures are
/// contained because this operation runs outside the first-frame critical path.
Future<void> resolveInitialNotification<T>({
  required Future<T?> Function() load,
  required FutureOr<void> Function(T value) deliver,
  required void Function(Object error, StackTrace stackTrace) onError,
  required void Function(Duration elapsed) onSlow,
  Duration slowThreshold = const Duration(seconds: 5),
}) async {
  final stopwatch = Stopwatch()..start();
  final watchdog = Timer(slowThreshold, () => _callSafely(() => onSlow(stopwatch.elapsed)));

  try {
    final value = await load();
    if (value != null) await deliver(value);
  } catch (error, stackTrace) {
    _callSafely(() => onError(error, stackTrace));
  } finally {
    watchdog.cancel();
    stopwatch.stop();
  }
}

void _callSafely(void Function() callback) {
  try {
    callback();
  } catch (_) {
    // Observability must not turn detached notification resolution into an
    // unhandled asynchronous error.
  }
}
