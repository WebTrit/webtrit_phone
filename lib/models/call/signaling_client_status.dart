enum SignalingClientStatus {
  disconnecting,
  disconnect,
  connecting,
  connect,
  failure,
}

extension SignalingClientStatusX on SignalingClientStatus {
  bool get isDisconnecting => this == SignalingClientStatus.disconnecting;

  bool get isDisconnect => this == SignalingClientStatus.disconnect;

  bool get isConnecting => this == SignalingClientStatus.connecting;

  bool get isConnect => this == SignalingClientStatus.connect;

  bool get isFailure => this == SignalingClientStatus.failure;
}
