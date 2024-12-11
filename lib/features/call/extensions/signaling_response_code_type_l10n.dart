import 'package:flutter/widgets.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension SignalingResponseCodeTypeL10n on SignalingResponseCodeType {
  String l10n(BuildContext context) {
    switch (this) {
      case SignalingResponseCodeType.unauthorized:
        return context.l10n.signalingResponseCodeType_unauthorized;
      case SignalingResponseCodeType.unknown:
        return context.l10n.signalingResponseCodeType_unknown;
      case SignalingResponseCodeType.transport:
        return context.l10n.signalingResponseCodeType_transport;
      case SignalingResponseCodeType.request:
        return context.l10n.signalingResponseCodeType_request;
      case SignalingResponseCodeType.session:
        return context.l10n.signalingResponseCodeType_session;
      case SignalingResponseCodeType.plugin:
        return context.l10n.signalingResponseCodeType_plugin;
      case SignalingResponseCodeType.webrtc:
        return context.l10n.signalingResponseCodeType_webrtc;
      case SignalingResponseCodeType.token:
        return context.l10n.signalingResponseCodeType_token;
    }
  }
}
