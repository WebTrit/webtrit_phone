import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin ExternalContactApiMapper {
  ExternalContact externalContactFromApi(api.UserContact contact) {
    final numbers = contact.numbers;
    return ExternalContact(
      id: contact.userId,
      registered: contact.sipStatus == null ? null : contact.sipStatus == api.SipStatus.registered,
      userRegistered: contact.isRegisteredUser,
      isCurrentUser: contact.isCurrentUser,
      firstName: contact.firstName,
      lastName: contact.lastName,
      aliasName: contact.aliasName,
      number: numbers.main,
      ext: numbers.ext,
      mobile: numbers.main,
      smsNumbers: numbers.sms,
      email: contact.email,
    );
  }
}
