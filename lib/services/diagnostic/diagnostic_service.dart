import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/utils/utils.dart';

import 'diagnostic_models.dart';
import 'diagnostic_strategy.dart';
import 'diagnostic_type_label_extensions.dart';

final _logger = Logger('DiagnosticService');

const _errorExtraKey = 'error';

/// Corresponds to the string representation of [CallkeepCallRequestError.timeout].
const _timeoutErrorValue = 'timeout';

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
  DiagnosticServiceImpl({
    required this.dialogLauncher,
    required this.rebootLauncher,
    required this.errorLauncher,
    required List<DiagnosticStrategy> strategies,
  }) : _strategies = {for (var strategy in strategies) strategy.type: strategy};

  final DiagnosticDialogLauncher dialogLauncher;

  final AsyncCallback rebootLauncher;

  final DiagnosticDialogLauncher errorLauncher;

  final Map<DiagnosticType, DiagnosticStrategy> _strategies;

  @override
  Future<void> request(List<DiagnosticType> types, {Map<String, String>? extras}) async {
    if (types.isEmpty) return;

    final options = await _getDiagnosticOptions(extras);
    if (options == null) return;

    final aggregatedResults = <String, dynamic>{};
    final errors = <String, String>{};

    for (final type in types) {
      final strategy = _strategies[type];
      if (strategy == null) {
        _logMissingStrategy(type, errors);
        continue;
      }

      await _collectStrategyData(strategy, options, aggregatedResults, errors);
    }

    await _sendReport(types, options, aggregatedResults, errors, extras);
  }

  Future<DiagnosticReportOptions?> _getDiagnosticOptions(Map<String, String>? extras) async {
    final error = extras?[_errorExtraKey];

    if (error == _timeoutErrorValue) {
      await rebootLauncher();
      return const DiagnosticReportOptions(comment: 'Automatic report: Timeout error', includeAdvancedLogs: false);
    } else if (error != null) {
      return await errorLauncher();
    } else {
      return await dialogLauncher();
    }
  }

  Future<void> _collectStrategyData(
    DiagnosticStrategy strategy,
    DiagnosticReportOptions options,
    Map<String, dynamic> results,
    Map<String, String> errors,
  ) async {
    try {
      final data = await strategy.collectReport(includeAdvancedLogs: options.includeAdvancedLogs);
      results.addAll(data);
    } catch (e, s) {
      final errorMsg = 'Strategy ${strategy.type.name} failed: $e';
      errors[strategy.type.name] = errorMsg;
      _logger.severe(errorMsg, e, s);
    }
  }

  void _logMissingStrategy(DiagnosticType type, Map<String, String> errors) {
    final errorMsg = 'No strategy registered for type: $type';
    errors[type.name] = errorMsg;
    _logger.warning(errorMsg);
  }

  Future<void> _sendReport(
    List<DiagnosticType> types,
    DiagnosticReportOptions options,
    Map<String, dynamic> results,
    Map<String, String> errors,
    Map<String, String>? extras,
  ) async {
    final metadata = _buildMetadata(options, errors);
    final groupTitle = _buildErrorGroup(types);

    try {
      await CrashlyticsUtils.reportServiceError(
        errorDescription: 'User Feedback / Diagnostic Report',
        errorGroup: groupTitle,
        comment: options.comment ?? 'Not provided',
        extras: extras ?? {},
        diagnostics: results,
        metadata: metadata,
        isFatal: true,
      );
    } catch (e, s) {
      _logger.severe('Failed to send diagnostic report', e, s);
    }
  }

  /// Builds a metadata map to be included in the diagnostic report.
  ///
  /// This map contains information about the reporting process itself, such as
  /// a timestamp, provided details, and any internal errors
  /// that occurred during data collection.
  Map<String, dynamic> _buildMetadata(DiagnosticReportOptions options, Map<String, String> errors) {
    return {
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'comment': options.comment,
      'include_advanced_logs': options.includeAdvancedLogs,
      if (errors.isNotEmpty) 'internal_errors': errors,
    };
  }

  /// Builds a structured group title for the error report.
  String _buildErrorGroup(List<DiagnosticType> types) {
    const prefix = 'UserReport';
    final sortedTypes = List<DiagnosticType>.of(types)..sort((a, b) => a.index.compareTo(b.index));
    final typesStr = sortedTypes.map((t) => t.label).join('_');
    return '$prefix.$typesStr';
  }

  @override
  void dispose() {}
}
