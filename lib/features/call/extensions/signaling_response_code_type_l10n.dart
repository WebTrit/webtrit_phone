import 'package:flutter/widgets.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

extension SignalingResponseCodeTypeL10n on SignalingResponseCodeType {
  String l10n(BuildContext context) {
    switch (this) {
      case SignalingResponseCodeType.unauthorized:
        return 'You do not have the proper authorization. Please sign in or contact support.';
      case SignalingResponseCodeType.unknown:
        return 'An unexpected issue occurred. Please try again later.';
      case SignalingResponseCodeType.transport:
        return 'We’re having trouble communicating with the server. Check your connection and try again.';
      case SignalingResponseCodeType.request:
        return 'There’s a problem with your request. Please try again.';
      case SignalingResponseCodeType.session:
        return 'There’s an issue with your session. Please sign in again or restart the app.';
      case SignalingResponseCodeType.plugin:
        return 'A required feature isn’t working properly. Try restarting the app.';
      case SignalingResponseCodeType.webrtc:
        return 'There’s a problem with the call connection. Please hang up and try again.';
      case SignalingResponseCodeType.token:
        return 'Your access token isn’t valid. Please sign in again.';
    }
  }
}
