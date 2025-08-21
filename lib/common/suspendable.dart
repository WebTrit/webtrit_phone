abstract class Suspendable {
  /// Called when ongoing work should be suspended.
  /// For example, when the device goes offline or resources
  /// must be temporarily released until connectivity is restored.
  Future<void> suspend();
}
