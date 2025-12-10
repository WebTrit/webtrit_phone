import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';

import 'diagnostic_models.dart';

/// An abstract class defining the contract for a diagnostic strategy.
abstract class DiagnosticStrategy {
  DiagnosticType get type;

  Future<Map<String, dynamic>> collectReport({bool includeAdvancedLogs = false});
}

/// A diagnostic strategy for collecting CallKeep-related information on Android.
/// This strategy gathers diagnostic data from the `webtrit_callkeep` plugin.
class AndroidCallkeepDiagnosticStrategy implements DiagnosticStrategy {
  AndroidCallkeepDiagnosticStrategy({required this.appPermissions, required this.callkeepDiagnostics});

  final AppPermissions appPermissions;

  final CallkeepDiagnostics callkeepDiagnostics;

  @override
  DiagnosticType get type => DiagnosticType.androidCallkeep;

  @override
  Future<Map<String, dynamic>> collectReport({bool includeAdvancedLogs = false}) async {
    if (includeAdvancedLogs) {
      await _ensurePermissions();
    }
    return callkeepDiagnostics.getDiagnosticReport();
  }

  Future<void> _ensurePermissions() async {
    final currentStatuses = await appPermissions.getDiagnosticPermissionStatuses();
    final needsRequest = currentStatuses.values.any((status) => !status.isGranted);
    if (needsRequest) {
      await appPermissions.requestDiagnosticsPermissions();
    }
  }
}
