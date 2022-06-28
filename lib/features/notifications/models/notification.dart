import 'package:meta/meta.dart';

@immutable
abstract class Notification {
  const Notification();
}

class CallSignalingClientNotReadyErrorNotification extends Notification {
  const CallSignalingClientNotReadyErrorNotification();
}

class CallConnectErrorNotification extends Notification {
  const CallConnectErrorNotification();
}
