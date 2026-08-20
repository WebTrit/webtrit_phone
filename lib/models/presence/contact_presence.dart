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
/// The states are deliberately coarser than the activities a contact can
/// publish: a mark on a contact row is drawn at about ten points across, where
/// only the simplest silhouette survives, so twelve pictograms cannot be told
/// apart there. The exact activity is not lost - the row's text and the spoken
/// label still name it - but the mark speaks in classes.
enum ContactPresence {
  /// In a call right now, proven: the switch reports an established dialog.
  onCall,

  /// The contact says they are on the phone, and nothing confirms it.
  ///
  /// The server publishes this from the moment of dialling, so on this path a
  /// ringing phone is indistinguishable from a conversation. It is worth
  /// showing - where the switch reports no calls at all this is the only sign
  /// there is - but it must not be painted as certain.
  onCallReported,

  /// Asking not to be called: publishing "busy" or "do not disturb".
  busy,

  /// Elsewhere, but not asking to be left alone: away, asleep, at a meal, in
  /// a meeting, travelling, on holiday, and the rest of that family.
  away,

  /// Reachable, nothing in the way.
  available,

  /// Says outright that they are not reachable.
  unavailable;

  static ContactPresence resolve({required List<PresenceInfo> presenceInfo, required List<DialogInfo> dialogInfo}) {
    if (dialogInfo.established != null) return ContactPresence.onCall;

    // Asking not to be called outranks reachability: a contact on "do not
    // disturb" is reachable by definition - they just published something -
    // and the point of the state is to stop the call, not to describe the
    // connection.
    final activity = presenceInfo.primaryActivity;
    if (activity != null) {
      switch (activity) {
        case PresenceActivity.doNotDisturb:
        case PresenceActivity.busy:
          return ContactPresence.busy;
        case PresenceActivity.onThePhone:
          return ContactPresence.onCallReported;
        case PresenceActivity.away:
        case PresenceActivity.sleeping:
        case PresenceActivity.permanentAbsence:
        case PresenceActivity.meal:
        case PresenceActivity.meeting:
        case PresenceActivity.appointment:
        case PresenceActivity.vacation:
        case PresenceActivity.travel:
        case PresenceActivity.inTransit:
          return ContactPresence.away;
      }
    }

    return presenceInfo.anyAvailable ? ContactPresence.available : ContactPresence.unavailable;
  }
}
