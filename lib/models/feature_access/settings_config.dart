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

  /// Check if the voicemail setting is available in any section.
  final bool voicemailsEnabled;

  /// Whether the active-sessions row is available. It is not a configurable
  /// item - it is shown whenever the backend can list and revoke sessions.
  final bool sessionsEnabled;

  @override
  List<Object?> get props => [_sections, voicemailsEnabled, sessionsEnabled];
}
