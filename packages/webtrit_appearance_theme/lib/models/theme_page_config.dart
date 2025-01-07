import 'package:freezed_annotation/freezed_annotation.dart';

import 'elevated_button_style_type.dart';

part 'theme_page_config.freezed.dart';

part 'theme_page_config.g.dart';

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ThemePageConfig with _$ThemePageConfig {
  // ignore: invalid_annotation_target
  const factory ThemePageConfig({
    LoginPageConfig? login,
    AboutPageConfig? about,
  }) = _ThemePageConfig;

  factory ThemePageConfig.fromJson(Map<String, dynamic> json) => _$ThemePageConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class LoginPageConfig with _$LoginPageConfig {
  const factory LoginPageConfig({
    required LoginModeSelectPageConfig modeSelect,
  }) = _LoginPageConfig;

  factory LoginPageConfig.fromJson(Map<String, dynamic> json) => _$LoginPageConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class LoginModeSelectPageConfig with _$LoginModeSelectPageConfig {
  const factory LoginModeSelectPageConfig({
    required ElevatedButtonStyleType buttonLoginStyleType,
    required ElevatedButtonStyleType buttonSignupStyleType,
  }) = _LoginModeSelectPageConfig;

  factory LoginModeSelectPageConfig.fromJson(Map<String, dynamic> json) => _$LoginModeSelectPageConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class AboutPageConfig with _$AboutPageConfig {
  const factory AboutPageConfig({
    required String picture,
  }) = _AboutPageConfig;

  factory AboutPageConfig.fromJson(Map<String, dynamic> json) => _$AboutPageConfigFromJson(json);
}
