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
