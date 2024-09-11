import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/material.dart';

import 'icon_data_converter.dart';

part 'ui_compose_settings.freezed.dart';

part 'ui_compose_settings.g.dart';

@unfreezed
class UiComposeSettings with _$UiComposeSettings {
  factory UiComposeSettings({
    required List<UiComposeSettingsBottomMenuTabs> bottomMenuTabs,
  }) = _UiComposeSettings;

  factory UiComposeSettings.fromJson(Map<String, dynamic> json) => _$UiComposeSettingsFromJson(json);
}

@unfreezed
class UiComposeSettingsBottomMenuTabs with _$UiComposeSettingsBottomMenuTabs {
  factory UiComposeSettingsBottomMenuTabs({
    required String title,
    @IconDataConverter() required IconData icon, // Apply the converter here
    required String type,
    @Default(false) bool initial,
    UiComposeSettingsBottomMenuTabsData? data,
  }) = _UiComposeSettingsBottomMenuTabs;

  factory UiComposeSettingsBottomMenuTabs.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsBottomMenuTabsFromJson(json);
}

@unfreezed
class UiComposeSettingsBottomMenuTabsData with _$UiComposeSettingsBottomMenuTabsData {
  factory UiComposeSettingsBottomMenuTabsData({
    required String url,
  }) = _UiComposeSettingsBottomMenuTabsData;

  factory UiComposeSettingsBottomMenuTabsData.fromJson(Map<String, dynamic> json) =>
      _$UiComposeSettingsBottomMenuTabsDataFromJson(json);
}
