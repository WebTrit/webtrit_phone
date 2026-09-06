import 'package:equatable/equatable.dart';

import 'settings_feature.dart';

/// Configuration for the app settings screen, organized into sections and items.
class SettingsConfig extends Equatable {
  SettingsConfig({
    required this.voicemailsEnabled,
    required this.sessionsEnabled,
    required List<SettingsSection> sections,
  }) : _sections = List.unmodifiable(sections);

  final List<SettingsSection> _sections;

  /// Returns an unmodifiable list of settings sections.
  List<SettingsSection> get sections => List.unmodifiable(_sections);

  /// Whether the settings list carries the voicemail row.
  ///
  /// A placement, not an availability: it says where voicemail is offered
  /// from, and nothing about whether the feature runs at all. Whether the data
  /// behind it is worth keeping is asked of `FeatureAccess.voicemailAvailable`,
  /// which answers for every placement rather than for this one.
  final bool voicemailsEnabled;

  /// Whether the active-sessions row is available. It is not a configurable
  /// item - it is shown whenever the backend can list and revoke sessions.
  final bool sessionsEnabled;

  @override
  List<Object?> get props => [_sections, voicemailsEnabled, sessionsEnabled];
}
