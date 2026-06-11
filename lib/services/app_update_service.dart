import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:in_app_update/in_app_update.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AppUpdateService');

/// Function handles over the static [InAppUpdate] API, injectable for tests.
typedef CheckForUpdate = Future<AppUpdateInfo> Function();
typedef PerformImmediateUpdate = Future<AppUpdateResult> Function();
typedef StartFlexibleUpdate = Future<AppUpdateResult> Function();
typedef CompleteFlexibleUpdate = Future<void> Function();

/// Prompts the user to update the app via the Play Core in-app updates API.
///
/// Android only: [check] is a silent no-op on other platforms, on devices
/// without Google Play services, and on builds not installed from Google Play
/// (the underlying Play Core call fails there and the failure is swallowed).
///
/// All update UI is native Play Core - no in-app dialogs. The update type is
/// driven by the publish-time priority (Google Play Developer API
/// `inAppUpdatePriority`): below [immediatePriorityThreshold] the update runs
/// as a flexible (background download, restart on completion) prompt, at or
/// above it as an immediate (blocking full-screen) flow. The priority defaults
/// to 0 on publish, so regular releases surface as a soft ask.
class AppUpdateService {
  AppUpdateService({
    this.immediatePriorityThreshold = 4,
    CheckForUpdate? checkForUpdate,
    PerformImmediateUpdate? performImmediateUpdate,
    StartFlexibleUpdate? startFlexibleUpdate,
    CompleteFlexibleUpdate? completeFlexibleUpdate,
  }) : _checkForUpdate = checkForUpdate ?? InAppUpdate.checkForUpdate,
       _performImmediateUpdate = performImmediateUpdate ?? InAppUpdate.performImmediateUpdate,
       _startFlexibleUpdate = startFlexibleUpdate ?? InAppUpdate.startFlexibleUpdate,
       _completeFlexibleUpdate = completeFlexibleUpdate ?? InAppUpdate.completeFlexibleUpdate;

  /// Minimum publish-time update priority (0-5) that escalates the update
  /// from a flexible prompt to the blocking immediate flow.
  final int immediatePriorityThreshold;

  final CheckForUpdate _checkForUpdate;
  final PerformImmediateUpdate _performImmediateUpdate;
  final StartFlexibleUpdate _startFlexibleUpdate;
  final CompleteFlexibleUpdate _completeFlexibleUpdate;

  bool _checkInProgress = false;
  int? _declinedVersionCode;

  bool get _isSupportedPlatform => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  /// Checks Google Play for an available update and drives the native flow.
  ///
  /// Intended to be called on app startup and on every foreground resume;
  /// overlapping calls are ignored while a check is in flight.
  Future<void> check() async {
    if (!_isSupportedPlatform || _checkInProgress) {
      return;
    }
    _checkInProgress = true;
    try {
      await _check();
    } catch (e, stackTrace) {
      // Expected on devices without Play services and on sideloaded builds.
      _logger.fine('check failed - ignore', e, stackTrace);
    } finally {
      _checkInProgress = false;
    }
  }

  Future<void> _check() async {
    final info = await _checkForUpdate();

    // An immediate update was interrupted (e.g. the app was restarted
    // mid-flow); Play requires the app to resume it.
    if (info.updateAvailability == UpdateAvailability.developerTriggeredUpdateInProgress) {
      await _performImmediateUpdate();
      return;
    }

    // A flexible download finished while the app was away - install it now,
    // otherwise the user keeps running the old version until a cold restart.
    if (info.installStatus == InstallStatus.downloaded) {
      await _completeFlexibleUpdate();
      return;
    }

    if (info.updateAvailability != UpdateAvailability.updateAvailable) {
      return;
    }

    final immediate =
        info.immediateUpdateAllowed &&
        (info.updatePriority >= immediatePriorityThreshold || !info.flexibleUpdateAllowed);
    if (immediate) {
      await _performImmediateUpdate();
    } else if (info.flexibleUpdateAllowed) {
      await _runFlexibleUpdate(info);
    }
  }

  Future<void> _runFlexibleUpdate(AppUpdateInfo info) async {
    // The user already declined this very version - do not nag on every
    // resume; a newer version code prompts again.
    if (info.availableVersionCode != null && info.availableVersionCode == _declinedVersionCode) {
      return;
    }

    final result = await _startFlexibleUpdate();
    switch (result) {
      case AppUpdateResult.success:
        await _completeFlexibleUpdate();
      case AppUpdateResult.userDeniedUpdate:
        _declinedVersionCode = info.availableVersionCode;
      case AppUpdateResult.inAppUpdateFailed:
        _logger.warning('flexible update failed for version code ${info.availableVersionCode}');
    }
  }
}
