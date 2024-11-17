enum IncomingCallType {
  pushNotification,
  socket;

  bool get isPushNotification => this == pushNotification;

  bool get isSocket => this == socket;
}
