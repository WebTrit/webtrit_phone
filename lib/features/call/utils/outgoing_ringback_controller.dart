import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';

final _logger = Logger('OutgoingRingbackController');

/// Owns when the app's own ringback tone is heard on an outgoing call.
///
/// The rules it keeps in one place:
/// - a ringing answer does not start the tone right away. Operators that play a
///   ringback of their own announce the call as ringing first and send the audio
///   a moment later, so the tone waits out that gap and starts only if nothing
///   arrives. Repeated ringing answers (a forking switch) keep the ORIGINAL
///   deadline - they must not push the start out again and again;
/// - when the wait is over the caller is asked again whether the tone is still
///   wanted, so a call that was answered, ended or picked up network audio in
///   the meantime stays silent;
/// - the tone itself is one per application, so it goes silent only when the
///   LAST call that switched it on stops - ending a call on one line must not
///   silence a tone another line still needs.
///
/// The sound itself is injected as [play] / [stop], which keeps this class free
/// of the plugin layer and trivial to test.
class OutgoingRingbackController {
  OutgoingRingbackController({
    required Future<void> Function() play,
    required Future<void> Function() stop,
    this.startDelay = kOutgoingRingbackStartDelay,
  }) : _play = play,
       _stop = stop;

  final Future<void> Function() _play;
  final Future<void> Function() _stop;
  final Duration startDelay;

  /// Pending delayed starts, keyed by callId. Plain timers on purpose: a
  /// debounce would restart the countdown on every repeated ringing answer and
  /// starve the tone for as long as the branches keep ringing.
  final _pendingStart = <String, Timer>{};

  /// Calls that switched the (single, app-wide) tone on.
  final _audible = <String>{};

  /// A ringing answer arrived for [callId].
  ///
  /// [stillWanted] is evaluated when the delay elapses, not now, so it must
  /// read the current call state rather than a captured copy - it is what keeps
  /// the tone off once the network already streams audio of its own.
  void ringing(String callId, {required bool Function() stillWanted}) {
    if (_pendingStart.containsKey(callId)) return; // keep the original deadline
    _pendingStart[callId] = Timer(startDelay, () {
      _pendingStart.remove(callId);
      _startTone(callId, stillWanted);
    });
  }

  /// The network ruled out audio of its own for [callId] - a plain alerting
  /// answer arrived. Fires the pending start right away instead of waiting out
  /// the rest of the window; [stillWanted] still has the last word, which is
  /// what keeps the tone off when a trailing plain answer follows early media.
  void startNow(String callId, {required bool Function() stillWanted}) {
    _pendingStart.remove(callId)?.cancel();
    _startTone(callId, stillWanted);
  }

  void _startTone(String callId, bool Function() stillWanted) {
    if (!stillWanted()) {
      _logger.info('local ringback suppressed (callId: $callId)');
      return;
    }
    _audible.add(callId);
    // A playback failure must not take the call setup down with it, but it may
    // not vanish either - a caller left without any tone is worth a trace.
    unawaited(
      _play().catchError((Object error, StackTrace stackTrace) {
        _logger.warning('failed to start the local ringback (callId: $callId)', error, stackTrace);
      }),
    );
  }

  /// The ringing phase of [callId] is over: network audio took over, the call
  /// was answered, ended or failed. The tone actually goes silent only when no
  /// other call keeps it on.
  Future<void> stop(String callId) async {
    _pendingStart.remove(callId)?.cancel();
    _audible.remove(callId);
    if (_audible.isEmpty) await _stop();
  }

  /// Fire-and-forget variant for paths that must not await the sound.
  void stopUnawaited(String callId) => stop(callId).ignore();

  /// Silences the tone regardless of which call owns it (bloc shutdown, state
  /// reset). Pending starts are dropped as well.
  Future<void> stopAll() async {
    _cancelPending();
    _audible.clear();
    await _stop();
  }

  void dispose() => _cancelPending();

  void _cancelPending() {
    for (final timer in _pendingStart.values) {
      timer.cancel();
    }
    _pendingStart.clear();
  }
}
