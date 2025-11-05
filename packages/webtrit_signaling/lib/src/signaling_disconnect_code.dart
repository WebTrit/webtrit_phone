import 'package:web_socket_channel/status.dart' as status;

enum SignalingDisconnectCodeType { auxiliary, socket, session, app, controller, signaling, request }

enum SignalingDisconnectCode {
  normalClosure(SignalingDisconnectCodeType.auxiliary, status.normalClosure),
  goingAway(SignalingDisconnectCodeType.auxiliary, status.goingAway),
  protocolError(SignalingDisconnectCodeType.auxiliary, status.protocolError),
  unsupportedData(SignalingDisconnectCodeType.auxiliary, status.unsupportedData),
  noStatusReceived(SignalingDisconnectCodeType.auxiliary, status.noStatusReceived),
  abnormalClosure(SignalingDisconnectCodeType.auxiliary, status.abnormalClosure),
  invalidFramePayloadData(SignalingDisconnectCodeType.auxiliary, status.invalidFramePayloadData),
  policyViolation(SignalingDisconnectCodeType.auxiliary, status.policyViolation),
  messageTooBig(SignalingDisconnectCodeType.auxiliary, status.messageTooBig),
  missingMandatoryExtension(SignalingDisconnectCodeType.auxiliary, status.missingMandatoryExtension),
  internalServerError(SignalingDisconnectCodeType.auxiliary, status.internalServerError),
  tlsHandshakeFailed(SignalingDisconnectCodeType.auxiliary, status.tlsHandshakeFailed),
  unmappedCode(SignalingDisconnectCodeType.auxiliary, -1),
  unmappedError(SignalingDisconnectCodeType.auxiliary, 4000),
  socketMessageError(SignalingDisconnectCodeType.socket, 4101),
  sessionMissedError(SignalingDisconnectCodeType.session, 4201),
  appUnknownError(SignalingDisconnectCodeType.app, 4300),
  appMissedError(SignalingDisconnectCodeType.app, 4301),
  appUnregisteredError(SignalingDisconnectCodeType.app, 4302),
  controllerUnknownError(SignalingDisconnectCodeType.controller, 4400),
  controllerMissedError(SignalingDisconnectCodeType.controller, 4401),
  controllerExitError(SignalingDisconnectCodeType.controller, 4402),
  controllerBillingError(SignalingDisconnectCodeType.controller, 4410),
  controllerBillingAccountMissedError(SignalingDisconnectCodeType.controller, 4411),
  controllerBillingAccountCredentialsMissedError(SignalingDisconnectCodeType.controller, 4412),
  controllerWebrtcError(SignalingDisconnectCodeType.controller, 4420),
  controllerAttachedError(SignalingDisconnectCodeType.controller, 4431),
  controllerNotAttachedError(SignalingDisconnectCodeType.controller, 4432),
  controllerForceAttachClose(SignalingDisconnectCodeType.controller, 4441),
  signalingMessageError(SignalingDisconnectCodeType.signaling, 4501),
  signalingKeepaliveTimeoutError(SignalingDisconnectCodeType.signaling, 4502),
  requestUnknownError(SignalingDisconnectCodeType.request, 4600),
  requestExecuteError(SignalingDisconnectCodeType.request, 4601),
  requestExecuteTimeoutError(SignalingDisconnectCodeType.request, 4602),
  requestCallIdError(SignalingDisconnectCodeType.request, 4610);

  const SignalingDisconnectCode(this.type, this.code);

  final SignalingDisconnectCodeType type;
  final int code;
}

extension SignalingDisconnectCodeByCode on Iterable<SignalingDisconnectCode> {
  SignalingDisconnectCode byCode(int code) {
    for (var value in this) {
      if (value.code == code) return value;
    }
    return SignalingDisconnectCode.unmappedCode;
  }
}
