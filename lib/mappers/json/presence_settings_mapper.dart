import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

class PresenceSettingsJsonMapper {
  static String toJson(PresenceSettings data) => jsonEncode(toMap(data));

  static PresenceSettings fromJson(String json) => fromMap(jsonDecode(json));

  static Map<String, dynamic> toMap(PresenceSettings data) {
    return {
      'available': data.available,
      'note': data.note,
      'statusIcon': data.statusIcon,
      'device': data.device,
      'timeOffsetMin': data.timeOffsetMin,
      'timestamp': data.timestamp.toIso8601String(),
      'activity': switch (data.activity) {
        PresenceActivity.away => 'away',
        PresenceActivity.busy => 'busy',
        PresenceActivity.sleeping => 'sleeping',
        PresenceActivity.doNotDisturb => 'do-not-disturb',
        PresenceActivity.permanentAbsence => 'permanent-absence',
        PresenceActivity.onThePhone => 'on-the-phone',
        PresenceActivity.meal => 'meal',
        PresenceActivity.meeting => 'meeting',
        PresenceActivity.appointment => 'appointment',
        PresenceActivity.vacation => 'vacation',
        PresenceActivity.travel => 'travel',
        PresenceActivity.inTransit => 'in-transit',
        null => null,
      },
      'dndMode': data.dndMode,
    };
  }

  static PresenceSettings fromMap(Map<String, dynamic> map) {
    return PresenceSettings(
      available: map['available'] as bool,
      note: map['note'] as String,
      statusIcon: map['statusIcon'] as String?,
      device: map['device'] as String,
      timeOffsetMin: map['timeOffsetMin'] as int,
      timestamp: DateTime.parse(map['timestamp'] as String),
      activity: switch (map['activity']) {
        'away' => PresenceActivity.away,
        'busy' => PresenceActivity.busy,
        'sleeping' => PresenceActivity.sleeping,
        'do-not-disturb' => PresenceActivity.doNotDisturb,
        'permanent-absence' => PresenceActivity.permanentAbsence,
        'on-the-phone' => PresenceActivity.onThePhone,
        'meal' => PresenceActivity.meal,
        'meeting' => PresenceActivity.meeting,
        'appointment' => PresenceActivity.appointment,
        'vacation' => PresenceActivity.vacation,
        'travel' => PresenceActivity.travel,
        'in-transit' => PresenceActivity.inTransit,
        null => null,
        _ => null,
      },
      dndMode: map['dndMode'] as bool? ?? false,
    );
  }
}

mixin PresenceSettingJsonMapperMixin {
  PresenceSettings presenceSettingsFromJson(String json) => PresenceSettingsJsonMapper.fromJson(json);
  String presenceSettingsToJson(PresenceSettings data) => PresenceSettingsJsonMapper.toJson(data);
  PresenceSettings presenceSettingsFromMap(Map<String, dynamic> map) => PresenceSettingsJsonMapper.fromMap(map);
  Map<String, dynamic> presenceSettingsToMap(PresenceSettings data) => PresenceSettingsJsonMapper.toMap(data);
}
