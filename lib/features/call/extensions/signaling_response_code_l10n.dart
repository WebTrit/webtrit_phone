import 'package:flutter/widgets.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

extension SignalingResponseCodeL10n on SignalingResponseCode {
  String l10n(BuildContext context) {
    switch (this) {
      case SignalingResponseCode.unauthorizedRequest:
        return 'Your request could not be authorized. Please try signing in again.';
      case SignalingResponseCode.unauthorizedAccess:
        return 'You do not have permission to access this feature. Contact support if you believe this is an error.';
      case SignalingResponseCode.unknownError:
        return 'An unexpected error occurred. Please try again later.';
      case SignalingResponseCode.transportSpecificError:
        return 'A connection issue occurred. Check your network and try again.';
      case SignalingResponseCode.missingRequest:
        return 'Something went wrong with your request. Please try again.';
      case SignalingResponseCode.unknownRequest:
        return 'We didn’t recognize that request. Try again or contact support.';
      case SignalingResponseCode.invalidJson:
        return 'There was an error processing your data. Please try again.';
      case SignalingResponseCode.invalidJsonObject:
        return 'Some information provided was invalid. Please double-check and try again.';
      case SignalingResponseCode.missingMandatoryElement:
        return 'Required information is missing. Please fill in all required fields.';
      case SignalingResponseCode.invalidPath:
        return 'The requested action isn’t available. Please try a different option.';
      case SignalingResponseCode.sessionNotFound:
        return 'Your session could not be found. Please sign in and try again.';
      case SignalingResponseCode.handleNotFound:
        return 'We couldn’t find what you were looking for. Please try again.';
      case SignalingResponseCode.pluginNotFound:
        return 'A required component is missing. Please try restarting the app.';
      case SignalingResponseCode.errorAttachingPlugin:
        return 'We had trouble connecting a feature. Please try again later.';
      case SignalingResponseCode.errorSendingMessage:
        return 'We couldn’t send your message. Check your network and try again.';
      case SignalingResponseCode.errorDetachingPlugin:
        return 'We had trouble disconnecting a feature. Please try again later.';
      case SignalingResponseCode.unsupportedJsepType:
        return 'This action isn’t supported by your current setup.';
      case SignalingResponseCode.invalidSdp:
        return 'We encountered a technical error. Please try again later.';
      case SignalingResponseCode.invalidStream:
        return 'The requested stream isn’t available. Please try again.';
      case SignalingResponseCode.invalidElementType:
        return 'Something isn’t quite right. Please try again.';
      case SignalingResponseCode.sessionIdInUse:
        return 'This session is already active. Try using a different session.';
      case SignalingResponseCode.unexpectedAnswer:
        return 'We got an unexpected response. Please try again.';
      case SignalingResponseCode.tokenNotFound:
        return 'Your access token is missing or invalid. Please sign in again.';
      case SignalingResponseCode.wrongWebrtcState:
        return 'A call-related error occurred. Please hang up and try again.';
      case SignalingResponseCode.notAcceptingNewSessions:
        return 'We’re not able to start new sessions at the moment. Please try later.';
      case SignalingResponseCode.notFoundRoutesInReplyFromBE:
        return 'We couldn’t find a route to complete your request. Please try again later.';
    }
  }
}
