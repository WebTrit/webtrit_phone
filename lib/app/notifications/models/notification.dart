import 'dart:io';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/models/failures/failures.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

enum NotificationScope {
  login,
  main,
  call;
}

// Base notifications definitions
@immutable
sealed class Notification {
  const Notification();

  String l10n(BuildContext context);

  SnackBarAction? action(BuildContext context) => null;

  List<NotificationScope> scopes() => NotificationScope.values;
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
    final error = this.error;

    if (error is RequestFailure) {
      final title = l10n(context);
      final errorFields = error.errorFields(context);

      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () {
          context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
        },
      );
    } else if (error is SignalingHangupFailure) {
      final title = l10n(context);
      final errorFields = error.errorFields(context);

      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () {
          context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
        },
      );
    } else if (error is WebtritSignalingException) {
      final title = l10n(context);
      final errorFields = error.errorFields(context);

      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () {
          context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
        },
      );
    } else if (error is MessagingSocketException) {
      final title = l10n(context);
      final errorFields = error.errorFields(context);

      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () {
          context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
        },
      );
    } else if (error is SocketException) {
      final title = l10n(context);
      final errorFields = error.errorFields(context);

      return SnackBarAction(
        label: context.l10n.default_ErrorDetails,
        onPressed: () {
          context.router.push(ErrorDetailsScreenPageRoute(title: title, fields: errorFields));
        },
      );
    } else {
      return null;
    }
  }
}

class NoInternetConnectionNotification extends ErrorNotification {
  const NoInternetConnectionNotification();

  @override
  String l10n(BuildContext context) {
    return context.l10n.common_noInternetConnection_message;
  }
}
