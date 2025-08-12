import 'package:freezed_annotation/freezed_annotation.dart';

import 'common/common.dart';
import 'features_config/elevated_button_style_type.dart';
import 'features_config/metadata.dart';

part 'theme_page_config.freezed.dart';

part 'theme_page_config.g.dart';

@Freezed()
class ThemePageConfig with _$ThemePageConfig {
  @JsonSerializable(explicitToJson: true)
  // ignore: invalid_annotation_target
  const factory ThemePageConfig({
    @Default(LoginPageConfig()) LoginPageConfig login,
    @Default(AboutPageConfig()) AboutPageConfig about,
    @Default(CallPageConfig()) CallPageConfig dialing,
  }) = _ThemePageConfig;

  factory ThemePageConfig.fromJson(Map<String, dynamic> json) => _$ThemePageConfigFromJson(json);
}

// TODO(Serdun): Decompose image properties into a separate class
// TODO(Serdun): Split LoginPageConfig, as it currently mixes data from the Welcome Page and various login pages.
@Freezed()
class LoginPageConfig with _$LoginPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LoginPageConfig({
    String? picture,
    double? scale,
    String? labelColor,
    @Default(LoginModeSelectPageConfig()) LoginModeSelectPageConfig modeSelect,
    @Default(Metadata()) Metadata metadata,
  }) = _LoginPageConfig;

  factory LoginPageConfig.fromJson(Map<String, dynamic> json) => _$LoginPageConfigFromJson(json);

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataPictureUrl = 'pictureUrl';
}

@Freezed()
class LoginModeSelectPageConfig with _$LoginModeSelectPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LoginModeSelectPageConfig({
    OverlayStyleModel? systemUiOverlayStyle,
    @Default(ElevatedButtonStyleType.primary) ElevatedButtonStyleType buttonLoginStyleType,
    @Default(ElevatedButtonStyleType.primary) ElevatedButtonStyleType buttonSignupStyleType,
  }) = _LoginModeSelectPageConfig;

  factory LoginModeSelectPageConfig.fromJson(Map<String, dynamic> json) => _$LoginModeSelectPageConfigFromJson(json);
}

@Freezed()
class AboutPageConfig with _$AboutPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AboutPageConfig({
    String? picture,
    @Default(Metadata()) Metadata metadata,
  }) = _AboutPageConfig;

  factory AboutPageConfig.fromJson(Map<String, dynamic> json) => _$AboutPageConfigFromJson(json);

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataPictureUrl = 'pictureUrl';
}

@Freezed()
class CallPageConfig with _$CallPageConfig {
  @JsonSerializable(explicitToJson: true)
  const factory CallPageConfig({
    OverlayStyleModel? systemUiOverlayStyle,
    AppBarStyleConfig? appBarStyle,
    CallPageInfoConfig? callInfo,
  }) = _CallPageConfig;

  factory CallPageConfig.fromJson(Map<String, dynamic> json) => _$CallPageConfigFromJson(json);
}

@freezed
class CallPageInfoConfig with _$CallPageInfoConfig {
  @JsonSerializable(explicitToJson: true)
  const factory CallPageInfoConfig({
    /// Style for the main username (displayed with `displaySmall`)
    TextStyleConfig? usernameTextStyle,

    /// Style for the phone number if username is present (bodyLarge or displaySmall)
    TextStyleConfig? numberTextStyle,

    /// Style for the call status message (e.g. duration or “incoming”)
    TextStyleConfig? callStatusTextStyle,

    /// Style for the processing status message (e.g. “Transfer in progress”)
    TextStyleConfig? processingStatusTextStyle,
  }) = _CallPageInfoConfig;

  factory CallPageInfoConfig.fromJson(Map<String, dynamic> json) => _$CallPageInfoConfigFromJson(json);
}
