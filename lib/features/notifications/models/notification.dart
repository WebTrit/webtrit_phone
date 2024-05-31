import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

// Base notifications definitions

@immutable
sealed class Notification {
  const Notification();

  String l10n(BuildContext context);

  SnackBarAction? action(BuildContext context) => null;
}

abstract class ErrorNotification extends Notification {
  const ErrorNotification();
}

abstract class MessageNotification extends Notification {
  const MessageNotification();
}

abstract class SuccessNotification extends Notification {
  const SuccessNotification();
}

// Default notification implementations

/// Default notification for unknown or unlocalizable error messages
class ErrorMessageNotification extends ErrorNotification {
  const ErrorMessageNotification(this.message);

  final String message;

  @override
  String l10n(BuildContext context) => message;
}

/// Default notification for handled exceptions
class DefaultErrorNotification extends ErrorNotification {
  const DefaultErrorNotification(this.error);

  final Exception error;

  @override
  String l10n(BuildContext context) => defaultErrorL10n(context, error);

  @override
  SnackBarAction? action(BuildContext context) {
    // If the error is a Webtrit api client RequestFailure, show the error details
    final RequestFailure? requestFailure = error.castToOrNull<RequestFailure>();
    if (requestFailure != null) {
      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () => context.showErrorBottomSheetDialog(l10n(context), requestFailure.errorFields(context)),
      );
    }

    return null;
  }
}
