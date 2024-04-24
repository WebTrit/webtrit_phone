import 'package:freezed_annotation/freezed_annotation.dart';

import 'elevated_button_style_type.dart';
import 'theme_json_serializable.dart';

part 'theme_page_config.freezed.dart';

part 'theme_page_config.g.dart';

@freezed
class ThemePageConfig with _$ThemePageConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ThemePageConfig({
    LoginPageConfig? login,
  }) = _ThemePageConfig;

  factory ThemePageConfig.fromJson(Map<String, dynamic> json) => _$ThemePageConfigFromJson(json);
}

@freezed
class LoginPageConfig with _$LoginPageConfig {
  const factory LoginPageConfig({
    required LoginModeSelectPageConfig modeSelect,
  }) = _LoginPageConfig;

  factory LoginPageConfig.fromJson(Map<String, dynamic> json) => _$LoginPageConfigFromJson(json);
}

@freezed
class LoginModeSelectPageConfig with _$LoginModeSelectPageConfig {
  const factory LoginModeSelectPageConfig({
    required ElevatedButtonStyleType buttonLoginStyleType,
    required ElevatedButtonStyleType buttonSignupStyleType,
  }) = _LoginModeSelectPageConfig;

  factory LoginModeSelectPageConfig.fromJson(Map<String, dynamic> json) => _$LoginModeSelectPageConfigFromJson(json);
}
