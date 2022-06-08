enum CallkeepHandleType {
  generic,
  number,
  email,
}

class CallkeepHandle {
  const CallkeepHandle({
    required this.type,
    required this.value,
  });

  const CallkeepHandle.generic(this.value) : type = CallkeepHandleType.generic;

  const CallkeepHandle.number(this.value) : type = CallkeepHandleType.number;

  const CallkeepHandle.email(this.value) : type = CallkeepHandleType.email;

  final CallkeepHandleType type;
  final String value;

  bool get isGeneric => type == CallkeepHandleType.generic;

  bool get isNumber => type == CallkeepHandleType.number;

  bool get isEmail => type == CallkeepHandleType.email;

  @override
  String toString() {
    return '$CallkeepHandle(type: $type, value: $value)';
  }
}
