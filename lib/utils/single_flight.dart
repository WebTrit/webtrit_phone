import 'dart:async';

/// Collapses concurrent calls of one async operation into a single run.
///
/// The first caller starts the operation; every caller that arrives while it
/// is still running receives the same future, so they complete together and
/// share its error. The next call after completion starts a fresh run.
class SingleFlight {
  Future<void>? _inFlight;

  Future<void> run(Future<void> Function() action) {
    return _inFlight ??= action().whenComplete(() => _inFlight = null);
  }
}
