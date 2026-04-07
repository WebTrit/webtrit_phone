import 'dart:convert';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin PresenceInfoDriftMapper {
  PresenceInfo presenceInfoFromDrift(PresenceInfoData data) {
    return PresenceInfo(
      id: data.idKey,
      number: data.number,
      available: data.available,
      note: data.note,
      statusIcon: data.statusIcon,
      device: data.device,
      timeOffsetMin: data.timeOffsetMin,
      timestamp: data.timestampUsec != null ? DateTime.fromMicrosecondsSinceEpoch(data.timestampUsec!) : null,
      activities: (jsonDecode(data.activitiesJson) as List<dynamic>)
          .map((e) => PresenceActivity.values.byName(e))
          .toList(),
      arrivalTime: DateTime.fromMicrosecondsSinceEpoch(data.arrivalTimeUsec),
      source: PresenceInfoSource.values.byName(data.source),
    );
  }

  PresenceInfoData presenceInfoToDrift(PresenceInfo info) {
    return PresenceInfoData(
      idKey: info.id,
      number: info.number,
      available: info.available,
      note: info.note,
      statusIcon: info.statusIcon,
      device: info.device,
      timeOffsetMin: info.timeOffsetMin,
      timestampUsec: info.timestamp?.microsecondsSinceEpoch,
      activitiesJson: jsonEncode(info.activities.map((e) => e.name).toList()),
      arrivalTimeUsec: info.arrivalTime.microsecondsSinceEpoch,
      source: info.source.name,
    );
  }
}
