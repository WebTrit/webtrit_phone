import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'l10n.dart';

String defaultErrorL10n(BuildContext context, Object error) {
  return switch (error) {
    FormatException() => context.l10n.default_FormatExceptionError,
    TlsException() => context.l10n.default_TlsExceptionError,
    SocketException() => context.l10n.default_SocketExceptionError,
    TypeError() => context.l10n.default_TypeErrorError,
    RequestFailure() => context.l10n.default_RequestFailureError,
    _ => error.toString(),
  };
}
