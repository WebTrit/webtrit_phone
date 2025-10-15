import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin CdrApiMapper {
  CdrRecord cdrFromApi(api.CdrRecord cdrRecord) {
    return CdrRecord(
      callId: cdrRecord.callId,
      direction: CallDirection.values.byName(cdrRecord.direction),
      status: CdrStatus.values.byName(cdrRecord.status),
      callee: cdrRecord.callee,
      caller: cdrRecord.caller,
      connectTime: cdrRecord.connectTime,
      disconnectTime: cdrRecord.disconnectTime,
      disconnectReason: cdrRecord.disconnectReason,
      duration: Duration(seconds: cdrRecord.duration),
      recordingId: cdrRecord.recordingId,
    );
  }
}
