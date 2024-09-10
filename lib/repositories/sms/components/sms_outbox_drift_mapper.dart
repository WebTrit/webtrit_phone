import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin SmsOutboxDriftMapper {
  SmsOutboxMessageEntry smsOutboxMessageEntryFromDrift(SmsOutboxMessageData data) {
    return SmsOutboxMessageEntry(
      idKey: data.idKey,
      fromPhoneNumber: data.fromPhoneNumber,
      toPhoneNumber: data.toPhoneNumber,
      content: data.content,
      conversationId: data.conversationId,
      sendAttempts: data.sendAttempts,
    );
  }

  SmsOutboxMessageData smsOutboxMessageDataFromEntry(SmsOutboxMessageEntry entry) {
    return SmsOutboxMessageData(
      idKey: entry.idKey,
      fromPhoneNumber: entry.fromPhoneNumber,
      toPhoneNumber: entry.toPhoneNumber,
      content: entry.content,
      conversationId: entry.conversationId,
      sendAttempts: entry.sendAttempts,
    );
  }
}
