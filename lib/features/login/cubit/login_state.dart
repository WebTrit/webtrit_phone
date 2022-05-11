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

  const LoginState({
    this.tabIndex = 0,
    this.status = LoginStatus.input,
    this.error = noError,
    this.demo = false,
    this.otpId,
    this.coreUrlInput = const UrlInput.pure(),
    this.phoneInput = const PhoneInput.pure(),
    this.codeInput = const CodeInput.pure(),
  });

  final int tabIndex;
  final LoginStatus status;

  final Object error;
  final bool demo;
  final String? otpId;

  final UrlInput coreUrlInput;
  final PhoneInput phoneInput;
  final CodeInput codeInput;

  @override
  List<Object?> get props => [
        tabIndex,
        status,
        error,
        demo,
        otpId,
        coreUrlInput,
        phoneInput,
        codeInput,
      ];

  LoginState copyWith({
    int? tabIndex,
    LoginStatus? status,
    Object? error,
    bool? demo,
    String? otpId,
    UrlInput? coreUrlInput,
    PhoneInput? phoneInput,
    CodeInput? codeInput,
  }) {
    return LoginState(
      tabIndex: tabIndex ?? this.tabIndex,
      status: status ?? this.status,
      error: error ?? this.error,
      demo: demo ?? this.demo,
      otpId: otpId ?? this.otpId,
      coreUrlInput: coreUrlInput ?? this.coreUrlInput,
      phoneInput: phoneInput ?? this.phoneInput,
      codeInput: codeInput ?? this.codeInput,
    );
  }
}
