import 'package:webtrit_phone/models/models.dart';
import 'package:app_database/app_database.dart' as db;

mixin CdrDriftMapper {
  CdrRecord cdrFromDrift(db.CdrRecordData data) {
    return CdrRecord(
      callId: data.callId,
      direction: CallDirection.values.byName(data.direction.name),
      status: CdrStatus.values.byName(data.status.name),
      callee: data.callee,
      caller: data.caller,
      connectTime: DateTime.fromMicrosecondsSinceEpoch(data.connectTimeUsec),
      disconnectTime: DateTime.fromMicrosecondsSinceEpoch(data.disconnectTimeUsec),
      disconnectReason: data.disconnectReason,
      duration: Duration(seconds: data.durationSeconds),
      recordingId: data.recordingId,
    );
  }

  db.CdrRecordData cdrToDrift(CdrRecord model) {
    return db.CdrRecordData(
      callId: model.callId,
      direction: db.CallDirectionData.values.byName(model.direction.name),
      status: db.CdrStatusData.values.byName(model.status.name),
      callee: model.callee,
      caller: model.caller,
      connectTimeUsec: model.connectTime.microsecondsSinceEpoch,
      disconnectTimeUsec: model.disconnectTime.microsecondsSinceEpoch,
      disconnectReason: model.disconnectReason,
      durationSeconds: model.duration.inSeconds,
      recordingId: model.recordingId?.toString(),
    );
  }
}
