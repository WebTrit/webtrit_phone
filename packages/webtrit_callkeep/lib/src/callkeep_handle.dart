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

  final CallkeepHandleType type;
  final String value;

  @override
  String toString() {
    return '$CallkeepHandle(type: $type, value: $value)';
  }
}
