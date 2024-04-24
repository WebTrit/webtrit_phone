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
  }) = _ElevatedButtonWidgetConfig;

  factory ElevatedButtonWidgetConfig.fromJson(Map<String, dynamic> json) => _$ElevatedButtonWidgetConfigFromJson(json);
}

@freezed
class GroupWidgetConfig with _$GroupWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory GroupWidgetConfig({
    GroupTitleListTileWidgetConfig? groupTitleListTile,
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
  }) = _GroupTitleListTileWidgetConfig;

  factory GroupTitleListTileWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$GroupTitleListTileWidgetConfigFromJson(json);
}

@freezed
class PictureWidgetConfig with _$PictureWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory PictureWidgetConfig({
    OnboardingPictureLogoWidgetConfig? onboardingPictureLogo,
  }) = _PictureWidgetConfig;

  factory PictureWidgetConfig.fromJson(Map<String, dynamic> json) => _$PictureWidgetConfigFromJson(json);
}

@freezed
class OnboardingPictureLogoWidgetConfig with _$OnboardingPictureLogoWidgetConfig {
  // ignore: invalid_annotation_target
  @themeJsonSerializable
  const factory OnboardingPictureLogoWidgetConfig({
    double? scale,
    Color? labelColor,
  }) = _OnboardingPictureLogoWidgetConfig;

  factory OnboardingPictureLogoWidgetConfig.fromJson(Map<String, dynamic> json) =>
      _$OnboardingPictureLogoWidgetConfigFromJson(json);
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
