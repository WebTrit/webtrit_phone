part of 'login_cubit.dart';

enum LoginStatus {
  input,
  processing,
  ok,
  back,
}

extension LoginStatusX on LoginStatus {
  bool get isInput => this == LoginStatus.input;

  bool get isProcessing => this == LoginStatus.processing;

  bool get isOk => this == LoginStatus.ok;

  bool get isBack => this == LoginStatus.back;
}

class LoginState extends Equatable {
  static const Object noError = Object();

  LoginState({
    this.tabIndex = 0,
    this.status = LoginStatus.input,
    this.error = noError,
    this.otpId,
    this.phoneInput = const PhoneInput.pure(),
    this.codeInput = const CodeInput.pure(),
  });

  final int tabIndex;
  final LoginStatus status;

  final Object error;
  final String? otpId;

  final PhoneInput phoneInput;
  final CodeInput codeInput;

  @override
  List<Object?> get props => [
        tabIndex,
        status,
        error,
        otpId,
        phoneInput,
        codeInput,
      ];

  LoginState copyWith({
    int? tabIndex,
    LoginStatus? status,
    Object? error,
    String? otpId,
    PhoneInput? phoneInput,
    CodeInput? codeInput,
  }) {
    return LoginState(
      tabIndex: tabIndex ?? this.tabIndex,
      status: status ?? this.status,
      error: error ?? this.error,
      otpId: otpId ?? this.otpId,
      phoneInput: phoneInput ?? this.phoneInput,
      codeInput: codeInput ?? this.codeInput,
    );
  }
}
