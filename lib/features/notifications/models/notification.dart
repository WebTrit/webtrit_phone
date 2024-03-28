import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/default_error_l10n.dart';

enum NotificationType {
  error,
  message,
  raw,
}

@immutable
abstract class Notification {
  const Notification();

  String l10n(BuildContext context);

  NotificationType type();

  SnackBarAction? action(BuildContext context) => null;
}

abstract class ErrorNotification extends Notification {
  const ErrorNotification();

  @override
  NotificationType type() => NotificationType.error;
}

class DefaultErrorNotification extends ErrorNotification {
  const DefaultErrorNotification(this.error);

  final Object error;

  @override
  String l10n(BuildContext context) => defaultErrorL10n(context, error);
}

class RawNotification extends Notification {
  const RawNotification(this.message);

  final String message;

  @override
  String l10n(BuildContext context) => message;

  @override
  NotificationType type() => NotificationType.raw;
}

abstract class MessageNotification extends Notification {
  @override
  NotificationType type() => NotificationType.message;
}
