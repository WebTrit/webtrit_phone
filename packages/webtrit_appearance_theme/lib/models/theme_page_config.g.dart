// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_page_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemePageConfig _$ThemePageConfigFromJson(Map<String, dynamic> json) =>
    ThemePageConfig(
      login: json['login'] == null
          ? const LoginPageConfig()
          : LoginPageConfig.fromJson(json['login'] as Map<String, dynamic>),
      about: json['about'] == null
          ? const AboutPageConfig()
          : AboutPageConfig.fromJson(json['about'] as Map<String, dynamic>),
      dialing: json['dialing'] == null
          ? const CallPageConfig()
          : CallPageConfig.fromJson(json['dialing'] as Map<String, dynamic>),
      keypad: json['keypad'] == null
          ? const KeypadPageConfig()
          : KeypadPageConfig.fromJson(json['keypad'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ThemePageConfigToJson(ThemePageConfig instance) =>
    <String, dynamic>{
      'login': instance.login.toJson(),
      'about': instance.about.toJson(),
      'dialing': instance.dialing.toJson(),
      'keypad': instance.keypad.toJson(),
    };

LoginPageConfig _$LoginPageConfigFromJson(Map<String, dynamic> json) =>
    LoginPageConfig(
      modeSelect: json['modeSelect'] == null
          ? const LoginModeSelectPageConfig()
          : LoginModeSelectPageConfig.fromJson(
              json['modeSelect'] as Map<String, dynamic>,
            ),
      switchPage: json['switchPage'] == null
          ? const LoginSwitchPageConfig()
          : LoginSwitchPageConfig.fromJson(
              json['switchPage'] as Map<String, dynamic>,
            ),
      otpSigninVerify: json['otpSigninVerify'] == null
          ? const LoginOtpSigninVerifyScreenPageConfig()
          : LoginOtpSigninVerifyScreenPageConfig.fromJson(
              json['otpSigninVerify'] as Map<String, dynamic>,
            ),
      signupVerify: json['signupVerify'] == null
          ? const LoginSignupVerifyScreenPageConfig()
          : LoginSignupVerifyScreenPageConfig.fromJson(
              json['signupVerify'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$LoginPageConfigToJson(LoginPageConfig instance) =>
    <String, dynamic>{
      'modeSelect': instance.modeSelect.toJson(),
      'switchPage': instance.switchPage.toJson(),
      'otpSigninVerify': instance.otpSigninVerify.toJson(),
      'signupVerify': instance.signupVerify.toJson(),
    };

LoginOtpSigninVerifyScreenPageConfig
_$LoginOtpSigninVerifyScreenPageConfigFromJson(Map<String, dynamic> json) =>
    LoginOtpSigninVerifyScreenPageConfig(
      countdownRepeatIntervalSeconds:
          (json['countdownRepeatIntervalSeconds'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$LoginOtpSigninVerifyScreenPageConfigToJson(
  LoginOtpSigninVerifyScreenPageConfig instance,
) => <String, dynamic>{
  'countdownRepeatIntervalSeconds': instance.countdownRepeatIntervalSeconds,
};

LoginSignupVerifyScreenPageConfig _$LoginSignupVerifyScreenPageConfigFromJson(
  Map<String, dynamic> json,
) => LoginSignupVerifyScreenPageConfig(
  countdownRepeatIntervalSeconds:
      (json['countdownRepeatIntervalSeconds'] as num?)?.toInt() ?? 30,
);

Map<String, dynamic> _$LoginSignupVerifyScreenPageConfigToJson(
  LoginSignupVerifyScreenPageConfig instance,
) => <String, dynamic>{
  'countdownRepeatIntervalSeconds': instance.countdownRepeatIntervalSeconds,
};

LoginModeSelectPageConfig _$LoginModeSelectPageConfigFromJson(
  Map<String, dynamic> json,
) => LoginModeSelectPageConfig(
  systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
      ? null
      : OverlayStyleModel.fromJson(
          json['systemUiOverlayStyle'] as Map<String, dynamic>,
        ),
  mainLogo: json['mainLogo'] == null
      ? null
      : ImageSource.fromJson(json['mainLogo'] as Map<String, dynamic>),
  buttonLoginStyleType:
      $enumDecodeNullable(
        _$ElevatedButtonStyleTypeEnumMap,
        json['buttonLoginStyleType'],
      ) ??
      ElevatedButtonStyleType.primary,
  buttonSignupStyleType:
      $enumDecodeNullable(
        _$ElevatedButtonStyleTypeEnumMap,
        json['buttonSignupStyleType'],
      ) ??
      ElevatedButtonStyleType.primary,
);

Map<String, dynamic> _$LoginModeSelectPageConfigToJson(
  LoginModeSelectPageConfig instance,
) => <String, dynamic>{
  'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
  'mainLogo': instance.mainLogo?.toJson(),
  'buttonLoginStyleType':
      _$ElevatedButtonStyleTypeEnumMap[instance.buttonLoginStyleType]!,
  'buttonSignupStyleType':
      _$ElevatedButtonStyleTypeEnumMap[instance.buttonSignupStyleType]!,
};

const _$ElevatedButtonStyleTypeEnumMap = {
  ElevatedButtonStyleType.primary: 'primary',
  ElevatedButtonStyleType.neutral: 'neutral',
  ElevatedButtonStyleType.primaryOnDark: 'primaryOnDark',
  ElevatedButtonStyleType.neutralOnDark: 'neutralOnDark',
};

LoginSwitchPageConfig _$LoginSwitchPageConfigFromJson(
  Map<String, dynamic> json,
) => LoginSwitchPageConfig(
  mainLogo: json['mainLogo'] == null
      ? null
      : ImageSource.fromJson(json['mainLogo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginSwitchPageConfigToJson(
  LoginSwitchPageConfig instance,
) => <String, dynamic>{'mainLogo': instance.mainLogo?.toJson()};

AboutPageConfig _$AboutPageConfigFromJson(Map<String, dynamic> json) =>
    AboutPageConfig(
      mainLogo: json['mainLogo'] == null
          ? null
          : ImageSource.fromJson(json['mainLogo'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AboutPageConfigToJson(AboutPageConfig instance) =>
    <String, dynamic>{
      'mainLogo': instance.mainLogo?.toJson(),
      'metadata': instance.metadata.toJson(),
    };

CallPageConfig _$CallPageConfigFromJson(
  Map<String, dynamic> json,
) => CallPageConfig(
  systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
      ? null
      : OverlayStyleModel.fromJson(
          json['systemUiOverlayStyle'] as Map<String, dynamic>,
        ),
  appBarStyle: json['appBarStyle'] == null
      ? null
      : AppBarStyleConfig.fromJson(json['appBarStyle'] as Map<String, dynamic>),
  callInfo: json['callInfo'] == null
      ? null
      : CallPageInfoConfig.fromJson(json['callInfo'] as Map<String, dynamic>),
  actions: json['actions'] == null
      ? null
      : CallPageActionsConfig.fromJson(json['actions'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CallPageConfigToJson(CallPageConfig instance) =>
    <String, dynamic>{
      'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
      'appBarStyle': instance.appBarStyle?.toJson(),
      'callInfo': instance.callInfo?.toJson(),
      'actions': instance.actions?.toJson(),
    };

CallPageActionsConfig _$CallPageActionsConfigFromJson(
  Map<String, dynamic> json,
) => CallPageActionsConfig(
  callStart: json['callStart'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['callStart'] as Map<String, dynamic>,
        ),
  hangup: json['hangup'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['hangup'] as Map<String, dynamic>,
        ),
  transfer: json['transfer'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['transfer'] as Map<String, dynamic>,
        ),
  camera: json['camera'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['camera'] as Map<String, dynamic>,
        ),
  muted: json['muted'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['muted'] as Map<String, dynamic>,
        ),
  speaker: json['speaker'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['speaker'] as Map<String, dynamic>,
        ),
  held: json['held'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['held'] as Map<String, dynamic>,
        ),
  swap: json['swap'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['swap'] as Map<String, dynamic>,
        ),
  key: json['key'] == null
      ? const ElevatedButtonWidgetConfig()
      : ElevatedButtonWidgetConfig.fromJson(
          json['key'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CallPageActionsConfigToJson(
  CallPageActionsConfig instance,
) => <String, dynamic>{
  'callStart': instance.callStart.toJson(),
  'hangup': instance.hangup.toJson(),
  'transfer': instance.transfer.toJson(),
  'camera': instance.camera.toJson(),
  'muted': instance.muted.toJson(),
  'speaker': instance.speaker.toJson(),
  'held': instance.held.toJson(),
  'swap': instance.swap.toJson(),
  'key': instance.key.toJson(),
};

CallPageInfoConfig _$CallPageInfoConfigFromJson(Map<String, dynamic> json) =>
    CallPageInfoConfig(
      usernameTextStyle: json['usernameTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['usernameTextStyle'] as Map<String, dynamic>,
            ),
      numberTextStyle: json['numberTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['numberTextStyle'] as Map<String, dynamic>,
            ),
      callStatusTextStyle: json['callStatusTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['callStatusTextStyle'] as Map<String, dynamic>,
            ),
      processingStatusTextStyle: json['processingStatusTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['processingStatusTextStyle'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CallPageInfoConfigToJson(CallPageInfoConfig instance) =>
    <String, dynamic>{
      'usernameTextStyle': instance.usernameTextStyle?.toJson(),
      'numberTextStyle': instance.numberTextStyle?.toJson(),
      'callStatusTextStyle': instance.callStatusTextStyle?.toJson(),
      'processingStatusTextStyle': instance.processingStatusTextStyle?.toJson(),
    };

KeypadPageConfig _$KeypadPageConfigFromJson(Map<String, dynamic> json) =>
    KeypadPageConfig(
      systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
          ? null
          : OverlayStyleModel.fromJson(
              json['systemUiOverlayStyle'] as Map<String, dynamic>,
            ),
      textField: json['textField'] == null
          ? null
          : TextFieldConfig.fromJson(json['textField'] as Map<String, dynamic>),
      contactName: json['contactName'] == null
          ? null
          : TextFieldConfig.fromJson(
              json['contactName'] as Map<String, dynamic>,
            ),
      keypad: json['keypad'] == null
          ? null
          : KeypadStyleConfig.fromJson(json['keypad'] as Map<String, dynamic>),
      actionpad: json['actionpad'] == null
          ? null
          : ActionPadWidgetConfig.fromJson(
              json['actionpad'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$KeypadPageConfigToJson(KeypadPageConfig instance) =>
    <String, dynamic>{
      'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
      'textField': instance.textField?.toJson(),
      'contactName': instance.contactName?.toJson(),
      'keypad': instance.keypad?.toJson(),
      'actionpad': instance.actionpad?.toJson(),
    };
