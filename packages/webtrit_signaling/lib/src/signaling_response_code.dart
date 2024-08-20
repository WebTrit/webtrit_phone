enum SignalingResponseCodeType {
  unauthorized,
  unknown,
  transport,
  request,
  session,
  plugin,
  webrtc,
  token,
}

// The meaning of each code can be found at:
// https://github.com/WebTrit/webtrit_docs/blob/b2148c4011d98f2887a3994b8f63c351632ad9dd/signaling/responses/error_codes.md
enum SignalingResponseCode {
  unauthorizedRequest(SignalingResponseCodeType.unauthorized, 403),
  unauthorizedAccess(SignalingResponseCodeType.unauthorized, 405),
  unknownError(SignalingResponseCodeType.unknown, 490),
  transportSpecificError(SignalingResponseCodeType.transport, 450),
  missingRequest(SignalingResponseCodeType.request, 452),
  unknownRequest(SignalingResponseCodeType.request, 453),
  invalidJson(SignalingResponseCodeType.request, 454),
  invalidJsonObject(SignalingResponseCodeType.request, 455),
  missingMandatoryElement(SignalingResponseCodeType.request, 456),
  invalidPath(SignalingResponseCodeType.request, 457),
  sessionNotFound(SignalingResponseCodeType.session, 458),
  handleNotFound(SignalingResponseCodeType.session, 459),
  pluginNotFound(SignalingResponseCodeType.plugin, 460),
  errorAttachingPlugin(SignalingResponseCodeType.plugin, 461),
  errorSendingMessage(SignalingResponseCodeType.plugin, 462),
  errorDetachingPlugin(SignalingResponseCodeType.plugin, 463),
  unsupportedJsepType(SignalingResponseCodeType.plugin, 464),
  invalidSdp(SignalingResponseCodeType.plugin, 465),
  invalidStream(SignalingResponseCodeType.plugin, 466),
  invalidElementType(SignalingResponseCodeType.plugin, 467),
  sessionIdInUse(SignalingResponseCodeType.session, 468),
  unexpectedAnswer(SignalingResponseCodeType.plugin, 469),
  tokenNotFound(SignalingResponseCodeType.token, 470),
  wrongWebrtcState(SignalingResponseCodeType.webrtc, 471),
  notAcceptingNewSessions(SignalingResponseCodeType.session, 472);

  const SignalingResponseCode(this.type, this.code);

  final SignalingResponseCodeType type;
  final int code;

  @override
  String toString() {
    return 'SignalingResponseCode(type: $type, code: $code)';
  }
}

extension SignalingResponseCodeByCode on Iterable<SignalingResponseCode> {
  SignalingResponseCode? byCode(int code) {
    for (var value in this) {
      if (value.code == code) return value;
    }
    return null;
  }
}
