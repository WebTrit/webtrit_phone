import 'package:equatable/equatable.dart';

class PresenceConfig extends Equatable {
  const PresenceConfig({
    required this.directPresenceEnabled,
    required this.presenceOverSipEnabled,
    required this.dialogsOverSipEnabled,
  });

  final bool directPresenceEnabled;

  final bool presenceOverSipEnabled;

  final bool dialogsOverSipEnabled;

  // bool get subsSyncEnabled => enabled && (dialogsOverSipEnabled || presenceOverSipEnabled);
  bool get subsSyncEnabled => dialogsOverSipEnabled || presenceOverSipEnabled;

  bool get anyPresenceEnabled => directPresenceEnabled || presenceOverSipEnabled;

  @override
  List<Object?> get props => [directPresenceEnabled, presenceOverSipEnabled, dialogsOverSipEnabled];

  factory PresenceConfig.empty() {
    return const PresenceConfig(
      directPresenceEnabled: false,
      presenceOverSipEnabled: false,
      dialogsOverSipEnabled: false,
    );
  }
}
