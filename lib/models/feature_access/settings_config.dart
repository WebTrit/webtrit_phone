import 'package:webtrit_phone/models/feature_access/settings_feature.dart';

import '../settings_flavor.dart';

/// Configuration for the app settings screen, organized into sections and items.
class SettingsConfig {
  const SettingsConfig({required List<SettingsSection> sections}) : _sections = sections;

  final List<SettingsSection> _sections;

  /// Returns an unmodifiable list of settings sections.
  List<SettingsSection> get sections => List.unmodifiable(_sections);

  /// Check if the voicemail setting is available in any section.
  bool get isVoicemailsEnabled {
    return _sections.any((section) => section.items.any((item) => item.flavor == SettingsFlavor.voicemail));
  }
}
