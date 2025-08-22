abstract class Refreshable {
  /// Called when data needs to be refreshed.
  /// For example, after network reconnection or during polling.
  Future<void> refresh();
}
