import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

/// Builds the app-wide system overlay style for a theme [brightness].
///
/// Android 15+ (`targetSdk` 35 and above, which is what the pinned Flutter SDK sets)
/// runs every Flutter app in [SystemUiMode.edgeToEdge] with no way to opt out, and in
/// that mode the platform ignores `statusBarColor` and `systemNavigationBarColor`
/// entirely. Both are therefore pinned to transparent - which also makes older Android
/// versions behave identically - and the app paints its own content behind the bars.
/// Only the icon brightnesses are still honored by the platform.
///
/// Every field is populated on purpose: the engine treats a null field as "keep the
/// previously set value", so a partially filled style leaves the bars looking like
/// whatever screen happened to be shown before.
SystemUiOverlayStyle systemOverlayStyleOf(Brightness brightness) => SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: brightness,
  statusBarIconBrightness: brightness.inverted,
  systemStatusBarContrastEnforced: false,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: brightness.inverted,
  // Without this Android draws a translucent scrim behind a transparent navigation
  // bar, which reads as a grey band over the app's own background.
  systemNavigationBarContrastEnforced: false,
);

extension OverlayStyleModelMapper on OverlayStyleModel {
  /// Applies this configuration on top of [systemOverlayStyleOf] for [brightness].
  ///
  /// Only the configured icon/status brightnesses are taken from the config;
  /// `systemNavigationBarColor` is ignored because the platform ignores it under
  /// enforced edge-to-edge (see [systemOverlayStyleOf]).
  SystemUiOverlayStyle toSystemUiOverlayStyle(Brightness brightness) {
    return systemOverlayStyleOf(brightness).copyWith(
      statusBarBrightness: _parseBrightness(statusBarBrightness),
      statusBarIconBrightness: _parseBrightness(statusBarIconBrightness),
      systemNavigationBarIconBrightness: _parseBrightness(systemNavigationBarIconBrightness),
    );
  }

  /// Returns the [Brightness] named [b], or null when unset or unrecognized, so the
  /// `copyWith` above falls back to the brightness-derived default.
  Brightness? _parseBrightness(String? b) {
    if (b == null) return null;
    for (final brightness in Brightness.values) {
      if (brightness.name == b) return brightness;
    }
    return null;
  }
}
