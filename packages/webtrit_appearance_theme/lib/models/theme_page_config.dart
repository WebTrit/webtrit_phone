import 'package:freezed_annotation/freezed_annotation.dart';

import 'features_config/elevated_button_style_type.dart';
import 'features_config/metadata.dart';
import 'common/common.dart';
import 'resources/image_source.dart';
import 'theme_widget_config.dart';

part 'theme_page_config.freezed.dart';

part 'theme_page_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class ThemePageConfig with _$ThemePageConfig {
  const ThemePageConfig({
    this.login = const LoginPageConfig(),
    this.about = const AboutPageConfig(),
    this.dialing = const CallPageConfig(),
    this.keypad = const KeypadPageConfig(),
  });

  @override
  final LoginPageConfig login;

  @override
  final AboutPageConfig about;

  @override
  final CallPageConfig dialing;

  @override
  final KeypadPageConfig keypad;

  factory ThemePageConfig.fromJson(Map<String, Object?> json) => _$ThemePageConfigFromJson(json);

  Map<String, Object?> toJson() => _$ThemePageConfigToJson(this);
}

/// Declarative configuration for the **Login Page**.
///
/// Defines appearance, layout, and metadata options
/// for the login-related screens.
@freezed
@JsonSerializable(explicitToJson: true)
class LoginPageConfig with _$LoginPageConfig {
  const LoginPageConfig({
    this.modeSelect = const LoginModeSelectPageConfig(),
    this.switchPage = const LoginSwitchPageConfig(),
    this.otpSignin = const LoginOtpSigninPageConfig(),
    this.passwordSignin = const LoginPasswordSigninPageConfig(),
    this.otpSigninVerify = const LoginOtpSigninVerifyScreenPageConfig(),
    this.signupVerify = const LoginSignupVerifyScreenPageConfig(),
  });

  @override
  final LoginModeSelectPageConfig modeSelect;

  @override
  final LoginSwitchPageConfig switchPage;

  @override
  final LoginOtpSigninPageConfig otpSignin;

  @override
  final LoginPasswordSigninPageConfig passwordSignin;

  @override
  final LoginOtpSigninVerifyScreenPageConfig otpSigninVerify;

  @override
  final LoginSignupVerifyScreenPageConfig signupVerify;

  factory LoginPageConfig.fromJson(Map<String, Object?> json) => _$LoginPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginPageConfigToJson(this);

  /// A globally consistent metadata key used to associate additional resources,
  /// specifically for the login page picture.
  static const String metadataPictureUrl = 'pictureUrl';
}

/// Configuration for the **OTP Signin Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class LoginOtpSigninPageConfig with _$LoginOtpSigninPageConfig {
  const LoginOtpSigninPageConfig({this.refTextField});

  @override
  final TextFieldConfig? refTextField;

  factory LoginOtpSigninPageConfig.fromJson(Map<String, Object?> json) => _$LoginOtpSigninPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginOtpSigninPageConfigToJson(this);
}

/// Configuration for the **Password Signin Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class LoginPasswordSigninPageConfig with _$LoginPasswordSigninPageConfig {
  const LoginPasswordSigninPageConfig({this.refTextField});

  @override
  final TextFieldConfig? refTextField;

  factory LoginPasswordSigninPageConfig.fromJson(Map<String, Object?> json) =>
      _$LoginPasswordSigninPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginPasswordSigninPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginOtpSigninVerifyScreenPageConfig with _$LoginOtpSigninVerifyScreenPageConfig {
  const LoginOtpSigninVerifyScreenPageConfig({this.countdownRepeatIntervalSeconds = 30});

  @override
  final int countdownRepeatIntervalSeconds;

  factory LoginOtpSigninVerifyScreenPageConfig.fromJson(Map<String, Object?> json) =>
      _$LoginOtpSigninVerifyScreenPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginOtpSigninVerifyScreenPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginSignupVerifyScreenPageConfig with _$LoginSignupVerifyScreenPageConfig {
  const LoginSignupVerifyScreenPageConfig({this.countdownRepeatIntervalSeconds = 30});

  @override
  final int countdownRepeatIntervalSeconds;

  factory LoginSignupVerifyScreenPageConfig.fromJson(Map<String, Object?> json) =>
      _$LoginSignupVerifyScreenPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginSignupVerifyScreenPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginModeSelectPageConfig with _$LoginModeSelectPageConfig {
  const LoginModeSelectPageConfig({
    this.systemUiOverlayStyle,
    this.mainLogo,
    this.buttonLoginStyleType = ElevatedButtonStyleType.primary,
    this.buttonSignupStyleType = ElevatedButtonStyleType.primary,
  });

  @override
  final OverlayStyleModel? systemUiOverlayStyle;

  @override
  final ImageSource? mainLogo;

  @override
  final ElevatedButtonStyleType buttonLoginStyleType;

  @override
  final ElevatedButtonStyleType buttonSignupStyleType;

  factory LoginModeSelectPageConfig.fromJson(Map<String, Object?> json) => _$LoginModeSelectPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginModeSelectPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LoginSwitchPageConfig with _$LoginSwitchPageConfig {
  const LoginSwitchPageConfig({this.mainLogo});

  @override
  final ImageSource? mainLogo;

  factory LoginSwitchPageConfig.fromJson(Map<String, Object?> json) => _$LoginSwitchPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$LoginSwitchPageConfigToJson(this);
}

/// Declarative configuration for the **About Page**.
@freezed
@JsonSerializable(explicitToJson: true)
class AboutPageConfig with _$AboutPageConfig {
  const AboutPageConfig({this.mainLogo, this.metadata = const Metadata()});

  @override
  final ImageSource? mainLogo;

  @override
  final Metadata metadata;

  factory AboutPageConfig.fromJson(Map<String, Object?> json) => _$AboutPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$AboutPageConfigToJson(this);

  /// A globally consistent metadata key used to associate additional resources,
  /// specifically for the About page picture.
  static const String metadataPictureUrl = 'pictureUrl';
}

/// Declarative configuration for the **Call Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class CallPageConfig with _$CallPageConfig {
  const CallPageConfig({this.systemUiOverlayStyle, this.appBarStyle, this.callInfo, this.actions});

  @override
  final OverlayStyleModel? systemUiOverlayStyle;

  @override
  final AppBarStyleConfig? appBarStyle;

  @override
  final CallPageInfoConfig? callInfo;

  @override
  final CallPageActionsConfig? actions;

  factory CallPageConfig.fromJson(Map<String, Object?> json) => _$CallPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class CallPageActionsConfig with _$CallPageActionsConfig {
  const CallPageActionsConfig({
    this.callStart = const ElevatedButtonWidgetConfig(),
    this.hangup = const ElevatedButtonWidgetConfig(),
    this.transfer = const ElevatedButtonWidgetConfig(),
    this.camera = const ElevatedButtonWidgetConfig(),
    this.muted = const ElevatedButtonWidgetConfig(),
    this.speaker = const ElevatedButtonWidgetConfig(),
    this.held = const ElevatedButtonWidgetConfig(),
    this.swap = const ElevatedButtonWidgetConfig(),
    this.key = const ElevatedButtonWidgetConfig(),
  });

  @override
  final ElevatedButtonWidgetConfig callStart;

  @override
  final ElevatedButtonWidgetConfig hangup;

  @override
  final ElevatedButtonWidgetConfig transfer;

  @override
  final ElevatedButtonWidgetConfig camera;

  @override
  final ElevatedButtonWidgetConfig muted;

  @override
  final ElevatedButtonWidgetConfig speaker;

  @override
  final ElevatedButtonWidgetConfig held;

  @override
  final ElevatedButtonWidgetConfig swap;

  @override
  final ElevatedButtonWidgetConfig key;

  factory CallPageActionsConfig.fromJson(Map<String, Object?> json) => _$CallPageActionsConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageActionsConfigToJson(this);
}

/// Declarative configuration for the **Call Info section**.
@freezed
@JsonSerializable(explicitToJson: true)
class CallPageInfoConfig with _$CallPageInfoConfig {
  const CallPageInfoConfig({
    this.usernameTextStyle,
    this.numberTextStyle,
    this.callStatusTextStyle,
    this.processingStatusTextStyle,
  });

  @override
  final TextStyleConfig? usernameTextStyle;

  @override
  final TextStyleConfig? numberTextStyle;

  @override
  final TextStyleConfig? callStatusTextStyle;

  @override
  final TextStyleConfig? processingStatusTextStyle;

  factory CallPageInfoConfig.fromJson(Map<String, Object?> json) => _$CallPageInfoConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallPageInfoConfigToJson(this);
}

/// Declarative configuration for the **Keypad Screen**.
@freezed
@JsonSerializable(explicitToJson: true)
class KeypadPageConfig with _$KeypadPageConfig {
  const KeypadPageConfig({this.systemUiOverlayStyle, this.textField, this.contactName, this.keypad, this.actionpad});

  @override
  final OverlayStyleModel? systemUiOverlayStyle;

  @override
  final TextFieldConfig? textField;

  @override
  final TextFieldConfig? contactName;

  @override
  final KeypadStyleConfig? keypad;

  @override
  final ActionPadWidgetConfig? actionpad;

  factory KeypadPageConfig.fromJson(Map<String, Object?> json) => _$KeypadPageConfigFromJson(json);

  Map<String, Object?> toJson() => _$KeypadPageConfigToJson(this);
}
