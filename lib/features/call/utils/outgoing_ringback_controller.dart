import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/utils/utils.dart';

final _logger = Logger('OutgoingRingbackController');

/// Owns when the app's own ringback tone is heard on an outgoing call.
///
/// The rules it keeps in one place:
/// - a ringing answer does not start the tone right away. Operators that play a
///   ringback of their own announce the call as ringing first and send the audio
///   a moment later, so the tone waits out that gap and starts only if nothing
///   arrives;
/// - when the wait is over the caller is asked again whether the tone is still
///   wanted, so a call that was answered, ended or picked up network audio in
///   the meantime stays silent;
/// - anything that ends the ringing phase (network audio, answer, hangup, a
///   failure) stops the tone and drops a pending start.
///
/// The sound itself is injected as [play] / [stop], which keeps this class free
/// of the plugin layer and trivial to test.
class OutgoingRingbackController {
  OutgoingRingbackController({
    required Future<void> Function() play,
    required Future<void> Function() stop,
    Duration startDelay = kOutgoingRingbackStartDelay,
  }) : _play = play,
       _stop = stop,
       _pendingStart = DebounceMap<String>(startDelay);

  final Future<void> Function() _play;
  final Future<void> Function() _stop;

  /// Pending starts, keyed by callId - one line never delays or cancels another.
  final DebounceMap<String> _pendingStart;

  /// A ringing answer arrived for [callId].
  ///
  /// [stillWanted] is evaluated when the delay elapses, not now, so it must
  /// read the current call state rather than a captured copy - it is what keeps
  /// the tone off once the network already streams audio of its own.
  void ringing(String callId, {required bool Function() stillWanted}) {
    _pendingStart.schedule(callId, () {
      if (!stillWanted()) {
        _logger.info('ringing: local ringback suppressed (callId: $callId)');
        return;
      }
      _play().ignore();
    });
  }

  /// The network ruled out audio of its own for [callId] - a plain alerting
  /// answer arrived. Fires the pending start right away instead of waiting out
  /// the rest of the window; [stillWanted] still has the last word, which is
  /// what keeps the tone off when a trailing plain answer follows early media.
  void startNow(String callId, {required bool Function() stillWanted}) {
    _pendingStart.cancel(callId);
    if (!stillWanted()) {
      _logger.info('startNow: local ringback suppressed (callId: $callId)');
      return;
    }
    _play().ignore();
  }

  /// The ringing phase of [callId] is over: network audio took over, the call was
  /// answered, ended or failed.
  Future<void> stop(String callId) async {
    _pendingStart.cancel(callId);
    await _stop();
  }

  /// Fire-and-forget variant for paths that must not await the sound.
  void stopUnawaited(String callId) => stop(callId).ignore();

  /// Silences the tone regardless of which call owns it (bloc shutdown, state
  /// reset). Pending starts are dropped as well.
  Future<void> stopAll() async {
    _pendingStart.dispose();
    await _stop();
  }

  void dispose() => _pendingStart.dispose();
}
