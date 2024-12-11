import 'package:flutter/widgets.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension SignalingResponseCodeL10n on SignalingResponseCode {
  String l10n(BuildContext context) {
    switch (this) {
      case SignalingResponseCode.unauthorizedRequest:
        return context.l10n.signalingResponseCode_unauthorizedRequest;
      case SignalingResponseCode.unauthorizedAccess:
        return context.l10n.signalingResponseCode_unauthorizedAccess;
      case SignalingResponseCode.unknownError:
        return context.l10n.signalingResponseCode_unknownError;
      case SignalingResponseCode.transportSpecificError:
        return context.l10n.signalingResponseCode_transportSpecificError;
      case SignalingResponseCode.missingRequest:
        return context.l10n.signalingResponseCode_missingRequest;
      case SignalingResponseCode.unknownRequest:
        return context.l10n.signalingResponseCode_unknownRequest;
      case SignalingResponseCode.invalidJson:
        return context.l10n.signalingResponseCode_invalidJson;
      case SignalingResponseCode.invalidJsonObject:
        return context.l10n.signalingResponseCode_invalidJsonObject;
      case SignalingResponseCode.missingMandatoryElement:
        return context.l10n.signalingResponseCode_missingMandatoryElement;
      case SignalingResponseCode.invalidPath:
        return context.l10n.signalingResponseCode_invalidPath;
      case SignalingResponseCode.sessionNotFound:
        return context.l10n.signalingResponseCode_sessionNotFound;
      case SignalingResponseCode.handleNotFound:
        return context.l10n.signalingResponseCode_handleNotFound;
      case SignalingResponseCode.pluginNotFound:
        return context.l10n.signalingResponseCode_pluginNotFound;
      case SignalingResponseCode.errorAttachingPlugin:
        return context.l10n.signalingResponseCode_errorAttachingPlugin;
      case SignalingResponseCode.errorSendingMessage:
        return context.l10n.signalingResponseCode_errorSendingMessage;
      case SignalingResponseCode.errorDetachingPlugin:
        return context.l10n.signalingResponseCode_errorDetachingPlugin;
      case SignalingResponseCode.unsupportedJsepType:
        return context.l10n.signalingResponseCode_unsupportedJsepType;
      case SignalingResponseCode.invalidSdp:
        return context.l10n.signalingResponseCode_invalidSdp;
      case SignalingResponseCode.invalidStream:
        return context.l10n.signalingResponseCode_invalidStream;
      case SignalingResponseCode.invalidElementType:
        return context.l10n.signalingResponseCode_invalidElementType;
      case SignalingResponseCode.sessionIdInUse:
        return context.l10n.signalingResponseCode_sessionIdInUse;
      case SignalingResponseCode.unexpectedAnswer:
        return context.l10n.signalingResponseCode_unexpectedAnswer;
      case SignalingResponseCode.tokenNotFound:
        return context.l10n.signalingResponseCode_tokenNotFound;
      case SignalingResponseCode.wrongWebrtcState:
        return context.l10n.signalingResponseCode_wrongWebrtcState;
      case SignalingResponseCode.notAcceptingNewSessions:
        return context.l10n.signalingResponseCode_notAcceptingNewSessions;
      case SignalingResponseCode.notFoundRoutesInReplyFromBE:
        return context.l10n.signalingResponseCode_notFoundRoutesInReplyFromBE;
    }
  }
}
