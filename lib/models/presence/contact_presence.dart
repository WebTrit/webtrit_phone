import '../dialog_info.dart';
import 'presence_activity.dart';
import 'presence_info.dart';

/// What a contact's status says about them, resolved from every signal that
/// carries it.
///
/// The signals arrive from two independent places - the contact's own
/// published presence and the switch's view of their calls - and each read
/// site used to combine them for itself, which is how a ringing call ended up
/// announced as a conversation. Resolve it once here instead.
///
/// Only the status mark reads this today, and only to decide whether to show
/// the in-call sign: the colour deliberately still follows plain reachability
/// (see `SipPresenceIndicator`), because giving "on a call" a colour of its
/// own is a product decision that is not taken yet. [available] and
/// [unavailable] are therefore distinguished by no caller yet - they are here
/// because the states are what the answer means, not because something reads
/// them.
enum ContactPresence {
  /// Talking right now: the switch reports an established call, or the
  /// contact publishes the on-the-phone activity (the server adds it while
  /// they have active calls, so it arrives even without BLF).
  onCall,

  /// Reachable and not on a call.
  available,

  /// Not reachable, or nothing is known about them.
  unavailable;

  static ContactPresence resolve({required List<PresenceInfo> presenceInfo, required List<DialogInfo> dialogInfo}) {
    if (dialogInfo.established != null) return ContactPresence.onCall;
    if (presenceInfo.primaryActivity == PresenceActivity.onThePhone) return ContactPresence.onCall;

    return presenceInfo.anyAvailable ? ContactPresence.available : ContactPresence.unavailable;
  }
}
