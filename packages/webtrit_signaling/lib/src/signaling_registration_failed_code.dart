enum SignalingRegistrationFailedCode {
  unmappedCode(-1),
  sipServerUnavailable(503);

  const SignalingRegistrationFailedCode(this.code);

  final int code;
}

extension SignalingRegistrationFailedCodeByCode on Iterable<SignalingRegistrationFailedCode> {
  SignalingRegistrationFailedCode byCode(int code) {
    for (var value in this) {
      if (value.code == code) return value;
    }
    return SignalingRegistrationFailedCode.unmappedCode;
  }
}
