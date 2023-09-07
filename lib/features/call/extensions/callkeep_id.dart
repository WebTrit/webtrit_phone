import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/features/call/models/call_id_value.dart';

extension CallkeepIdExtension on CallkeepId {
  UuidValue get uuidValue => UuidValue(uuid);
}

extension CallIdValueExtension on CallIdValue {
  CallkeepId get getCallkeepId => CallkeepId(callId: value, uuid: const Uuid().v5obj(Uuid.NAMESPACE_OID, value).uuid);
}
