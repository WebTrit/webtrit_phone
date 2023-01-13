enum LoginStep {
  modeSelect,
  coreUrlAssign,
  otpRequest,
  otpVerify;

  static const pathParameterName = 'step';
}
