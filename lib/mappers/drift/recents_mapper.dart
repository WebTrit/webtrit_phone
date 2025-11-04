import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'call_logs_mapper.dart';
import 'contacts_mapper.dart';

mixin RecentsDriftMapper on CallLogsDriftMapper, ContactsDriftMapper {
  Recent recentFromDrift(RecentData data) {
    final callLogEntry = callLogEntryFromDrift(data.callLogEntry);
    Contact? contact;

    if (data.contactData != null) {
      contact = contactFromDrift(
        data.contactData!,
        phones: data.contactPhones.toList(),
        emails: data.contactEmails.toList(),
        presenceInfo: data.presenceInfo.toList(),
      );
    }

    return Recent(callLogEntry: callLogEntry, contact: contact);
  }
}
