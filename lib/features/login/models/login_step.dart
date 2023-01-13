enum LoginStep {
  modeSelect,
  coreUrlAssign,
  otpRequest,
  otpVerify;

  static const queryParameterName = 'step';
}
