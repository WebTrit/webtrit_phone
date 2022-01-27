import 'package:meta/meta.dart';

@immutable
abstract class Notification {
  const Notification();
}

class CallNotIdleErrorNotification extends Notification {
  const CallNotIdleErrorNotification();
}

class CallAttachErrorNotification extends Notification {
  const CallAttachErrorNotification();
}
