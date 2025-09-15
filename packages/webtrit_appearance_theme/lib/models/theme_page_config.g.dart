// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_page_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemePageConfigImpl _$$ThemePageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$ThemePageConfigImpl(
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

Map<String, dynamic> _$$ThemePageConfigImplToJson(
        _$ThemePageConfigImpl instance) =>
    <String, dynamic>{
      'login': instance.login.toJson(),
      'about': instance.about.toJson(),
      'dialing': instance.dialing.toJson(),
      'keypad': instance.keypad.toJson(),
    };

_$LoginPageConfigImpl _$$LoginPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginPageConfigImpl(
      imageSource: json['imageSource'] == null
          ? null
          : ImageSource.fromJson(json['imageSource'] as Map<String, dynamic>),
      picture: json['picture'] as String?,
      scale: (json['scale'] as num?)?.toDouble(),
      labelColor: json['labelColor'] as String?,
      modeSelect: json['modeSelect'] == null
          ? const LoginModeSelectPageConfig()
          : LoginModeSelectPageConfig.fromJson(
              json['modeSelect'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginPageConfigImplToJson(
        _$LoginPageConfigImpl instance) =>
    <String, dynamic>{
      'imageSource': instance.imageSource?.toJson(),
      'picture': instance.picture,
      'scale': instance.scale,
      'labelColor': instance.labelColor,
      'modeSelect': instance.modeSelect.toJson(),
      'metadata': instance.metadata.toJson(),
    };

_$LoginModeSelectPageConfigImpl _$$LoginModeSelectPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginModeSelectPageConfigImpl(
      systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
          ? null
          : OverlayStyleModel.fromJson(
              json['systemUiOverlayStyle'] as Map<String, dynamic>),
      buttonLoginStyleType: $enumDecodeNullable(
              _$ElevatedButtonStyleTypeEnumMap, json['buttonLoginStyleType']) ??
          ElevatedButtonStyleType.primary,
      buttonSignupStyleType: $enumDecodeNullable(
              _$ElevatedButtonStyleTypeEnumMap,
              json['buttonSignupStyleType']) ??
          ElevatedButtonStyleType.primary,
    );

Map<String, dynamic> _$$LoginModeSelectPageConfigImplToJson(
        _$LoginModeSelectPageConfigImpl instance) =>
    <String, dynamic>{
      'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
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

_$AboutPageConfigImpl _$$AboutPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$AboutPageConfigImpl(
      imageSource: json['imageSource'] == null
          ? null
          : ImageSource.fromJson(json['imageSource'] as Map<String, dynamic>),
      picture: json['picture'] as String?,
      metadata: json['metadata'] == null
          ? const Metadata()
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AboutPageConfigImplToJson(
        _$AboutPageConfigImpl instance) =>
    <String, dynamic>{
      'imageSource': instance.imageSource?.toJson(),
      'picture': instance.picture,
      'metadata': instance.metadata.toJson(),
    };

_$CallPageConfigImpl _$$CallPageConfigImplFromJson(Map<String, dynamic> json) =>
    _$CallPageConfigImpl(
      systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
          ? null
          : OverlayStyleModel.fromJson(
              json['systemUiOverlayStyle'] as Map<String, dynamic>),
      appBarStyle: json['appBarStyle'] == null
          ? null
          : AppBarStyleConfig.fromJson(
              json['appBarStyle'] as Map<String, dynamic>),
      callInfo: json['callInfo'] == null
          ? null
          : CallPageInfoConfig.fromJson(
              json['callInfo'] as Map<String, dynamic>),
      actions: json['actions'] == null
          ? null
          : CallPageActionsConfig.fromJson(
              json['actions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CallPageConfigImplToJson(
        _$CallPageConfigImpl instance) =>
    <String, dynamic>{
      'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
      'appBarStyle': instance.appBarStyle?.toJson(),
      'callInfo': instance.callInfo?.toJson(),
      'actions': instance.actions?.toJson(),
    };

_$CallPageActionsConfigImpl _$$CallPageActionsConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$CallPageActionsConfigImpl(
      callStart: json['callStart'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['callStart'] as Map<String, dynamic>),
      hangup: json['hangup'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['hangup'] as Map<String, dynamic>),
      transfer: json['transfer'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['transfer'] as Map<String, dynamic>),
      camera: json['camera'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['camera'] as Map<String, dynamic>),
      muted: json['muted'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['muted'] as Map<String, dynamic>),
      speaker: json['speaker'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['speaker'] as Map<String, dynamic>),
      held: json['held'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['held'] as Map<String, dynamic>),
      swap: json['swap'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['swap'] as Map<String, dynamic>),
      key: json['key'] == null
          ? const ElevatedButtonWidgetConfig()
          : ElevatedButtonWidgetConfig.fromJson(
              json['key'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CallPageActionsConfigImplToJson(
        _$CallPageActionsConfigImpl instance) =>
    <String, dynamic>{
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

_$CallPageInfoConfigImpl _$$CallPageInfoConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$CallPageInfoConfigImpl(
      usernameTextStyle: json['usernameTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['usernameTextStyle'] as Map<String, dynamic>),
      numberTextStyle: json['numberTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['numberTextStyle'] as Map<String, dynamic>),
      callStatusTextStyle: json['callStatusTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['callStatusTextStyle'] as Map<String, dynamic>),
      processingStatusTextStyle: json['processingStatusTextStyle'] == null
          ? null
          : TextStyleConfig.fromJson(
              json['processingStatusTextStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CallPageInfoConfigImplToJson(
        _$CallPageInfoConfigImpl instance) =>
    <String, dynamic>{
      'usernameTextStyle': instance.usernameTextStyle?.toJson(),
      'numberTextStyle': instance.numberTextStyle?.toJson(),
      'callStatusTextStyle': instance.callStatusTextStyle?.toJson(),
      'processingStatusTextStyle': instance.processingStatusTextStyle?.toJson(),
    };

_$KeypadPageConfigImpl _$$KeypadPageConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$KeypadPageConfigImpl(
      systemUiOverlayStyle: json['systemUiOverlayStyle'] == null
          ? null
          : OverlayStyleModel.fromJson(
              json['systemUiOverlayStyle'] as Map<String, dynamic>),
      textField: json['textField'] == null
          ? null
          : TextFieldConfig.fromJson(json['textField'] as Map<String, dynamic>),
      contactName: json['contactName'] == null
          ? null
          : TextFieldConfig.fromJson(
              json['contactName'] as Map<String, dynamic>),
      keypad: json['keypad'] == null
          ? null
          : KeypadStyleConfig.fromJson(json['keypad'] as Map<String, dynamic>),
      actionpad: json['actionpad'] == null
          ? null
          : ActionPadWidgetConfig.fromJson(
              json['actionpad'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$KeypadPageConfigImplToJson(
        _$KeypadPageConfigImpl instance) =>
    <String, dynamic>{
      'systemUiOverlayStyle': instance.systemUiOverlayStyle?.toJson(),
      'textField': instance.textField?.toJson(),
      'contactName': instance.contactName?.toJson(),
      'keypad': instance.keypad?.toJson(),
      'actionpad': instance.actionpad?.toJson(),
    };
