import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/router/app_router.dart';

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
/// Uses for showing common exceptions from HTTP and WS API's with localized error messages and details
/// Can be extended with additional error handling logic for specific features and call super for default handling
class DefaultErrorNotification extends ErrorNotification {
  const DefaultErrorNotification(this.error);

  final Object error;

  @override
  String l10n(BuildContext context) => defaultErrorL10n(context, error);

  @override
  SnackBarAction? action(BuildContext context) {
    // If the error is a Webtrit api client RequestFailure, show the apropriate error details
    final RequestFailure? requestFailure = error.castToOrNull<RequestFailure>();
    if (requestFailure != null) {
      final errorFields = requestFailure.errorFields(context);
      final title = l10n(context);

      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () {
          context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
        },
      );
    }

    // If the error is a Webtrit signaling api exception, show the apropriate error details
    final WebtritSignalingException? signalingException = error.castToOrNull<WebtritSignalingException>();
    if (signalingException != null) {
      final errorFields = signalingException.errorFields(context);
      final title = l10n(context);

      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () {
          context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
        },
      );
    }

    return null;
  }
}
