import 'package:webtrit_callkeep/webtrit_callkeep.dart';

class CallIdValue {
  factory CallIdValue(String callId, [UuidValue? verificationUuid]) {
    final uuid = const Uuid().v5obj(Uuid.NAMESPACE_OID, callId);

    if (verificationUuid != null && verificationUuid != uuid) {
      throw ArgumentError.value(
          verificationUuid, 'verificationUuid', 'Not equal to generated UUID version 5 based on callId: $callId');
    }

    return CallIdValue._(callId, uuid);
  }

  const CallIdValue._(this.callId, this.uuid);

  final String callId;
  final UuidValue uuid;

  @override
  String toString() {
    return callId;
  }

  @override
  bool operator ==(Object other) => other is CallIdValue && callId == other.callId;

  @override
  int get hashCode => callId.hashCode;
}
