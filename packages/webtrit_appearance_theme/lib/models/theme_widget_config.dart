import 'package:freezed_annotation/freezed_annotation.dart';

import 'common/common.dart';
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
    this.statuses = const StatusesWidgetConfig(),
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
  final StatusesWidgetConfig statuses;

  factory ThemeWidgetConfig.fromJson(Map<String, Object?> json) => _$ThemeWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ThemeWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class FontsConfig with _$FontsConfig {
  const FontsConfig({this.fontFamily});

  @override
  final String? fontFamily;

  factory FontsConfig.fromJson(Map<String, Object?> json) => _$FontsConfigFromJson(json);

  Map<String, Object?> toJson() => _$FontsConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ButtonWidgetConfig with _$ButtonWidgetConfig {
  const ButtonWidgetConfig({this.primaryElevatedButton});

  @override
  final ButtonStyleConfig? primaryElevatedButton;

  factory ButtonWidgetConfig.fromJson(Map<String, Object?> json) => _$ButtonWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ButtonWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class GroupWidgetConfig with _$GroupWidgetConfig {
  const GroupWidgetConfig({this.groupTitleListTile = const GroupTitleListTileWidgetConfig()});

  @override
  final GroupTitleListTileWidgetConfig groupTitleListTile;

  factory GroupWidgetConfig.fromJson(Map<String, Object?> json) => _$GroupWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$GroupWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class BarWidgetConfig with _$BarWidgetConfig {
  const BarWidgetConfig({
    this.bottomNavigationBar = const BottomNavigationBarWidgetConfig(),
    this.appBarConfig = const AppBarConfig(),
    this.tabBarConfig = const TabBarConfig(),
  });

  @override
  final BottomNavigationBarWidgetConfig bottomNavigationBar;

  @override
  final AppBarConfig appBarConfig;

  @override
  final TabBarConfig tabBarConfig;

  factory BarWidgetConfig.fromJson(Map<String, Object?> json) => _$BarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$BarWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class BottomNavigationBarWidgetConfig with _$BottomNavigationBarWidgetConfig {
  const BottomNavigationBarWidgetConfig({this.backgroundColor, this.selectedItemColor, this.unSelectedItemColor});

  @override
  final String? backgroundColor;

  @override
  final String? selectedItemColor;

  @override
  final String? unSelectedItemColor;

  factory BottomNavigationBarWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$BottomNavigationBarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$BottomNavigationBarWidgetConfigToJson(this);
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

  factory ExtTabBarWidgetConfig.fromJson(Map<String, Object?> json) => _$ExtTabBarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ExtTabBarWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class GroupTitleListTileWidgetConfig with _$GroupTitleListTileWidgetConfig {
  const GroupTitleListTileWidgetConfig({
    /// Background color in hex format.
    this.backgroundColor,

    /// Full text style configuration (font, size, color, etc.).
    this.textStyle,
  });

  @override
  final String? backgroundColor;

  @override
  final TextStyleConfig? textStyle;

  factory GroupTitleListTileWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$GroupTitleListTileWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$GroupTitleListTileWidgetConfigToJson(this);
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

  static const String metadataPrimaryOnboardingLogoUrl = 'primaryOnboardingLogoUrl';

  static const String metadataSecondaryOnboardingLogoUrl = 'secondaryOnboardingLogoUrl';

  factory ImageAssetsConfig.fromJson(Map<String, Object?> json) => _$ImageAssetsConfigFromJson(json);

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

  factory ImageAssetConfig.fromJson(Map<String, Object?> json) => _$ImageAssetConfigFromJson(json);

  Map<String, Object?> toJson() => _$ImageAssetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class AppIconWidgetConfig with _$AppIconWidgetConfig {
  const AppIconWidgetConfig({this.color});

  @override
  final String? color;

  factory AppIconWidgetConfig.fromJson(Map<String, Object?> json) => _$AppIconWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$AppIconWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class InputWidgetConfig with _$InputWidgetConfig {
  const InputWidgetConfig({this.primary = const TextFormFieldWidgetConfig()});

  @override
  final TextFormFieldWidgetConfig primary;

  factory InputWidgetConfig.fromJson(Map<String, Object?> json) => _$InputWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$InputWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class TextFormFieldWidgetConfig with _$TextFormFieldWidgetConfig {
  const TextFormFieldWidgetConfig({this.labelColor, this.border = const InputBorderWidgetConfig()});

  @override
  final String? labelColor;

  @override
  final InputBorderWidgetConfig border;

  factory TextFormFieldWidgetConfig.fromJson(Map<String, Object?> json) => _$TextFormFieldWidgetConfigFromJson(json);

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

  factory InputBorderWidgetConfig.fromJson(Map<String, Object?> json) => _$InputBorderWidgetConfigFromJson(json);

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

  factory BorderWidgetConfig.fromJson(Map<String, Object?> json) => _$BorderWidgetConfigFromJson(json);

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

  factory TextWidgetConfig.fromJson(Map<String, Object?> json) => _$TextWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$TextWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class TextSelectionWidgetConfig with _$TextSelectionWidgetConfig {
  const TextSelectionWidgetConfig({this.cursorColor, this.selectionColor, this.selectionHandleColor});

  @override
  final String? cursorColor;

  @override
  final String? selectionColor;

  @override
  final String? selectionHandleColor;

  factory TextSelectionWidgetConfig.fromJson(Map<String, Object?> json) => _$TextSelectionWidgetConfigFromJson(json);

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

  factory LinkifyWidgetConfig.fromJson(Map<String, Object?> json) => _$LinkifyWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$LinkifyWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class DialogWidgetConfig with _$DialogWidgetConfig {
  const DialogWidgetConfig({
    this.theme = const DialogThemeConfig(),
    this.confirmDialog = const ConfirmDialogWidgetConfig(),
    this.snackBar = const SnackBarWidgetConfig(),
  });

  /// Baseline appearance applied to every dialog via [ThemeData.dialogTheme].
  ///
  /// Material 3 derives the dialog background from `surfaceContainerHigh`, which
  /// can resolve to an unreadable color in some color schemes; this config lets a
  /// theme pin a predictable surface/text/shape for all dialogs.
  @override
  final DialogThemeConfig theme;

  @override
  final ConfirmDialogWidgetConfig confirmDialog;

  @override
  final SnackBarWidgetConfig snackBar;

  factory DialogWidgetConfig.fromJson(Map<String, Object?> json) => _$DialogWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$DialogWidgetConfigToJson(this);
}

/// Global dialog appearance mapped to [ThemeData.dialogTheme].
///
/// All fields are nullable so existing configs keep working; a null field falls
/// back to a readable color-scheme role (or the Material default) in the bridge.
@freezed
@JsonSerializable(explicitToJson: true)
class DialogThemeConfig with _$DialogThemeConfig {
  const DialogThemeConfig({
    this.backgroundColor,
    this.surfaceTintColor,
    this.shadowColor,
    this.barrierColor,
    this.elevation,
    this.borderRadius,
    this.titleTextStyle,
    this.contentTextStyle,
  });

  @override
  final String? backgroundColor;

  @override
  final String? surfaceTintColor;

  @override
  final String? shadowColor;

  @override
  final String? barrierColor;

  @override
  final double? elevation;

  @override
  final double? borderRadius;

  @override
  final TextStyleConfig? titleTextStyle;

  @override
  final TextStyleConfig? contentTextStyle;

  factory DialogThemeConfig.fromJson(Map<String, Object?> json) => _$DialogThemeConfigFromJson(json);

  Map<String, Object?> toJson() => _$DialogThemeConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ConfirmDialogWidgetConfig with _$ConfirmDialogWidgetConfig {
  const ConfirmDialogWidgetConfig({
    this.activeButtonColor1,
    this.activeButtonColor2,
    this.defaultButtonColor,
    this.backgroundColor,
    this.surfaceTintColor,
    this.elevation,
    this.borderRadius,
    this.titleTextStyle,
    this.contentTextStyle,
  });

  @override
  final String? activeButtonColor1;

  @override
  final String? activeButtonColor2;

  @override
  final String? defaultButtonColor;

  /// Confirm-dialog-only overrides layered on top of [DialogThemeConfig];
  /// when null the dialog inherits [ThemeData.dialogTheme].
  @override
  final String? backgroundColor;

  @override
  final String? surfaceTintColor;

  @override
  final double? elevation;

  @override
  final double? borderRadius;

  @override
  final TextStyleConfig? titleTextStyle;

  @override
  final TextStyleConfig? contentTextStyle;

  factory ConfirmDialogWidgetConfig.fromJson(Map<String, Object?> json) => _$ConfirmDialogWidgetConfigFromJson(json);

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

  factory SnackBarWidgetConfig.fromJson(Map<String, Object?> json) => _$SnackBarWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$SnackBarWidgetConfigToJson(this);
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

  factory StatusesWidgetConfig.fromJson(Map<String, Object?> json) => _$StatusesWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$StatusesWidgetConfigToJson(this);
}

@freezed
@JsonSerializable(explicitToJson: true)
class RegistrationStatusesWidgetConfig with _$RegistrationStatusesWidgetConfig {
  const RegistrationStatusesWidgetConfig({this.online = '#75B943', this.offline = '#EEF3F6'});

  @override
  final String online;

  @override
  final String offline;

  factory RegistrationStatusesWidgetConfig.fromJson(Map<String, Object?> json) =>
      _$RegistrationStatusesWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$RegistrationStatusesWidgetConfigToJson(this);
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

  factory CallStatusesWidgetConfig.fromJson(Map<String, Object?> json) => _$CallStatusesWidgetConfigFromJson(json);

  Map<String, Object?> toJson() => _$CallStatusesWidgetConfigToJson(this);
}

/// Defines default property values for descendant [TabBar] widgets.
///
/// This configuration maps to [TabBarThemeData] and is typically used to
/// describe the overall [ThemeData.tabBarTheme]. Properties are null by default,
/// allowing the widget to fall back to parent theme values.
@freezed
@JsonSerializable(explicitToJson: true)
class TabBarConfig with _$TabBarConfig {
  const TabBarConfig({
    this.indicatorColor,
    this.dividerColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.overlayColor,
    this.dividerHeight,
    this.labelPadding,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorSize,
    this.tabAlignment,
    this.indicatorAnimation,
    this.splashFactory,
    this.indicatorBorder,
  });

  @override
  final String? indicatorColor;

  @override
  final String? dividerColor;

  @override
  final String? labelColor;

  @override
  final String? unselectedLabelColor;

  @override
  final String? overlayColor;

  @override
  final double? dividerHeight;

  @override
  final PaddingConfig? labelPadding;

  @override
  final TextStyleConfig? labelStyle;

  @override
  final TextStyleConfig? unselectedLabelStyle;

  @override
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final TabBarIndicatorSizeConfig? indicatorSize;

  @override
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final TabAlignmentConfig? tabAlignment;

  @override
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final TabIndicatorAnimationConfig? indicatorAnimation;

  @override
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final TabSplashFactoryConfig? splashFactory;

  @override
  final BorderConfig? indicatorBorder;

  factory TabBarConfig.fromJson(Map<String, Object?> json) => _$TabBarConfigFromJson(json);

  Map<String, Object?> toJson() => _$TabBarConfigToJson(this);
}

/// Defines default property values for descendant [AppBar] widgets.
///
/// This configuration maps to [AppBarThemeData] and is typically used to
/// describe the overall [ThemeData.appBarTheme]. Properties are null by default,
/// allowing the [AppBar] constructor to provide its own defaults.
@freezed
@JsonSerializable(explicitToJson: true)
class AppBarConfig with _$AppBarConfig {
  const AppBarConfig({
    this.primary = true,
    this.showBackButton = true,
    this.backgroundColor,
    this.foregroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.titleSpacing,
    this.leadingWidth,
    this.toolbarHeight,
    this.centerTitle,
    this.iconTheme,
    this.actionsIconTheme,
    this.titleTextStyle,
    this.toolbarTextStyle,
    this.systemOverlayStyle,
  });

  @override
  final bool primary;
  @override
  final bool showBackButton;
  @override
  final String? backgroundColor;
  @override
  final String? foregroundColor;
  @override
  final String? shadowColor;
  @override
  final String? surfaceTintColor;
  @override
  final double? elevation;
  @override
  final double? scrolledUnderElevation;
  @override
  final double? titleSpacing;
  @override
  final double? leadingWidth;
  @override
  final double? toolbarHeight;
  @override
  final bool? centerTitle;
  @override
  final IconThemeDataConfig? iconTheme;
  @override
  final IconThemeDataConfig? actionsIconTheme;
  @override
  final TextStyleConfig? titleTextStyle;
  @override
  final TextStyleConfig? toolbarTextStyle;
  @override
  final OverlayStyleModel? systemOverlayStyle;

  factory AppBarConfig.fromJson(Map<String, Object?> json) => _$AppBarConfigFromJson(json);

  Map<String, Object?> toJson() => _$AppBarConfigToJson(this);
}
