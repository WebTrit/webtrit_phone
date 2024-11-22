import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'call_logs_mapper.dart';
import 'contacts_mapper.dart';

Recent recentFromDrift(RecentData data) {
  final callLogEntry = callLogEntryFromDrift(data.callLogEntry);
  Contact? contact;

  if (data.contactData != null) {
    contact = contactFromDrift(
      data.contactData!,
      phones: data.contactPhones.toList(),
      emails: data.contactEmails.toList(),
    );
  }

  return Recent(callLogEntry: callLogEntry, contact: contact);
}
