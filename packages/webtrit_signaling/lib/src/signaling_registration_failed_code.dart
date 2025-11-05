enum SignalingRegistrationFailedCode {
  unmappedCode(-1),
  nullCode(0),
  sipServerUnavailable(503);

  const SignalingRegistrationFailedCode(this.code);

  final int code;
}

extension SignalingRegistrationFailedCodeByCode
    on Iterable<SignalingRegistrationFailedCode> {
  SignalingRegistrationFailedCode byCode(int? code) {
    if (code == null) return SignalingRegistrationFailedCode.nullCode;

    for (var value in this) {
      if (value.code == code) return value;
    }
    return SignalingRegistrationFailedCode.unmappedCode;
  }
}
