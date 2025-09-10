import 'package:webtrit_phone/models/models.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class SignalingPresenceSettingsMapper {
  static SignalingPresenceSettings toSignaling(PresenceSettings data) {
    return SignalingPresenceSettings(
      available: data.available,
      note: data.note,
      statusIcon: data.statusIcon,
      device: data.device,
      timeOffsetMin: data.timeOffsetMin,
      timestamp: data.timestamp.toIso8601String(),
      activity: switch (data.activity) {
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
      dndMode: data.dndMode,
    );
  }
}

mixin SignalingPresenceSettingMapperMixin {
  SignalingPresenceSettings toSignaling(PresenceSettings data) => SignalingPresenceSettingsMapper.toSignaling(data);
}
