import 'package:webtrit_phone/models/contact_source_type.dart';
import 'package:webtrit_phone/models/recent.dart';

extension RecentMessagingExt on Recent {
  /// Whether the user can send a message to this recent using the chat messaging feature.
  bool get canMessage {
    return (contactSourceType == ContactSourceType.external) &&
        (contactSourceId?.isNotEmpty == true) &&
        contactUserRegistered == true &&
        contactIsCurrentUser == false;
  }
}
