import 'dart:convert';

import 'package:webtrit_phone/app/constants.dart';
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
        PresenceActivity.away => kPresenceActivityKeyAway,
        PresenceActivity.busy => kPresenceActivityKeyBusy,
        PresenceActivity.sleeping => kPresenceActivityKeySleeping,
        PresenceActivity.doNotDisturb => kPresenceActivityKeyDoNotDisturb,
        PresenceActivity.permanentAbsence => kPresenceActivityKeyPermanentAbsence,
        PresenceActivity.onThePhone => kPresenceActivityKeyOnThePhone,
        PresenceActivity.meal => kPresenceActivityKeyMeal,
        PresenceActivity.meeting => kPresenceActivityKeyMeeting,
        PresenceActivity.appointment => kPresenceActivityKeyAppointment,
        PresenceActivity.vacation => kPresenceActivityKeyVacation,
        PresenceActivity.travel => kPresenceActivityKeyTravel,
        PresenceActivity.inTransit => kPresenceActivityKeyInTransit,
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
        kPresenceActivityKeyAway => PresenceActivity.away,
        kPresenceActivityKeyBusy => PresenceActivity.busy,
        kPresenceActivityKeySleeping => PresenceActivity.sleeping,
        kPresenceActivityKeyDoNotDisturb => PresenceActivity.doNotDisturb,
        kPresenceActivityKeyPermanentAbsence => PresenceActivity.permanentAbsence,
        kPresenceActivityKeyOnThePhone => PresenceActivity.onThePhone,
        kPresenceActivityKeyMeal => PresenceActivity.meal,
        kPresenceActivityKeyMeeting => PresenceActivity.meeting,
        kPresenceActivityKeyAppointment => PresenceActivity.appointment,
        kPresenceActivityKeyVacation => PresenceActivity.vacation,
        kPresenceActivityKeyTravel => PresenceActivity.travel,
        kPresenceActivityKeyInTransit => PresenceActivity.inTransit,
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
