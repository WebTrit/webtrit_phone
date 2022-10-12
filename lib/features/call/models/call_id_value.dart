import 'package:webtrit_callkeep/webtrit_callkeep.dart';

class CallIdValue {
  factory CallIdValue(String value, [UuidValue? verificationUuid]) {
    final uuid = const Uuid().v5obj(Uuid.NAMESPACE_OID, value);

    if (verificationUuid != null && verificationUuid != uuid) {
      throw ArgumentError.value(
          verificationUuid, 'verificationUuid', 'Not equal to generated UUID version 5 based on callId value: $value');
    }

    return CallIdValue._(value, uuid);
  }

  const CallIdValue._(this.value, this.uuid);

  final String value;
  final UuidValue uuid;

  @override
  String toString() {
    return value;
  }

  @override
  bool operator ==(Object other) => other is CallIdValue && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
