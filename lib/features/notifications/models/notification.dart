import 'package:meta/meta.dart';

@immutable
abstract class Notification {
  const Notification();
}

class CallNotIdleErrorNotification extends Notification {
  const CallNotIdleErrorNotification();
}

class CallConnectErrorNotification extends Notification {
  const CallConnectErrorNotification();
}
