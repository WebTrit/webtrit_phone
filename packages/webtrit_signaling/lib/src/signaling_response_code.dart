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

enum SignalingResponseCode {
  unauthorizedRequest(
      SignalingResponseCodeType.unauthorized, 403, 'Unauthorized request (wrong or missing secret/token)'),
  unauthorizedAccess(
      SignalingResponseCodeType.unauthorized, 405, 'Unauthorized access to plugin (token is not allowed to)'),
  unknownError(SignalingResponseCodeType.unknown, 490, 'Unknown error'),
  transportSpecificError(SignalingResponseCodeType.transport, 450, 'Transport specific error'),
  missingRequest(SignalingResponseCodeType.request, 452, 'Missing request'),
  unknownRequest(SignalingResponseCodeType.request, 453, 'Unknown request'),
  invalidJson(SignalingResponseCodeType.request, 454, 'Invalid JSON'),
  invalidJsonObject(SignalingResponseCodeType.request, 455, 'Invalid JSON Object'),
  missingMandatoryElement(SignalingResponseCodeType.request, 456, 'Missing mandatory element'),
  invalidPath(SignalingResponseCodeType.request, 457, 'Invalid path for this request'),
  sessionNotFound(SignalingResponseCodeType.session, 458, 'Session not found'),
  handleNotFound(SignalingResponseCodeType.session, 459, 'Handle not found'),
  pluginNotFound(SignalingResponseCodeType.plugin, 460, 'Plugin not found'),
  errorAttachingPlugin(SignalingResponseCodeType.plugin, 461, 'Error attaching plugin'),
  errorSendingMessage(SignalingResponseCodeType.plugin, 462, 'Error sending message to plugin'),
  errorDetachingPlugin(SignalingResponseCodeType.plugin, 463, 'Error detaching from plugin'),
  unsupportedJsepType(SignalingResponseCodeType.plugin, 464, 'Unsupported JSEP type'),
  invalidSdp(SignalingResponseCodeType.plugin, 465, 'Invalid SDP'),
  invalidStream(SignalingResponseCodeType.plugin, 466, 'Invalid stream'),
  invalidElementType(SignalingResponseCodeType.plugin, 467, 'Invalid element type'),
  sessionIdInUse(SignalingResponseCodeType.session, 468, 'Session ID already in use'),
  unexpectedAnswer(SignalingResponseCodeType.plugin, 469, 'Unexpected ANSWER (no OFFER)'),
  tokenNotFound(SignalingResponseCodeType.token, 470, 'Token not found'),
  wrongWebrtcState(SignalingResponseCodeType.webrtc, 471, 'Wrong WebRTC state'),
  notAcceptingNewSessions(SignalingResponseCodeType.session, 472, 'Currently not accepting new sessions');

  const SignalingResponseCode(this.type, this.code, this.description);

  final SignalingResponseCodeType type;
  final int code;
  final String description;

  @override
  String toString() {
    return 'SignalingResponseCode(type: $type, code: $code, description: $description)';
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
