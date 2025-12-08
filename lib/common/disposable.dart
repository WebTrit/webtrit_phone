/// A contract for objects that hold resources which need to be explicitly released.
///
/// Typical use cases include:
/// - Closing streams
/// - Cancelling timers
/// - Releasing database connections
///
/// This is intended to be implemented by classes that have a defined lifecycle
/// and need explicit cleanup when they are no longer in use.
abstract class Disposable {
  /// Releases resources held by this object.
  ///
  /// Implementations should:
  /// - Cancel timers and subscriptions
  /// - Close streams and connections
  /// - Clear caches or other in-memory data
  ///
  /// This method is asynchronous to allow for cleanup of async resources.
  Future<void> dispose();
}

/// Calls [dispose] if the given [value] implements [Disposable].
///
/// Throws:
/// - [StateError] in release mode if the value does not implement [Disposable].
/// - In debug mode, also triggers an [assert] failure with a detailed message.
///
/// This is intended for use in dependency injection providers (e.g.,
/// `RepositoryProvider` or `Provider`) to automatically dispose resources
/// when the provided object is removed from the widget tree.
///
/// Example:
/// ```dart
/// RepositoryProvider<MyRepository>(
///   create: (_) => MyRepository(),
///   dispose: disposeIfDisposable,
/// )
/// ```
Future<void> disposeIfDisposable<T>(T value) async {
  assert(value is Disposable, 'disposeIfDisposable() called on non-Disposable: ${value.runtimeType}');

  if (value is Disposable) {
    await value.dispose();
  } else {
    throw StateError('disposeIfDisposable() called on non-Disposable: ${value.runtimeType}');
  }
}
