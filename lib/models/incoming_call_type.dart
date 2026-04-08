import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

enum IncomingCallType {
  pushNotification,
  socket;

  bool get isPushNotification => this == pushNotification;

  bool get isSocket => this == socket;

  SignalingServiceMode toSignalingServiceMode() => switch (this) {
    IncomingCallType.pushNotification => SignalingServiceMode.pushBound,
    IncomingCallType.socket => SignalingServiceMode.persistent,
  };
}
