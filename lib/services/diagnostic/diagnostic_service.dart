import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/utils/utils.dart';

import 'diagnostic_models.dart';
import 'diagnostic_strategy.dart';

final _logger = Logger('DiagnosticService');

/// A service responsible for collecting and reporting diagnostic information.
///
/// This service orchestrates the process of gathering data from various parts
/// of the application using different [DiagnosticStrategy] implementations.
/// It is typically triggered by user action, presents a dialog to gather user
/// consent and comments, collects the data, and sends it to a reporting service
/// like Crashlytics.
abstract class DiagnosticService {
  Future<void> request(List<DiagnosticType> types, {Map<String, String>? extras});

  void dispose();
}

/// Default implementation of [DiagnosticService].
///
/// This class coordinates the collection of diagnostic data from various
/// [DiagnosticStrategy] implementations based on the requested [DiagnosticType]s.
/// It handles user interaction via a dialog, aggregates data, and sends it for reporting.
class DiagnosticServiceImpl implements DiagnosticService {
  DiagnosticServiceImpl({required this.dialogLauncher, required List<DiagnosticStrategy> strategies})
    : _strategies = {for (var strategy in strategies) strategy.type: strategy};

  final DiagnosticDialogLauncher dialogLauncher;

  final Map<DiagnosticType, DiagnosticStrategy> _strategies;

  @override
  Future<void> request(List<DiagnosticType> types, {Map<String, String>? extras}) async {
    if (types.isEmpty) return;

    // Show the dialog to get user's comment and consent for advanced logs.
    final dialogResult = await dialogLauncher.call();

    // This part of the code accumulates all logs from all strategies.
    // `aggregatedResults` will store the diagnostic data collected from each strategy,
    // while `errors` will capture any issues encountered during the collection process.
    final aggregatedResults = <String, dynamic>{};
    final errors = <String, String>{};

    for (final type in types) {
      final strategy = _strategies[type];

      if (strategy == null) {
        final errorMsg = 'No strategy registered for type: $type';
        errors[type.name] = errorMsg;
        _logger.warning(errorMsg);
        continue;
      }

      try {
        final includeAdvancedLogs = dialogResult?.includeAdvancedLogs ?? false;
        final data = await strategy.collectReport(extraLog: includeAdvancedLogs);
        aggregatedResults.addAll(data);
      } catch (e, s) {
        final errorMsg = 'Strategy ${type.name} failed: $e';
        errors[type.name] = errorMsg;
        _logger.severe(errorMsg, e, s);
      }
    }

    final metadata = _buildMetadata(dialogResult, errors);
    final groupTitle = _buildErrorGroup(types);

    try {
      await CrashlyticsUtils.reportServiceError(
        errorDescription: 'User Feedback / Diagnostic Report',
        errorGroup: groupTitle,
        userComment: dialogResult?.comment ?? 'Not provided',
        extras: extras ?? {},
        diagnostics: aggregatedResults,
        metadata: metadata,
        isFatal: true,
      );
      _logger.info('Diagnostic report sent successfully: $groupTitle');
    } catch (e, s) {
      _logger.severe('Failed to send diagnostic report to Crashlytics', e, s);
    }
  }

  /// Builds a metadata map to be included in the diagnostic report.
  ///
  /// This map contains information about the reporting process itself, such as
  /// a timestamp, user-provided details from the dialog, and any internal errors
  /// that occurred during data collection.
  Map<String, dynamic> _buildMetadata(DiagnosticReportOptions? dialogResult, Map<String, String> errors) {
    return {
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'user_comment': dialogResult?.comment,
      'include_advanced_logs': dialogResult?.includeAdvancedLogs,
      if (errors.isNotEmpty) 'internal_errors': errors,
    };
  }

  /// Converts a [DiagnosticType] enum value into a human-readable string.
  ///
  /// This is used to create a more readable identifier for the type in the
  /// report's group title.
  String _getReadableTypeName(DiagnosticType type) {
    return switch (type) {
      DiagnosticType.androidCallkeep => 'AndroidCallKeep',
    };
  }

  /// Builds a structured group title for the error report.
  ///
  /// This title is used to group similar reports in the reporting service (e.g., Crashlytics).
  /// It includes a standard prefix, the names of the diagnostic types being reported (sorted for consistency),
  /// and a timestamp to ensure uniqueness.
  String _buildErrorGroup(List<DiagnosticType> types) {
    const prefix = 'UserReport';
    final sortedTypes = List<DiagnosticType>.from(types)..sort((a, b) => a.index.compareTo(b.index));
    final typesStr = sortedTypes.map(_getReadableTypeName).join('_');
    // NOTE: A timestamp is explicitly included to ensure that every user-submitted diagnostic
    // report creates a unique issue in Crashlytics. This guarantees a notification
    // for every new user feedback submission, preventing them from being silently
    // folded into a single existing issue.
    return '$prefix.$typesStr.${DateTime.now()}';
  }

  @override
  void dispose() {}
}
