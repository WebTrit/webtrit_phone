import 'package:webtrit_phone/app/constants.dart';
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
      dndMode: data.dndMode,
    );
  }
}

mixin SignalingPresenceSettingMapperMixin {
  SignalingPresenceSettings toSignaling(PresenceSettings data) => SignalingPresenceSettingsMapper.toSignaling(data);
}
