import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

enum NotificationType {
  error,
  message,
  raw,
  success,
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

  @override
  SnackBarAction? action(BuildContext context) {
    final errorFields = error.castTo<RequestFailure>()?.errorFields(context);
    return errorFields != null
        ? SnackBarAction(
            label: context.l10n.default_ErrorDetails,
            onPressed: () => context.showErrorBottomSheetDialog(l10n(context), errorFields),
          )
        : null;
  }
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

abstract class SuccessNotification extends Notification {
  const SuccessNotification();

  @override
  NotificationType type() => NotificationType.success;
}
