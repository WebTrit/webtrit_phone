import 'package:flutter/material.dart';

@immutable
abstract class Notification {
  const Notification();

  String l10n(BuildContext context);

  SnackBarAction? action(BuildContext context) => null;
}

abstract class ErrorNotification extends Notification {
  const ErrorNotification();
}
