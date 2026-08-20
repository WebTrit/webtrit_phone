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
enum ContactPresence {
  /// In a call right now, and proven: the switch reports an established
  /// dialog.
  ///
  /// The contact's own `onThePhone` activity deliberately does NOT land here.
  /// The server publishes it from the moment of dialling, so on that path a
  /// ringing phone is indistinguishable from a conversation; it still gets
  /// its glyph, but it must not paint a contact as uncallable over a call
  /// that may never be answered.
  onCall,

  /// Reachable, but asking not to be called: publishing "busy" or "do not
  /// disturb".
  busy,

  /// Reachable, nothing in the way.
  available,

  /// Not reachable, or nothing is known about them.
  unavailable;

  static ContactPresence resolve({required List<PresenceInfo> presenceInfo, required List<DialogInfo> dialogInfo}) {
    if (dialogInfo.established != null) return ContactPresence.onCall;

    // Asking not to be called outranks reachability: a contact on "do not
    // disturb" is reachable by definition - they just published something -
    // and the point of the state is to stop the call, not to describe the
    // connection.
    final activity = presenceInfo.primaryActivity;
    if (activity == PresenceActivity.doNotDisturb || activity == PresenceActivity.busy) {
      return ContactPresence.busy;
    }

    return presenceInfo.anyAvailable ? ContactPresence.available : ContactPresence.unavailable;
  }
}
