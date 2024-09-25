import 'package:webtrit_phone/models/contact.dart';
import 'package:webtrit_phone/models/contact_source_type.dart';

extension ContactMessagingExt on Contact {
  /// Whether the user can send a message to this contact using the chat messaging feature.
  bool get canMessage {
    return (sourceType == ContactSourceType.external) &&
        sourceId.isNotEmpty &&
        userRegistered == true &&
        isCurrentUser == false;
  }

  bool get canSendSms {
    return phones.isNotEmpty && isCurrentUser != true;
  }
}
