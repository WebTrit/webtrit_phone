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
///   arrives. Further ringing answers change nothing while the call is already
///   waiting or already audible;
/// - [isWanted] is the single authority on whether a call still wants the tone,
///   and it is asked at the moment the tone would actually play - a call that
///   was answered, ended or picked up network audio in the meantime stays
///   silent;
/// - the tone itself is one per application, so it keeps playing while ANY call
///   still wants it. Every stop re-checks the remaining owners through
///   [isWanted], so a call that vanished without its own stop cannot keep the
///   tone alive.
///
/// The sound is injected as [play] / [stop], which keeps this class free of the
/// plugin layer and trivial to test.
class OutgoingRingbackController {
  OutgoingRingbackController({
    required Future<void> Function() play,
    required Future<void> Function() stop,
    required bool Function(String callId) isWanted,
    this.startDelay = kOutgoingRingbackStartDelay,
  }) : _play = play,
       _stop = stop,
       _isWanted = isWanted;

  final Future<void> Function() _play;
  final Future<void> Function() _stop;
  final bool Function(String callId) _isWanted;
  final Duration startDelay;

  /// Pending delayed starts, keyed by callId. Plain timers on purpose: a
  /// debounce would restart the countdown on every repeated ringing answer and
  /// starve the tone for as long as the branches keep ringing.
  final _pendingStart = <String, Timer>{};

  /// Calls that switched the (single, app-wide) tone on.
  final _audible = <String>{};

  /// A ringing answer arrived for [callId] - arm the delayed start unless this
  /// call is already waiting or already audible.
  void ringing(String callId) {
    if (_pendingStart.containsKey(callId) || _audible.contains(callId)) return;
    _pendingStart[callId] = Timer(startDelay, () {
      _pendingStart.remove(callId);
      _startTone(callId);
    });
  }

  /// The network ruled out audio of its own for [callId] - a plain alerting
  /// answer arrived. Starts the tone right away instead of waiting out the rest
  /// of the window; [isWanted] still has the last word, which is what keeps the
  /// tone off when a trailing plain answer follows early media.
  void startNow(String callId) {
    _pendingStart.remove(callId)?.cancel();
    _startTone(callId);
  }

  /// Drops a pending start without touching the tone - used while the outcome
  /// is still unknown (early media is being wired up). Re-arm with [ringing]
  /// if it turns out no network audio is coming after all.
  void holdPending(String callId) => _pendingStart.remove(callId)?.cancel();

  void _startTone(String callId) {
    if (!_isWanted(callId)) {
      _logger.info('local ringback suppressed (callId: $callId)');
      return;
    }
    if (!_audible.add(callId)) return; // already playing for this call
    // A playback failure must not take the call setup down with it, but it may
    // not vanish either - a caller left without any tone is worth a trace.
    unawaited(
      _play().catchError((Object error, StackTrace stackTrace) {
        _logger.warning('failed to start the local ringback (callId: $callId)', error, stackTrace);
      }),
    );
  }

  /// The ringing phase of [callId] is over: network audio took over, the call
  /// was answered, ended or failed. The tone goes silent once no remaining
  /// owner still wants it.
  Future<void> stop(String callId) async {
    _pendingStart.remove(callId)?.cancel();
    _audible.remove(callId);
    // Owners that no longer want the tone (a call torn down through a path that
    // never reached us, a teardown event dropped by its transformer) must not
    // keep it alive.
    _audible.removeWhere((id) => !_isWanted(id));
    if (_audible.isEmpty) await _stop();
  }

  /// Fire-and-forget variant for paths that must not await the sound.
  void stopUnawaited(String callId) => stop(callId).ignore();

  /// Silences the tone regardless of which call owns it (bloc shutdown, state
  /// reset). Pending starts are dropped as well.
  Future<void> stopAll() async {
    dispose();
    await _stop();
  }

  /// Drops every pending start. Leaves the sound alone - use [stopAll] to
  /// silence it too.
  void dispose() {
    for (final timer in _pendingStart.values) {
      timer.cancel();
    }
    _pendingStart.clear();
    _audible.clear();
  }
}
