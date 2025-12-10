import 'dart:async';

/// Defines the specific subsystems or features that can be targeted
/// for a diagnostic report.
enum DiagnosticType {
  /// Targets the Android CallKeep integration (native calling UI).
  androidCallkeep;

  /// A convenience getter for a list containing only [DiagnosticType.androidCallkeep].
  static List<DiagnosticType> get androidCallkeepOnly => const [DiagnosticType.androidCallkeep];
}

/// A signature for a function that handles the UI interaction required to
/// initiate a diagnostic report.
///
/// This is typically used to show a dialog where the user can enter a
/// [DiagnosticReportOptions.comment] and choose whether to include advanced logs.
///
/// Returns [DiagnosticReportOptions] if the user confirms the action,
/// or `null` if the user cancels or dismisses the interaction.
typedef DiagnosticDialogLauncher = FutureOr<DiagnosticReportOptions?> Function();

/// Configuration and user input required to generate a diagnostic report.
///
/// This DTO is usually created after a user interaction (via [DiagnosticDialogLauncher])
/// and passed to the diagnostic service to configure how the report is collected.
class DiagnosticReportOptions {
  /// Creates options for a diagnostic report.
  const DiagnosticReportOptions({this.comment, this.includeAdvancedLogs = true});

  /// Optional user-provided description of the issue or feedback.
  final String? comment;

  /// Whether to include detailed technical logs.
  ///
  /// If `true`, the strategy may collect verbose logs or sensitive data
  /// helpful for debugging. Defaults to `true`.
  final bool includeAdvancedLogs;
}
