import 'package:collection/collection.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/extensions/string.dart';
import 'package:webtrit_phone/models/models.dart';

mixin CdrApiMapper {
  CdrRecord cdrFromApi(api.CdrRecord cdrRecord) {
    return CdrRecord(
      callId: cdrRecord.callId,
      direction: CallDirection.values.byName(cdrRecord.direction),
      status: CdrStatus.values.firstWhereOrNull((s) => s.name == cdrRecord.status) ?? CdrStatus.error,
      callee: cdrRecord.callee,
      calleeNumber: cdrRecord.callee.extractNumber,
      caller: cdrRecord.caller,
      callerNumber: cdrRecord.caller.extractNumber,
      connectTime: cdrRecord.connectTime,
      disconnectTime: cdrRecord.disconnectTime,
      disconnectReason: cdrRecord.disconnectReason,
      duration: Duration(seconds: cdrRecord.duration),
      recordingId: cdrRecord.recordingId,
    );
  }
}
