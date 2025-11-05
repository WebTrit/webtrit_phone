import 'package:freezed_annotation/freezed_annotation.dart';

import 'common/leading_avatar_style_config.dart';
import 'custom_color.dart';
import 'features_config/metadata.dart';
import 'resources/image_source.dart';

part 'theme_widget_config.freezed.dart';

part 'theme_widget_config.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class ThemeWidgetConfig with _$ThemeWidgetConfig {
  const ThemeWidgetConfig({
    this.fonts = const FontsConfig(),
    this.button = const ButtonWidgetConfig(),
    this.group = const GroupWidgetConfig(),
    this.bar = const BarWidgetConfig(),
    this.imageAssets = const ImageAssetsConfig(),
    this.input = const InputWidgetConfig(),
    this.text = const TextWidgetConfig(),
    this.dialog = const DialogWidgetConfig(),
    this.actionPad = const ActionPadWidgetConfig(),
    this.statuses = const StatusesWidgetConfig(),
    this.decorationConfig = const DecorationConfig(),
  });

  @override
  final FontsConfig fonts;

  @override
  final ButtonWidgetConfig button;

  @override
  final GroupWidgetConfig? group;

  @override
  final BarWidgetConfig bar;

  @override
  final ImageAssetsConfig imageAssets;

  @override
  final InputWidgetConfig input;

  @override
  final TextWidgetConfig text;

  @override
  final DialogWidgetConfig dialog;

  @override
  final ActionPadWidgetConfig actionPad;

  @override
  final StatusesWidgetConfig statuses;

  @override
  final DecorationConfig decorationConfig;

  factory ThemeWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$ThemeWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ThemeWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class FontsConfig with _$FontsConfig {
  const FontsConfig({this.fontFamily});

  @override
  final String? fontFamily;

  factory FontsConfig.fromJson(Map<String, Object?> json) =>
      _$FontsConfigFromJson(json);

  Map<String, Object?> toJson() => _$FontsConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ButtonWidgetConfig with _$ButtonWidgetConfig {
  const ButtonWidgetConfig(
      {this.primaryElevatedButton = const ElevatedButtonWidgetConfig()});

  @override
  final ElevatedButtonWidgetConfig primaryElevatedButton;

  factory ButtonWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$ButtonWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ButtonWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ElevatedButtonWidgetConfig with _$ElevatedButtonWidgetConfig {
  const ElevatedButtonWidgetConfig({
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.iconColor,
    this.disabledIconColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
  });

  @override
  final String? backgroundColor;

  @override
  final String? foregroundColor;

  @override
  final String? textColor;

  @override
  final String? iconColor;

  @override
  final String? disabledIconColor;

  @override
  final String? disabledBackgroundColor;

  @override
  final String? disabledForegroundColor;

  factory ElevatedButtonWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$ElevatedButtonWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ElevatedButtonWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class GroupWidgetConfig with _$GroupWidgetConfig {
  const GroupWidgetConfig({
    this.groupTitleListTile = const GroupTitleListTileWidgetConfig(),
    // TODO(Serdun): Remove in future major release after migrating to CallPageActionsConfig
    // ignore: deprecated_member_use_from_same_package
    this.callActions = const CallActionsWidgetConfig(),
  });

  @override
  final GroupTitleListTileWidgetConfig groupTitleListTile;

  @override
  @Deprecated('Use CallPageActionsConfig instead')
  final CallActionsWidgetConfig callActions;

  factory GroupWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$GroupWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$GroupWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class BarWidgetConfig with _$BarWidgetConfig {
  const BarWidgetConfig({
    this.bottomNavigationBar = const BottomNavigationBarWidgetConfig(),
    this.extTabBar = const ExtTabBarWidgetConfig(),
  });

  @override
  final BottomNavigationBarWidgetConfig bottomNavigationBar;

  @override
  final ExtTabBarWidgetConfig extTabBar;

  factory BarWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$BarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$BarWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class BottomNavigationBarWidgetConfig with _$BottomNavigationBarWidgetConfig {
  const BottomNavigationBarWidgetConfig(
      {this.backgroundColor, this.selectedItemColor, this.unSelectedItemColor});

  @override
  final String? backgroundColor;

  @override
  final String? selectedItemColor;

  @override
  final String? unSelectedItemColor;

  factory BottomNavigationBarWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$BottomNavigationBarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() =>
      _$BottomNavigationBarWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ExtTabBarWidgetConfig with _$ExtTabBarWidgetConfig {
  const ExtTabBarWidgetConfig({
    this.foregroundColor,
    this.backgroundColor,
    this.selectedItemColor,
    this.unSelectedItemColor,
  });

  @override
  final String? foregroundColor;

  @override
  final String? backgroundColor;

  @override
  final String? selectedItemColor;

  @override
  final String? unSelectedItemColor;

  factory ExtTabBarWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$ExtTabBarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ExtTabBarWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class GroupTitleListTileWidgetConfig with _$GroupTitleListTileWidgetConfig {
  const GroupTitleListTileWidgetConfig({this.backgroundColor, this.textColor});

  @override
  final String? backgroundColor;

  @override
  final String? textColor;

  factory GroupTitleListTileWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$GroupTitleListTileWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$GroupTitleListTileWidgetConfigToJson(this);
}

@Deprecated('Use CallPageActionsConfig instead')
@freezed
@JsonSerializable(explicitToJson: true)
class CallActionsWidgetConfig with _$CallActionsWidgetConfig {
  const CallActionsWidgetConfig({
    this.callStartBackgroundColor,
    this.hangupBackgroundColor,
    this.transferBackgroundColor,
    this.cameraBackgroundColor,
    this.cameraActiveBackgroundColor,
    this.mutedBackgroundColor,
    this.mutedActiveBackgroundColor,
    this.speakerBackgroundColor,
    this.speakerActiveBackgroundColor,
    this.heldBackgroundColor,
    this.heldActiveBackgroundColor,
    this.swapBackgroundColor,
    this.keyBackgroundColor,
    this.keypadBackgroundColor,
    this.keypadActiveBackgroundColor,
  });

  @override
  final String? callStartBackgroundColor;

  @override
  final String? hangupBackgroundColor;

  @override
  final String? transferBackgroundColor;

  @override
  final String? cameraBackgroundColor;

  @override
  final String? cameraActiveBackgroundColor;

  @override
  final String? mutedBackgroundColor;

  @override
  final String? mutedActiveBackgroundColor;

  @override
  final String? speakerBackgroundColor;

  @override
  final String? speakerActiveBackgroundColor;

  @override
  final String? heldBackgroundColor;

  @override
  final String? heldActiveBackgroundColor;

  @override
  final String? swapBackgroundColor;

  @override
  final String? keyBackgroundColor;

  @override
  final String? keypadBackgroundColor;

  @override
  final String? keypadActiveBackgroundColor;

  factory CallActionsWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$CallActionsWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallActionsWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ImageAssetsConfig with _$ImageAssetsConfig {
  const ImageAssetsConfig({
    this.defaultPlaceholderImage,
    this.appIcon = const AppIconWidgetConfig(),
    this.leadingAvatarStyle = const LeadingAvatarStyleConfig(),
  });

  @override
  final ImageSource? defaultPlaceholderImage;

  @override
  final AppIconWidgetConfig appIcon;

  @override
  final LeadingAvatarStyleConfig leadingAvatarStyle;

  static const String metadataPrimaryOnboardingLogoUrl =
      'primaryOnboardingLogoUrl';

  static const String metadataSecondaryOnboardingLogoUrl =
      'secondaryOnboardingLogoUrl';

  factory ImageAssetsConfig.fromJson(Map<String, Object?> json) =>
      _$ImageAssetsConfigFromJson(json);

  Map<String, Object?> toJson() => _$ImageAssetsConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ImageAssetConfig with _$ImageAssetConfig {
  const ImageAssetConfig({
    this.imageSource,
    this.widthFactor = 1.0,
    this.labelColor = '#FFFFFF',
    this.metadata = const Metadata(),
    @Deprecated('Use source.uri instead') this.uri,
  });

  @override
  final ImageSource? imageSource;

  @override
  final double widthFactor;

  @override
  final String labelColor;

  @override
  final Metadata metadata;

  @override
  @Deprecated('Use source.uri instead')
  final String? uri;

  factory ImageAssetConfig.fromJson(Map<String, Object?> json) =>
      _$ImageAssetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ImageAssetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppIconWidgetConfig with _$AppIconWidgetConfig {
  const AppIconWidgetConfig({this.color});

  @override
  final String? color;

  factory AppIconWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$AppIconWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$AppIconWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class InputWidgetConfig with _$InputWidgetConfig {
  const InputWidgetConfig({this.primary = const TextFormFieldWidgetConfig()});

  @override
  final TextFormFieldWidgetConfig primary;

  factory InputWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$InputWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$InputWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class TextFormFieldWidgetConfig with _$TextFormFieldWidgetConfig {
  const TextFormFieldWidgetConfig(
      {this.labelColor, this.border = const InputBorderWidgetConfig()});

  @override
  final String? labelColor;

  @override
  final InputBorderWidgetConfig border;

  factory TextFormFieldWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$TextFormFieldWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$TextFormFieldWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class InputBorderWidgetConfig with _$InputBorderWidgetConfig {
  const InputBorderWidgetConfig({
    this.disabled = const BorderWidgetConfig(),
    this.focused = const BorderWidgetConfig(),
    this.any = const BorderWidgetConfig(),
  });

  @override
  final BorderWidgetConfig disabled;

  @override
  final BorderWidgetConfig focused;

  @override
  final BorderWidgetConfig any;

  factory InputBorderWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$InputBorderWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$InputBorderWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class BorderWidgetConfig with _$BorderWidgetConfig {
  const BorderWidgetConfig({this.typicalColor, this.errorColor});

  @override
  final String? typicalColor;

  @override
  final String? errorColor;

  factory BorderWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$BorderWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$BorderWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class TextWidgetConfig with _$TextWidgetConfig {
  const TextWidgetConfig({
    this.selection = const TextSelectionWidgetConfig(),
    this.linkify = const LinkifyWidgetConfig(),
  });

  @override
  final TextSelectionWidgetConfig selection;

  @override
  final LinkifyWidgetConfig linkify;

  factory TextWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$TextWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$TextWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class TextSelectionWidgetConfig with _$TextSelectionWidgetConfig {
  const TextSelectionWidgetConfig(
      {this.cursorColor, this.selectionColor, this.selectionHandleColor});

  @override
  final String? cursorColor;

  @override
  final String? selectionColor;

  @override
  final String? selectionHandleColor;

  factory TextSelectionWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$TextSelectionWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$TextSelectionWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class LinkifyWidgetConfig with _$LinkifyWidgetConfig {
  const LinkifyWidgetConfig({this.styleColor, this.linkifyStyleColor});

  @override
  final String? styleColor;

  @override
  final String? linkifyStyleColor;

  factory LinkifyWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$LinkifyWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$LinkifyWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class DialogWidgetConfig with _$DialogWidgetConfig {
  const DialogWidgetConfig({
    this.confirmDialog = const ConfirmDialogWidgetConfig(),
    this.snackBar = const SnackBarWidgetConfig(),
  });

  @override
  final ConfirmDialogWidgetConfig confirmDialog;

  @override
  final SnackBarWidgetConfig snackBar;

  factory DialogWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$DialogWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$DialogWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ConfirmDialogWidgetConfig with _$ConfirmDialogWidgetConfig {
  const ConfirmDialogWidgetConfig(
      {this.activeButtonColor1,
      this.activeButtonColor2,
      this.defaultButtonColor});

  @override
  final String? activeButtonColor1;

  @override
  final String? activeButtonColor2;

  @override
  final String? defaultButtonColor;

  factory ConfirmDialogWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$ConfirmDialogWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ConfirmDialogWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class SnackBarWidgetConfig with _$SnackBarWidgetConfig {
  const SnackBarWidgetConfig({
    this.successBackgroundColor = '#75B943',
    this.errorBackgroundColor = '#E74C3C',
    this.infoBackgroundColor = '#494949',
    this.warningBackgroundColor = '#F95A14',
  });

  @override
  final String successBackgroundColor;

  @override
  final String errorBackgroundColor;

  @override
  final String infoBackgroundColor;

  @override
  final String warningBackgroundColor;

  factory SnackBarWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$SnackBarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$SnackBarWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ActionPadWidgetConfig with _$ActionPadWidgetConfig {
  const ActionPadWidgetConfig({
    this.callStart = const ElevatedButtonWidgetConfig(),
    this.callTransfer = const ElevatedButtonWidgetConfig(),
    this.backspacePressed = const ElevatedButtonWidgetConfig(),
  });

  @override
  final ElevatedButtonWidgetConfig callStart;

  @override
  final ElevatedButtonWidgetConfig callTransfer;

  @override
  final ElevatedButtonWidgetConfig backspacePressed;

  factory ActionPadWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$ActionPadWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ActionPadWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class StatusesWidgetConfig with _$StatusesWidgetConfig {
  const StatusesWidgetConfig({
    this.registrationStatuses = const RegistrationStatusesWidgetConfig(),
    this.callStatuses = const CallStatusesWidgetConfig(),
  });

  @override
  final RegistrationStatusesWidgetConfig registrationStatuses;

  @override
  final CallStatusesWidgetConfig callStatuses;

  factory StatusesWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$StatusesWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$StatusesWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class RegistrationStatusesWidgetConfig with _$RegistrationStatusesWidgetConfig {
  const RegistrationStatusesWidgetConfig(
      {this.online = '#75B943', this.offline = '#EEF3F6'});

  @override
  final String online;

  @override
  final String offline;

  factory RegistrationStatusesWidgetConfig.fromJson(
          Map<String, Object?> json) =>
      _$RegistrationStatusesWidgetConfigFromJson(json);

  Map<String, Object?> toJson() =>
      _$RegistrationStatusesWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class CallStatusesWidgetConfig with _$CallStatusesWidgetConfig {
  const CallStatusesWidgetConfig({
    this.connectivityNone = '#E74C3C',
    this.connectError = '#E74C3C',
    this.appUnregistered = '#494949',
    this.connectIssue = '#E74C3C',
    this.inProgress = '#123752',
    this.ready = '#75B943',
  });

  @override
  final String connectivityNone;

  @override
  final String connectError;

  @override
  final String appUnregistered;

  @override
  final String connectIssue;

  @override
  final String inProgress;

  @override
  final String ready;

  factory CallStatusesWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$CallStatusesWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallStatusesWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class DecorationConfig with _$DecorationConfig {
  const DecorationConfig(
      {this.primaryGradientColorsConfig = const GradientColorsConfig()});

  @override
  final GradientColorsConfig primaryGradientColorsConfig;

  factory DecorationConfig.fromJson(Map<String, Object?> json) =>
      _$DecorationConfigFromJson(json);

  Map<String, Object?> toJson() => _$DecorationConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class GradientColorsConfig with _$GradientColorsConfig {
  const GradientColorsConfig({this.colors = const []});

  @override
  final List<CustomColor> colors;

  factory GradientColorsConfig.fromJson(Map<String, Object?> json) =>
      _$GradientColorsConfigFromJson(json);

  Map<String, Object?> toJson() => _$GradientColorsConfigToJson(this);
}
