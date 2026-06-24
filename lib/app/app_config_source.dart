import 'package:flutter/material.dart' show ThemeMode;

import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/theme/theme.dart';

/// Live application configuration supplied by an external host (the theme
/// configurator's realtime preview).
///
/// Every field is optional: when a source is provided the app follows it,
/// otherwise it uses its own bootstrap-built defaults. This is a plain config
/// source — it carries no notion of "embedding", so the app stays unaware of
/// where it runs.
class AppConfigSource {
  const AppConfigSource({this.themeSettings, this.themeMode, this.featureAccess, this.featureAccessInitial});

  /// Live theme appearance applied via `AppThemeSettingsChanged` (not persisted).
  final Stream<ThemeSettings>? themeSettings;

  /// Live theme mode applied via `AppThemeModeChanged`, paired with [themeSettings].
  final Stream<ThemeMode>? themeMode;

  /// Reactive [FeatureAccess] that replaces the bootstrap-built configuration.
  final Stream<FeatureAccess>? featureAccess;

  /// First-frame [FeatureAccess] seed paired with [featureAccess].
  final FeatureAccess? featureAccessInitial;
}
