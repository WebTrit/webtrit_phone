import 'dart:async';

/// Waits for the independent pre-render startup branches and returns the value
/// built by [bootstrap].
///
/// Both futures must already be started before this function is called. If
/// [systemUi] fails after [bootstrap] succeeds, [disposeBootstrapResult]
/// releases the value that cannot be handed to the widget tree. Cleanup errors
/// are contained so they cannot mask the original startup failure.
Future<T> waitForStartup<T>({
  required Future<void> systemUi,
  required Future<T> bootstrap,
  required FutureOr<void> Function(T value) disposeBootstrapResult,
}) async {
  T? bootstrapResult;
  var hasBootstrapResult = false;

  try {
    await Future.wait<void>([
      systemUi,
      bootstrap.then((value) {
        bootstrapResult = value;
        hasBootstrapResult = true;
      }),
    ]);
    return bootstrapResult as T;
  } catch (error, stackTrace) {
    if (hasBootstrapResult) {
      try {
        await disposeBootstrapResult(bootstrapResult as T);
      } catch (_) {
        // Teardown must not replace the failure that prevented startup.
      }
    }
    Error.throwWithStackTrace(error, stackTrace);
  }
}
