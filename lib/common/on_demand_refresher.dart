/// A domain-facing port for an immediate, caller-driven refresh.
///
/// Declared by the consumer (e.g. a bloc handling pull-to-refresh) and
/// implemented by whoever owns the refresh cadence, so a forced refresh can
/// never race a scheduled one. Errors are not swallowed: the caller decides
/// how to surface a failed refresh.
abstract class OnDemandRefresher {
  /// Refreshes immediately and pushes the next scheduled refresh a full
  /// interval away from this one's completion. Throws when the refresh fails.
  Future<void> refreshNow();
}
