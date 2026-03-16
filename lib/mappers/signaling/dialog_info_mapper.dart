import 'package:webtrit_phone/models/models.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

class SignalingDialogInfoMapper {
  static DialogInfo fromSignaling(SignalingDialogInfo data) {
    return DialogInfo(
      id: data.id,
      entityNumber: data.entityNumber,
      state: DialogState.values.byName(data.state.name),
      callId: data.callId,
      direction: data.direction != null ? DialogDirection.values.byName(data.direction!.name) : null,
      localTag: data.localTag,
      localNumber: data.localNumber,
      localDisplayName: data.localDisplayName,
      remoteTag: data.remoteTag,
      remoteNumber: data.remoteNumber,
      remoteDisplayName: data.remoteDisplayName,
      arrivalVersion: data.arrivalVersion,
      arrivalTime: data.arrivalTime,
    );
  }
}

mixin SignalingDialogInfoMapperMixin {
  DialogInfo fromSignaling(SignalingDialogInfo data) => SignalingDialogInfoMapper.fromSignaling(data);
}
