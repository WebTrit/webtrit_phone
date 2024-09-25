import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'theme_json_serializable.dart';

part 'theme_widget_config.freezed.dart';

part 'theme_widget_config.g.dart';

@freezed
class ThemeWidgetConfig with _$ThemeWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
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

@freezed
class ButtonWidgetConfig with _$ButtonWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ButtonWidgetConfig({
    ElevatedButtonWidgetConfig? primaryElevatedButton,
  }) = _ButtonWidgetConfig;

  factory ButtonWidgetConfig.fromJson(Map<String, dynamic> json) => _$ButtonWidgetConfigFromJson(json);
}

@freezed
class ElevatedButtonWidgetConfig with _$ElevatedButtonWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ElevatedButtonWidgetConfig({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? textColor,
    Color? iconColor,
    Color? disabledIconColor,
  }) = _ElevatedButtonWidgetConfig;

  factory ElevatedButtonWidgetConfig.fromJson(Map<String, dynamic> json) => _$ElevatedButtonWidgetConfigFromJson(json);
}

@freezed
class GroupWidgetConfig with _$GroupWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory GroupWidgetConfig({
    GroupTitleListTileWidgetConfig? groupTitleListTile,
    CallActionsWidgetConfig? callActions,
  }) = _GroupWidgetConfig;

  factory GroupWidgetConfig.fromJson(Map<String, dynamic> json) => _$GroupWidgetConfigFromJson(json);
}

@freezed
class BarWidgetConfig with _$BarWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory BarWidgetConfig({
    BottomNavigationBarWidgetConfig? bottomNavigationBar,
    ExtTabBarWidgetConfig? extTabBar,
  }) = _BarWidgetConfig;

  factory BarWidgetConfig.fromJson(Map<String, dynamic> json) => _$BarWidgetConfigFromJson(json);
}

@freezed
class BottomNavigationBarWidgetConfig with _$BottomNavigationBarWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory BottomNavigationBarWidgetConfig({
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unSelectedItemColor,
  }) = _BottomNavigationBarWidgetConfig;

  factory BottomNavigationBarWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$BottomNavigationBarWidgetConfigFromJson(json);
}

@freezed
class ExtTabBarWidgetConfig with _$ExtTabBarWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ExtTabBarWidgetConfig({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unSelectedItemColor,
  }) = _ExtTabBarWidgetConfig;

  factory ExtTabBarWidgetConfig.fromJson(Map<String, dynamic> json) => _$ExtTabBarWidgetConfigFromJson(json);
}

@freezed
class GroupTitleListTileWidgetConfig with _$GroupTitleListTileWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory GroupTitleListTileWidgetConfig({
    Color? backgroundColor,
    Color? textColor,
  }) = _GroupTitleListTileWidgetConfig;

  factory GroupTitleListTileWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$GroupTitleListTileWidgetConfigFromJson(json);
}

@freezed
class CallActionsWidgetConfig with _$CallActionsWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory CallActionsWidgetConfig({
    Color? callStartBackgroundColor,
    Color? hangupBackgroundColor,
    Color? transferBackgroundColor,
    Color? cameraBackgroundColor,
    Color? cameraActiveBackgroundColor,
    Color? mutedBackgroundColor,
    Color? mutedActiveBackgroundColor,
    Color? speakerBackgroundColor,
    Color? speakerActiveBackgroundColor,
    Color? heldBackgroundColor,
    Color? heldActiveBackgroundColor,
    Color? swapBackgroundColor,
    Color? keyBackgroundColor,
    Color? keypadBackgroundColor,
    Color? keypadActiveBackgroundColor,
  }) = _CallActionsWidgetConfig;

  factory CallActionsWidgetConfig.fromJson(Map<String, dynamic> json) => _$CallActionsWidgetConfigFromJson(json);
}

@freezed
class PictureWidgetConfig with _$PictureWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory PictureWidgetConfig({
    LogoWidgetConfig? onboardingPictureLogo,
    LogoWidgetConfig? onboardingLogo,
    AppIconWidgetConfig? appIcon,
  }) = _PictureWidgetConfig;

  factory PictureWidgetConfig.fromJson(Map<String, dynamic> json) => _$PictureWidgetConfigFromJson(json);
}

@freezed
class LogoWidgetConfig with _$LogoWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory LogoWidgetConfig({
    double? scale,
    Color? labelColor,
  }) = _LogoWidgetConfig;

  factory LogoWidgetConfig.fromJson(Map<String, dynamic> json) => _$LogoWidgetConfigFromJson(json);
}

@freezed
class AppIconWidgetConfig with _$AppIconWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory AppIconWidgetConfig({
    Color? color,
  }) = _AppIconWidgetConfig;

  factory AppIconWidgetConfig.fromJson(Map<String, dynamic> json) => _$AppIconWidgetConfigFromJson(json);
}

@freezed
class InputWidgetConfig with _$InputWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory InputWidgetConfig({
    TextFormFieldWidgetConfig? primary, // Add a field for "primary" input
  }) = _InputWidgetConfig;

  factory InputWidgetConfig.fromJson(Map<String, dynamic> json) => _$InputWidgetConfigFromJson(json);
}

@freezed
class TextFormFieldWidgetConfig with _$TextFormFieldWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory TextFormFieldWidgetConfig({
    Color? labelColor,
    InputBorderWidgetConfig? border, // Add a field for "border" settings
  }) = _TextFormFieldWidgetConfig;

  factory TextFormFieldWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextFormFieldWidgetConfigFromJson(json);
}

@freezed
class InputBorderWidgetConfig with _$InputBorderWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory InputBorderWidgetConfig({
    BorderWidgetConfig? disabled,
    BorderWidgetConfig? focused,
    BorderWidgetConfig? any, // "any" state for the border
  }) = _InputBorderWidgetConfig;

  factory InputBorderWidgetConfig.fromJson(Map<String, dynamic> json) => _$InputBorderWidgetConfigFromJson(json);
}

@freezed
class BorderWidgetConfig with _$BorderWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory BorderWidgetConfig({
    Color? typicalColor,
    Color? errorColor,
  }) = _BorderWidgetConfig;

  factory BorderWidgetConfig.fromJson(Map<String, dynamic> json) => _$BorderWidgetConfigFromJson(json);
}

@freezed
class TextWidgetConfig with _$TextWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory TextWidgetConfig({
    TextSelectionWidgetConfig? selection,
    LinkifyWidgetConfig? linkify,
  }) = _TextWidgetConfig;

  factory TextWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextWidgetConfigFromJson(json);
}

@freezed
class TextSelectionWidgetConfig with _$TextSelectionWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory TextSelectionWidgetConfig({
    Color? cursorColor,
    Color? selectionColor,
    Color? selectionHandleColor,
  }) = _TextSelectionWidgetConfig;

  factory TextSelectionWidgetConfig.fromJson(Map<String, dynamic> json) => _$TextSelectionWidgetConfigFromJson(json);
}

@freezed
class LinkifyWidgetConfig with _$LinkifyWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory LinkifyWidgetConfig({
    Color? styleColor,
    Color? linkifyStyleColor,
  }) = _LinkifyWidgetConfig;

  factory LinkifyWidgetConfig.fromJson(Map<String, dynamic> json) => _$LinkifyWidgetConfigFromJson(json);
}

@freezed
class DialogWidgetConfig with _$DialogWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory DialogWidgetConfig({
    ConfirmDialogWidgetConfig? confirmDialog,
  }) = _DialogWidgetConfig;

  factory DialogWidgetConfig.fromJson(Map<String, dynamic> json) => _$DialogWidgetConfigFromJson(json);
}

@freezed
class ConfirmDialogWidgetConfig with _$ConfirmDialogWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ConfirmDialogWidgetConfig({
    Color? activeButtonColor1,
    Color? activeButtonColor2,
    Color? defaultButtonColor,
  }) = _ConfirmDialogWidgetConfig;

  factory ConfirmDialogWidgetConfig.fromJson(Map<String, dynamic> json) => _$ConfirmDialogWidgetConfigFromJson(json);
}

@freezed
class ActionPadWidgetConfig with _$ActionPadWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory ActionPadWidgetConfig({
    ElevatedButtonWidgetConfig? callStart,
    ElevatedButtonWidgetConfig? callTransfer,
    ElevatedButtonWidgetConfig? backspacePressed,
  }) = _ActionPadWidgetConfig;

  factory ActionPadWidgetConfig.fromJson(Map<String, dynamic> json) => _$ActionPadWidgetConfigFromJson(json);
}

@freezed
class StatusesWidgetConfig with _$StatusesWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory StatusesWidgetConfig({
    @Default(RegistrationStatusesWidgetConfig()) RegistrationStatusesWidgetConfig registrationStatuses,
    @Default(CallStatusesWidgetConfig()) CallStatusesWidgetConfig callStatuses,
  }) = _StatusesWidgetConfig;

  factory StatusesWidgetConfig.fromJson(Map<String, dynamic> json) => _$StatusesWidgetConfigFromJson(json);
}

@freezed
class RegistrationStatusesWidgetConfig with _$RegistrationStatusesWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory RegistrationStatusesWidgetConfig({
    @Default(Color(0xFF75B943)) Color online,
    @Default(Color(0xFFEEF3F6)) Color offline,
  }) = _RegistrationStatusesWidgetConfig;

  factory RegistrationStatusesWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$RegistrationStatusesWidgetConfigFromJson(json);
}

@freezed
class CallStatusesWidgetConfig with _$CallStatusesWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory CallStatusesWidgetConfig({
    @Default(Color(0xFFE74C3C)) Color connectivityNone,
    @Default(Color(0xFFE74C3C)) Color connectError,
    @Default(Color(0xFF494949)) Color appUnregistered,
    @Default(Color(0xFFE74C3C)) Color connectIssue,
    @Default(Color(0xFF123752)) Color inProgress,
    @Default(Color(0xFF75B943)) Color ready,
  }) = _CallStatusesWidgetConfig;

  factory CallStatusesWidgetConfig.fromJson(Map<String, dynamic> json) => _$CallStatusesWidgetConfigFromJson(json);
}
