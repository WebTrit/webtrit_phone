import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

mixin DialogInfoDriftMapper {
  DialogInfo dialogInfoFromDrift(DialogInfoData data) {
    return DialogInfo(
      id: data.idKey,
      entityNumber: data.entityNumber,
      state: DialogState.values.byName(data.state),
      callId: data.callId,
      direction: data.direction != null ? DialogDirection.values.byName(data.direction!) : null,
      localTag: data.localTag,
      localNumber: data.localNumber,
      localDisplayName: data.localDisplayName,
      remoteTag: data.remoteTag,
      remoteNumber: data.remoteNumber,
      remoteDisplayName: data.remoteDisplayName,
      arrivalVersion: data.arrivalVersion,
      arrivalTime: DateTime.fromMicrosecondsSinceEpoch(data.arrivalTimeUsec),
    );
  }

  DialogInfoData dialogInfoToDrift(DialogInfo info) {
    return DialogInfoData(
      idKey: info.id,
      entityNumber: info.entityNumber,
      state: info.state.name,
      callId: info.callId,
      direction: info.direction?.name,
      localTag: info.localTag,
      localNumber: info.localNumber,
      localDisplayName: info.localDisplayName,
      remoteTag: info.remoteTag,
      remoteNumber: info.remoteNumber,
      remoteDisplayName: info.remoteDisplayName,
      arrivalVersion: info.arrivalVersion,
      arrivalTimeUsec: info.arrivalTime.microsecondsSinceEpoch,
    );
  }
}
