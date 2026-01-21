import 'diagnostic_models.dart';

/// Converts a [DiagnosticType] enum value into a human-readable string.
///
/// This is used to create a more readable identifier for the type in the
/// report's group title.
extension DiagnosticTypeLabelExtensions on DiagnosticType {
  String get label => switch (this) {
    DiagnosticType.androidCallkeep => 'AndroidCallKeep',
  };
}
