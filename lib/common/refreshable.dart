abstract class Refreshable {
  /// Called when data needs to be refreshed.
  /// For example, after network reconnection or during polling.
  Future<void> refresh();

  /// Returns `false` when this refreshable has permanently stopped needing updates
  /// (e.g. the remote feature is not configured) and should be skipped or unregistered
  /// by polling and connectivity services.
  ///
  /// Defaults to `true`. Override to opt out of further refresh calls.
  bool get isActive => true;
}
