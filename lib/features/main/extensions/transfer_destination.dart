import 'package:webtrit_phone/models/models.dart';

/// Whether a section is somewhere a call being transferred can be handed to.
///
/// A blind transfer leaves the user looking for a destination, and only the
/// sections that offer one are worth telling about it: the lists a number can
/// be picked from, and the keypad, where one can be dialled. A conversation or
/// an embedded page has nobody to hand the call to.
extension TransferDestinationFlavor on MainFlavor {
  bool get offersTransferDestination => switch (this) {
    MainFlavor.favorites || MainFlavor.recents || MainFlavor.contacts || MainFlavor.keypad => true,
    // Voicemail is a list of messages, not of people to hand a call to: the
    // sender of one is a number the recents list already offers.
    MainFlavor.messaging || MainFlavor.embedded || MainFlavor.voicemail => false,
  };
}
