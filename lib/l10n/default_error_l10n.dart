import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'l10n.dart';

String defaultErrorL10n(BuildContext context, Object error) {
  return switch (error) {
    FormatException() => context.l10n.default_FormatExceptionError,
    TlsException() => context.l10n.default_TlsExceptionError,
    SocketException() => context.l10n.default_SocketExceptionError,
    ClientException() => context.l10n.default_ClientExceptionError,
    TypeError() => context.l10n.default_TypeErrorError,
    RequestFailure() => _defaultRequestFailureL10n(context, error),
    _ => error.toString(),
  };
}

String _defaultRequestFailureL10n(BuildContext context, RequestFailure error) {
  if (error.statusCode == HttpStatus.unauthorized) {
    return context.l10n.default_UnauthorizedRequestFailureError;
  } else {
    return context.l10n.default_RequestFailureError;
  }
}
