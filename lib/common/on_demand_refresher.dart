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

/// The on-demand refresh of the external contact list.
///
/// A marker over [OnDemandRefresher]: dependency lookup resolves by type, so
/// each refreshed data source gets its own narrow port and a consumer can
/// never receive another source's refresher by accident. The semantics are
/// entirely those of the base contract.
abstract class ContactsRefresher implements OnDemandRefresher {}
