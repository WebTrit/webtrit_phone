import 'package:freezed_annotation/freezed_annotation.dart';

import 'common/leading_avatar_style_config.dart';
import 'custom_color.dart';
import 'features_config/metadata.dart';
import 'resources/image_source.dart';

part 'theme_widget_config.freezed.dart';

part 'theme_widget_config.g.dart';

@Freezed(equal: true)
class ThemeWidgetConfig with _$ThemeWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ThemeWidgetConfig({
    @Default(FontsConfig()) FontsConfig fonts,
    @Default(ButtonWidgetConfig()) ButtonWidgetConfig button,
    @Default(GroupWidgetConfig()) GroupWidgetConfig? group,
    @Default(BarWidgetConfig()) BarWidgetConfig bar,
    @Default(ImageAssetsConfig()) ImageAssetsConfig imageAssets,
    @Default(InputWidgetConfig()) InputWidgetConfig input,
    @Default(TextWidgetConfig()) TextWidgetConfig text,
    @Default(DialogWidgetConfig()) DialogWidgetConfig dialog,
    @Default(ActionPadWidgetConfig()) ActionPadWidgetConfig actionPad,
    @Default(StatusesWidgetConfig()) StatusesWidgetConfig statuses,
    @Default(DecorationConfig()) DecorationConfig decorationConfig,
  }) = _ThemeWidgetConfig;

  factory ThemeWidgetConfig.fromJson(Map<String, dynamic> json) => _$ThemeWidgetConfigFromJson(json);
}

@Freezed()
class FontsConfig with _$FontsConfig {
  @JsonSerializable(explicitToJson: true)
  const factory FontsConfig({
    String? fontFamily,
  }) = _FontsConfig;

  factory FontsConfig.fromJson(Map<String, dynamic> json) => _$FontsConfigFromJson(json);
}

@Freezed(equal: true)
class ButtonWidgetConfig with _$ButtonWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ButtonWidgetConfig({
    @Default(ElevatedButtonWidgetConfig()) ElevatedButtonWidgetConfig primaryElevatedButton,
  }) = _ButtonWidgetConfig;

  factory ButtonWidgetConfig.fromJson(Map<String, dynamic> json) => _$ButtonWidgetConfigFromJson(json);
}

@Freezed(equal: true)
class ElevatedButtonWidgetConfig with _$ElevatedButtonWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ElevatedButtonWidgetConfig({
    String? backgroundColor,
    String? foregroundColor,
    String? textColor,
    String? iconColor,
    String? disabledIconColor,
    String? disabledBackgroundColor,
    String? disabledForegroundColor,
  }) = _ElevatedButtonWidgetConfig;

  factory ElevatedButtonWidgetConfig.fromJson(Map<String, dynamic> json) => _$ElevatedButtonWidgetConfigFromJson(json);
}

@Freezed()
class GroupWidgetConfig with _$GroupWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory GroupWidgetConfig({
    @Default(GroupTitleListTileWidgetConfig()) GroupTitleListTileWidgetConfig groupTitleListTile,
    // TODO(Serdun): Remove in future major release after migrating to CallPageActionsConfig
    // ignore: deprecated_member_use_from_same_package
    @Default(CallActionsWidgetConfig()) CallActionsWidgetConfig callActions,
  }) = _GroupWidgetConfig;

  factory GroupWidgetConfig.fromJson(Map<String, dynamic> json) => _$GroupWidgetConfigFromJson(json);
}

@Freezed()
class BarWidgetConfig with _$BarWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory BarWidgetConfig({
    @Default(BottomNavigationBarWidgetConfig()) BottomNavigationBarWidgetConfig bottomNavigationBar,
    @Default(ExtTabBarWidgetConfig()) ExtTabBarWidgetConfig extTabBar,
  }) = _BarWidgetConfig;

  factory BarWidgetConfig.fromJson(Map<String, dynamic> json) => _$BarWidgetConfigFromJson(json);
}

@Freezed()
class BottomNavigationBarWidgetConfig with _$BottomNavigationBarWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory BottomNavigationBarWidgetConfig({
    String? backgroundColor,
    String? selectedItemColor,
    String? unSelectedItemColor,
  }) = _BottomNavigationBarWidgetConfig;

  factory BottomNavigationBarWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$BottomNavigationBarWidgetConfigFromJson(json);
}

@Freezed()
class ExtTabBarWidgetConfig with _$ExtTabBarWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ExtTabBarWidgetConfig({
    String? foregroundColor,
    String? backgroundColor,
    String? selectedItemColor,
    String? unSelectedItemColor,
  }) = _ExtTabBarWidgetConfig;

  factory ExtTabBarWidgetConfig.fromJson(Map<String, dynamic> json) => _$ExtTabBarWidgetConfigFromJson(json);
}

@Freezed()
class GroupTitleListTileWidgetConfig with _$GroupTitleListTileWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory GroupTitleListTileWidgetConfig({
    String? backgroundColor,
    String? textColor,
  }) = _GroupTitleListTileWidgetConfig;

  factory GroupTitleListTileWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$GroupTitleListTileWidgetConfigFromJson(json);
}

@Deprecated('Use CallPageActionsConfig instead')
@Freezed()
class CallActionsWidgetConfig with _$CallActionsWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory CallActionsWidgetConfig({
    String? callStartBackgroundColor,
    String? hangupBackgroundColor,
    String? transferBackgroundColor,
    String? cameraBackgroundColor,
    String? cameraActiveBackgroundColor,
    String? mutedBackgroundColor,
    String? mutedActiveBackgroundColor,
    String? speakerBackgroundColor,
    String? speakerActiveBackgroundColor,
    String? heldBackgroundColor,
    String? heldActiveBackgroundColor,
    String? swapBackgroundColor,
    String? keyBackgroundColor,
    String? keypadBackgroundColor,
    String? keypadActiveBackgroundColor,
  }) = _CallActionsWidgetConfig;

  factory CallActionsWidgetConfig.fromJson(Map<String, dynamic> json) => _$CallActionsWidgetConfigFromJson(json);
}

@Freezed()
class ImageAssetsConfig with _$ImageAssetsConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ImageAssetsConfig({
    @Default(ImageAssetConfig(imageSource: ImageSource(uri: 'asset://assets/primary_onboardin_logo.svg')))
    ImageAssetConfig primaryOnboardingLogo,
    @Default(ImageAssetConfig(imageSource: ImageSource(uri: 'asset://assets/secondary_onboardin_logo.svg')))
    ImageAssetConfig secondaryOnboardingLogo,
    @Default(AppIconWidgetConfig()) AppIconWidgetConfig appIcon,
    @Default(LeadingAvatarStyleConfig()) LeadingAvatarStyleConfig leadingAvatarStyle,
  }) = _ImageAssetsConfig;

  factory ImageAssetsConfig.fromJson(Map<String, dynamic> json) => _$ImageAssetsConfigFromJson(json);

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataPrimaryOnboardingLogoUrl = 'primaryOnboardingLogoUrl';

  /// A globally consistent metadata key used to associate additional resources
  static const String metadataSecondaryOnboardingLogoUrl = 'secondaryOnboardingLogoUrl';
}

@Freezed()
class ImageAssetConfig with _$ImageAssetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ImageAssetConfig({
    ImageSource? imageSource,
    @Default(1.0) double widthFactor,
    @Default('#FFFFFF') String labelColor,
    @Default(Metadata()) Metadata metadata,
    @Deprecated('Use source.uri instead') String? uri,
  }) = _ImageAssetConfig;

  factory ImageAssetConfig.fromJson(Map<String, dynamic> json) => _$ImageAssetConfigFromJson(json);
}

@Freezed()
class AppIconWidgetConfig with _$AppIconWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory AppIconWidgetConfig({
    String? color,
  }) = _AppIconWidgetConfig;

  factory AppIconWidgetConfig.fromJson(Map<String, dynamic> json) => _$AppIconWidgetConfigFromJson(json);
}

@Freezed()
class InputWidgetConfig with _$InputWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory InputWidgetConfig({
    @Default(TextFormFieldWidgetConfig()) TextFormFieldWidgetConfig primary,
  }) = _InputWidgetConfig;

  factory InputWidgetConfig.fromJson(Map<String, dynamic> json) => _$InputWidgetConfigFromJson(json);
}

@Freezed()
class TextFormFieldWidgetConfig with _$TextFormFieldWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory TextFormFieldWidgetConfig({
    String? labelColor,
    @Default(InputBorderWidgetConfig()) InputBorderWidgetConfig border,
  }) = _TextFormFieldWidgetConfig;

  factory TextFormFieldWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextFormFieldWidgetConfigFromJson(json);
}

@Freezed()
class InputBorderWidgetConfig with _$InputBorderWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory InputBorderWidgetConfig({
    @Default(BorderWidgetConfig()) BorderWidgetConfig disabled,
    @Default(BorderWidgetConfig()) BorderWidgetConfig focused,
    @Default(BorderWidgetConfig()) BorderWidgetConfig any,
  }) = _InputBorderWidgetConfig;

  factory InputBorderWidgetConfig.fromJson(Map<String, dynamic> json) => _$InputBorderWidgetConfigFromJson(json);
}

@Freezed()
class BorderWidgetConfig with _$BorderWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory BorderWidgetConfig({
    String? typicalColor,
    String? errorColor,
  }) = _BorderWidgetConfig;

  factory BorderWidgetConfig.fromJson(Map<String, dynamic> json) => _$BorderWidgetConfigFromJson(json);
}

@Freezed()
class TextWidgetConfig with _$TextWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory TextWidgetConfig({
    @Default(TextSelectionWidgetConfig()) TextSelectionWidgetConfig selection,
    @Default(LinkifyWidgetConfig()) LinkifyWidgetConfig linkify,
  }) = _TextWidgetConfig;

  factory TextWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextWidgetConfigFromJson(json);
}

@Freezed()
class TextSelectionWidgetConfig with _$TextSelectionWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory TextSelectionWidgetConfig({
    String? cursorColor,
    String? selectionColor,
    String? selectionHandleColor,
  }) = _TextSelectionWidgetConfig;

  factory TextSelectionWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextSelectionWidgetConfigFromJson(json);
}

@Freezed()
class LinkifyWidgetConfig with _$LinkifyWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory LinkifyWidgetConfig({
    String? styleColor,
    String? linkifyStyleColor,
  }) = _LinkifyWidgetConfig;

  factory LinkifyWidgetConfig.fromJson(Map<String, dynamic> json) => _$LinkifyWidgetConfigFromJson(json);
}

@Freezed()
class DialogWidgetConfig with _$DialogWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory DialogWidgetConfig({
    @Default(ConfirmDialogWidgetConfig()) ConfirmDialogWidgetConfig confirmDialog,
    @Default(SnackBarWidgetConfig()) SnackBarWidgetConfig snackBar,
  }) = _DialogWidgetConfig;

  factory DialogWidgetConfig.fromJson(Map<String, dynamic> json) => _$DialogWidgetConfigFromJson(json);
}

@Freezed()
class ConfirmDialogWidgetConfig with _$ConfirmDialogWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ConfirmDialogWidgetConfig({
    String? activeButtonColor1,
    String? activeButtonColor2,
    String? defaultButtonColor,
  }) = _ConfirmDialogWidgetConfig;

  factory ConfirmDialogWidgetConfig.fromJson(Map<String, dynamic> json) => _$ConfirmDialogWidgetConfigFromJson(json);
}

@Freezed()
class SnackBarWidgetConfig with _$SnackBarWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory SnackBarWidgetConfig({
    @Default('#75B943') String successBackgroundColor,
    @Default('#E74C3C') String errorBackgroundColor,
    @Default('#494949') String infoBackgroundColor,
    @Default('#F95A14') String warningBackgroundColor,
  }) = _SnackBarWidgetConfig;

  factory SnackBarWidgetConfig.fromJson(Map<String, dynamic> json) => _$SnackBarWidgetConfigFromJson(json);
}

@Freezed()
class ActionPadWidgetConfig with _$ActionPadWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory ActionPadWidgetConfig({
    @Default(ElevatedButtonWidgetConfig()) ElevatedButtonWidgetConfig callStart,
    @Default(ElevatedButtonWidgetConfig()) ElevatedButtonWidgetConfig callTransfer,
    @Default(ElevatedButtonWidgetConfig()) ElevatedButtonWidgetConfig backspacePressed,
  }) = _ActionPadWidgetConfig;

  factory ActionPadWidgetConfig.fromJson(Map<String, dynamic> json) => _$ActionPadWidgetConfigFromJson(json);
}

@Freezed()
class StatusesWidgetConfig with _$StatusesWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory StatusesWidgetConfig({
    @Default(RegistrationStatusesWidgetConfig()) RegistrationStatusesWidgetConfig registrationStatuses,
    @Default(CallStatusesWidgetConfig()) CallStatusesWidgetConfig callStatuses,
  }) = _StatusesWidgetConfig;

  factory StatusesWidgetConfig.fromJson(Map<String, dynamic> json) => _$StatusesWidgetConfigFromJson(json);
}

@Freezed()
class RegistrationStatusesWidgetConfig with _$RegistrationStatusesWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  const factory RegistrationStatusesWidgetConfig({
    @Default('#75B943') String online,
    @Default('#EEF3F6') String offline,
  }) = _RegistrationStatusesWidgetConfig;

  factory RegistrationStatusesWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$RegistrationStatusesWidgetConfigFromJson(json);
}

@Freezed()
class CallStatusesWidgetConfig with _$CallStatusesWidgetConfig {
  @JsonSerializable(explicitToJson: true)
  // ignore: invalid_annotation_target
  const factory CallStatusesWidgetConfig({
    @Default('#E74C3C') String connectivityNone,
    @Default('#E74C3C') String connectError,
    @Default('#494949') String appUnregistered,
    @Default('#E74C3C') String connectIssue,
    @Default('#123752') String inProgress,
    @Default('#75B943') String ready,
  }) = _CallStatusesWidgetConfig;

  factory CallStatusesWidgetConfig.fromJson(Map<String, dynamic> json) => _$CallStatusesWidgetConfigFromJson(json);
}

@Freezed()
class DecorationConfig with _$DecorationConfig {
  @JsonSerializable(explicitToJson: true)
  const factory DecorationConfig({
    @Default(GradientColorsConfig()) GradientColorsConfig primaryGradientColorsConfig,
  }) = _DecorationConfig;

  factory DecorationConfig.fromJson(Map<String, dynamic> json) => _$DecorationConfigFromJson(json);
}

@Freezed()
class GradientColorsConfig with _$GradientColorsConfig {
  @JsonSerializable(explicitToJson: true)
  const factory GradientColorsConfig({
    @Default([]) List<CustomColor> colors,
  }) = _PrimaryGradientColorsConfig;

  factory GradientColorsConfig.fromJson(Map<String, dynamic> json) => _$GradientColorsConfigFromJson(json);
}
