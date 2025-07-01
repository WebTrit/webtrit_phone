import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/call_log_entry.dart';

mixin CallLogsDriftMapper {
  CallLogEntry callLogEntryFromDrift(CallLogData callLogData) {
    return CallLogEntry(
      direction: CallDirection.values.byName(callLogData.direction.name),
      number: callLogData.number,
      username: callLogData.username,
      video: callLogData.video,
      createdTime: callLogData.createdAt,
      acceptedTime: callLogData.acceptedAt,
      hungUpTime: callLogData.hungUpAt,
      id: callLogData.id,
    );
  }
}
