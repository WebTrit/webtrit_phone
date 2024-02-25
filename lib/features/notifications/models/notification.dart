import 'package:flutter/material.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

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
