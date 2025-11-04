import 'dart:convert';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin PresenceInfoDriftMapper {
  PresenceInfo presenceInfoFromDrift(PresenceInfoData data) {
    return PresenceInfo(
      id: data.idKey,
      available: data.available,
      note: data.note,
      statusIcon: data.statusIcon,
      device: data.device,
      timeOffsetMin: data.timeOffsetMin,
      timestamp: data.timestampUsec != null ? DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec!) : null,
      activities:
          (jsonDecode(data.activitiesJson) as List<dynamic>).map((e) => PresenceActivity.values.byName(e)).toList(),
    );
  }

  PresenceInfoData presenceInfoToDrift(String number, PresenceInfo info) {
    return PresenceInfoData(
      idKey: info.id,
      number: number,
      available: info.available,
      note: info.note,
      statusIcon: info.statusIcon,
      device: info.device,
      timeOffsetMin: info.timeOffsetMin,
      timestampUsec: info.timestamp?.microsecondsSinceEpoch,
      activitiesJson: jsonEncode(info.activities.map((e) => e.name).toList()),
    );
  }
}
