import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/default_error_l10n.dart';

@immutable
abstract class Notification {
  const Notification();

  String l10n(BuildContext context);

  SnackBarAction? action(BuildContext context) => null;
}

abstract class ErrorNotification extends Notification {
  const ErrorNotification();
}

class DefaultErrorNotification extends ErrorNotification {
  const DefaultErrorNotification(this.error);

  final Object error;

  @override
  String l10n(BuildContext context) => defaultErrorL10n(context, error);
}
