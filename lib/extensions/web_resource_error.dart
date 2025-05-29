import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension WebResourceErrorExtension on WebResourceError {
  String titleL10n(BuildContext context) {
    switch (errorType) {
      case WebResourceErrorType.hostLookup:
        return context.l10n.common_noInternetConnection_title;
      default:
        return context.l10n.common_problemWithLoadingPage;
    }
  }

  String messageL10n(BuildContext context) {
    switch (errorType) {
      case WebResourceErrorType.hostLookup:
        return context.l10n.common_noInternetConnection_message;
      default:
        return description;
    }
  }
}
