import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class SignalingPresenceInfoMapper {
  static PresenceInfo fromSignaling(SignalingPresenceInfo data) {
    return PresenceInfo(
      id: data.id,
      available: data.available,
      note: data.note,
      statusIcon: data.statusIcon,
      device: data.device,
      timeOffsetMin: data.timeOffsetMin,
      timestamp: DateTime.tryParse(data.timestamp ?? ''),
      activities: data.activities
          .map((activity) {
            return switch (activity) {
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
              _ => null,
            };
          })
          .nonNulls
          .toList(),
    );
  }
}

mixin SignalingPresenceInfoMapperMixin {
  PresenceInfo fromSignaling(SignalingPresenceInfo data) => SignalingPresenceInfoMapper.fromSignaling(data);
}
