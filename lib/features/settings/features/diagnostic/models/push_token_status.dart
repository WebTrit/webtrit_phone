enum PushTokenStatusType {
  success,
  error,
  progress;

  bool get isSuccess => this == PushTokenStatusType.success;

  bool get isError => this == PushTokenStatusType.error;
}

class PushTokenStatus {
  final String? token;
  final String? error;
  final PushTokenStatusType type;

  const PushTokenStatus({this.token, this.error, this.type = PushTokenStatusType.progress});
}
