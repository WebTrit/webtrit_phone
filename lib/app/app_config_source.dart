import 'package:flutter/material.dart' show ThemeMode;

import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/theme/theme.dart';

/// Live application configuration supplied by an external host (the theme
/// configurator's realtime preview), passed down the widget tree like any other
/// config.
///
/// Every field is optional: when present the app renders it, otherwise it uses
/// its bootstrap-built defaults. These are plain values, not streams — the host
/// re-supplies a new instance on each edit, so reactivity comes from the normal
/// widget rebuild. The app carries no notion of "embedding".
class AppConfigSource {
  const AppConfigSource({this.themeSettings, this.themeMode, this.featureAccess});

  /// Theme appearance to render instead of the app's own.
  final ThemeSettings? themeSettings;

  /// Theme mode (light/dark) to apply, paired with [themeSettings].
  final ThemeMode? themeMode;

  /// [FeatureAccess] to use instead of the bootstrap-built configuration.
  final FeatureAccess? featureAccess;
}
