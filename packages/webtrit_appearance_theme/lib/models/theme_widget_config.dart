import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_widget_config.freezed.dart';

part 'theme_widget_config.g.dart';

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ThemeWidgetConfig with _$ThemeWidgetConfig {
  const factory ThemeWidgetConfig({
    ButtonWidgetConfig? button,
    GroupWidgetConfig? group,
    BarWidgetConfig? bar,
    PictureWidgetConfig? picture,
    InputWidgetConfig? input,
    TextWidgetConfig? text,
    DialogWidgetConfig? dialog,
    ActionPadWidgetConfig? actionPad,
    @Default(StatusesWidgetConfig()) StatusesWidgetConfig statuses,
  }) = _ThemeWidgetConfig;

  factory ThemeWidgetConfig.fromJson(Map<String, dynamic> json) => _$ThemeWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ButtonWidgetConfig with _$ButtonWidgetConfig {
  const factory ButtonWidgetConfig({
    ElevatedButtonWidgetConfig? primaryElevatedButton,
  }) = _ButtonWidgetConfig;

  factory ButtonWidgetConfig.fromJson(Map<String, dynamic> json) => _$ButtonWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ElevatedButtonWidgetConfig with _$ElevatedButtonWidgetConfig {
  const factory ElevatedButtonWidgetConfig({
    String? backgroundColor,
    String? foregroundColor,
    String? textColor,
    String? iconColor,
    String? disabledIconColor,
  }) = _ElevatedButtonWidgetConfig;

  factory ElevatedButtonWidgetConfig.fromJson(Map<String, dynamic> json) => _$ElevatedButtonWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class GroupWidgetConfig with _$GroupWidgetConfig {
  const factory GroupWidgetConfig({
    GroupTitleListTileWidgetConfig? groupTitleListTile,
    CallActionsWidgetConfig? callActions,
  }) = _GroupWidgetConfig;

  factory GroupWidgetConfig.fromJson(Map<String, dynamic> json) => _$GroupWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class BarWidgetConfig with _$BarWidgetConfig {
  const factory BarWidgetConfig({
    BottomNavigationBarWidgetConfig? bottomNavigationBar,
    ExtTabBarWidgetConfig? extTabBar,
  }) = _BarWidgetConfig;

  factory BarWidgetConfig.fromJson(Map<String, dynamic> json) => _$BarWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class BottomNavigationBarWidgetConfig with _$BottomNavigationBarWidgetConfig {
  const factory BottomNavigationBarWidgetConfig({
    String? backgroundColor,
    String? selectedItemColor,
    String? unSelectedItemColor,
  }) = _BottomNavigationBarWidgetConfig;

  factory BottomNavigationBarWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$BottomNavigationBarWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ExtTabBarWidgetConfig with _$ExtTabBarWidgetConfig {
  const factory ExtTabBarWidgetConfig({
    String? foregroundColor,
    String? backgroundColor,
    String? selectedItemColor,
    String? unSelectedItemColor,
  }) = _ExtTabBarWidgetConfig;

  factory ExtTabBarWidgetConfig.fromJson(Map<String, dynamic> json) => _$ExtTabBarWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class GroupTitleListTileWidgetConfig with _$GroupTitleListTileWidgetConfig {
  const factory GroupTitleListTileWidgetConfig({
    String? backgroundColor,
    String? textColor,
  }) = _GroupTitleListTileWidgetConfig;

  factory GroupTitleListTileWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$GroupTitleListTileWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class CallActionsWidgetConfig with _$CallActionsWidgetConfig {
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

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class PictureWidgetConfig with _$PictureWidgetConfig {
  const factory PictureWidgetConfig({
    LogoWidgetConfig? onboardingPictureLogo,
    LogoWidgetConfig? onboardingLogo,
    AppIconWidgetConfig? appIcon,
  }) = _PictureWidgetConfig;

  factory PictureWidgetConfig.fromJson(Map<String, dynamic> json) => _$PictureWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class LogoWidgetConfig with _$LogoWidgetConfig {
  const factory LogoWidgetConfig({
    double? scale,
    String? labelColor,
  }) = _LogoWidgetConfig;

  factory LogoWidgetConfig.fromJson(Map<String, dynamic> json) => _$LogoWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class AppIconWidgetConfig with _$AppIconWidgetConfig {
  const factory AppIconWidgetConfig({
    String? color,
  }) = _AppIconWidgetConfig;

  factory AppIconWidgetConfig.fromJson(Map<String, dynamic> json) => _$AppIconWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class InputWidgetConfig with _$InputWidgetConfig {
  const factory InputWidgetConfig({
    TextFormFieldWidgetConfig? primary, // Add a field for "primary" input
  }) = _InputWidgetConfig;

  factory InputWidgetConfig.fromJson(Map<String, dynamic> json) => _$InputWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class TextFormFieldWidgetConfig with _$TextFormFieldWidgetConfig {
  const factory TextFormFieldWidgetConfig({
    String? labelColor,
    InputBorderWidgetConfig? border,
  }) = _TextFormFieldWidgetConfig;

  factory TextFormFieldWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextFormFieldWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class InputBorderWidgetConfig with _$InputBorderWidgetConfig {
  const factory InputBorderWidgetConfig({
    BorderWidgetConfig? disabled,
    BorderWidgetConfig? focused,
    BorderWidgetConfig? any,
  }) = _InputBorderWidgetConfig;

  factory InputBorderWidgetConfig.fromJson(Map<String, dynamic> json) => _$InputBorderWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class BorderWidgetConfig with _$BorderWidgetConfig {
  const factory BorderWidgetConfig({
    String? typicalColor,
    String? errorColor,
  }) = _BorderWidgetConfig;

  factory BorderWidgetConfig.fromJson(Map<String, dynamic> json) => _$BorderWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class TextWidgetConfig with _$TextWidgetConfig {
  const factory TextWidgetConfig({
    TextSelectionWidgetConfig? selection,
    LinkifyWidgetConfig? linkify,
  }) = _TextWidgetConfig;

  factory TextWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class TextSelectionWidgetConfig with _$TextSelectionWidgetConfig {
  const factory TextSelectionWidgetConfig({
    String? cursorColor,
    String? selectionColor,
    String? selectionHandleColor,
  }) = _TextSelectionWidgetConfig;

  factory TextSelectionWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextSelectionWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class LinkifyWidgetConfig with _$LinkifyWidgetConfig {
  const factory LinkifyWidgetConfig({
    String? styleColor,
    String? linkifyStyleColor,
  }) = _LinkifyWidgetConfig;

  factory LinkifyWidgetConfig.fromJson(Map<String, dynamic> json) => _$LinkifyWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class DialogWidgetConfig with _$DialogWidgetConfig {
  const factory DialogWidgetConfig({
    ConfirmDialogWidgetConfig? confirmDialog,
    @Default(SnackBarWidgetConfig()) SnackBarWidgetConfig snackBar,
  }) = _DialogWidgetConfig;

  factory DialogWidgetConfig.fromJson(Map<String, dynamic> json) => _$DialogWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ConfirmDialogWidgetConfig with _$ConfirmDialogWidgetConfig {
  const factory ConfirmDialogWidgetConfig({
    String? activeButtonColor1,
    String? activeButtonColor2,
    String? defaultButtonColor,
  }) = _ConfirmDialogWidgetConfig;

  factory ConfirmDialogWidgetConfig.fromJson(Map<String, dynamic> json) => _$ConfirmDialogWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class SnackBarWidgetConfig with _$SnackBarWidgetConfig {
  const factory SnackBarWidgetConfig({
    @Default('#75B943') String successBackgroundColor,
    @Default('#E74C3C') String errorBackgroundColor,
    @Default('#494949') String infoBackgroundColor,
    @Default('#F95A14') String warningBackgroundColor,
  }) = _SnackBarWidgetConfig;

  factory SnackBarWidgetConfig.fromJson(Map<String, dynamic> json) => _$SnackBarWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class ActionPadWidgetConfig with _$ActionPadWidgetConfig {
  const factory ActionPadWidgetConfig({
    ElevatedButtonWidgetConfig? callStart,
    ElevatedButtonWidgetConfig? callTransfer,
    ElevatedButtonWidgetConfig? backspacePressed,
  }) = _ActionPadWidgetConfig;

  factory ActionPadWidgetConfig.fromJson(Map<String, dynamic> json) => _$ActionPadWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class StatusesWidgetConfig with _$StatusesWidgetConfig {
  const factory StatusesWidgetConfig({
    @Default(RegistrationStatusesWidgetConfig()) RegistrationStatusesWidgetConfig registrationStatuses,
    @Default(CallStatusesWidgetConfig()) CallStatusesWidgetConfig callStatuses,
  }) = _StatusesWidgetConfig;

  factory StatusesWidgetConfig.fromJson(Map<String, dynamic> json) => _$StatusesWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class RegistrationStatusesWidgetConfig with _$RegistrationStatusesWidgetConfig {
  const factory RegistrationStatusesWidgetConfig({
    @Default('#75B943') String online,
    @Default('#EEF3F6') String offline,
  }) = _RegistrationStatusesWidgetConfig;

  factory RegistrationStatusesWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$RegistrationStatusesWidgetConfigFromJson(json);
}

@Freezed(copyWith: false, equal: false, toStringOverride: false)
class CallStatusesWidgetConfig with _$CallStatusesWidgetConfig {
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
