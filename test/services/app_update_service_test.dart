import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:in_app_update/in_app_update.dart';

import 'package:webtrit_phone/services/services.dart';

AppUpdateInfo _info({
  UpdateAvailability updateAvailability = UpdateAvailability.updateNotAvailable,
  bool immediateUpdateAllowed = false,
  bool flexibleUpdateAllowed = false,
  InstallStatus installStatus = InstallStatus.unknown,
  int updatePriority = 0,
  int? availableVersionCode,
}) {
  return AppUpdateInfo(
    updateAvailability: updateAvailability,
    immediateUpdateAllowed: immediateUpdateAllowed,
    immediateAllowedPreconditions: null,
    flexibleUpdateAllowed: flexibleUpdateAllowed,
    flexibleAllowedPreconditions: null,
    availableVersionCode: availableVersionCode,
    installStatus: installStatus,
    packageName: 'com.webtrit.app',
    clientVersionStalenessDays: null,
    updatePriority: updatePriority,
  );
}

void main() {
  late List<String> calls;
  late AppUpdateInfo info;
  late AppUpdateResult flexibleResult;

  AppUpdateService buildService() {
    return AppUpdateService(
      checkForUpdate: () async {
        calls.add('check');
        return info;
      },
      performImmediateUpdate: () async {
        calls.add('immediate');
        return AppUpdateResult.success;
      },
      startFlexibleUpdate: () async {
        calls.add('startFlexible');
        return flexibleResult;
      },
      completeFlexibleUpdate: () async {
        calls.add('completeFlexible');
      },
    );
  }

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    calls = [];
    info = _info();
    flexibleResult = AppUpdateResult.success;
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  test('no-op on non-Android platforms', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    await buildService().check();

    expect(calls, isEmpty);
  });

  test('no update available results in check only', () async {
    await buildService().check();

    expect(calls, ['check']);
  });

  test('default priority runs the flexible flow and installs on success', () async {
    info = _info(
      updateAvailability: UpdateAvailability.updateAvailable,
      immediateUpdateAllowed: true,
      flexibleUpdateAllowed: true,
      availableVersionCode: 42,
    );

    await buildService().check();

    expect(calls, ['check', 'startFlexible', 'completeFlexible']);
  });

  test('priority at the threshold escalates to the immediate flow', () async {
    info = _info(
      updateAvailability: UpdateAvailability.updateAvailable,
      immediateUpdateAllowed: true,
      flexibleUpdateAllowed: true,
      updatePriority: 4,
    );

    await buildService().check();

    expect(calls, ['check', 'immediate']);
  });

  test('immediate is used when flexible is not allowed regardless of priority', () async {
    info = _info(
      updateAvailability: UpdateAvailability.updateAvailable,
      immediateUpdateAllowed: true,
      flexibleUpdateAllowed: false,
    );

    await buildService().check();

    expect(calls, ['check', 'immediate']);
  });

  test('declined flexible update is not re-prompted until a newer version code', () async {
    final service = buildService();
    info = _info(
      updateAvailability: UpdateAvailability.updateAvailable,
      flexibleUpdateAllowed: true,
      availableVersionCode: 42,
    );
    flexibleResult = AppUpdateResult.userDeniedUpdate;

    await service.check();
    await service.check();

    expect(calls, ['check', 'startFlexible', 'check']);

    info = _info(
      updateAvailability: UpdateAvailability.updateAvailable,
      flexibleUpdateAllowed: true,
      availableVersionCode: 43,
    );

    await service.check();

    expect(calls.last, 'startFlexible');
  });

  test('download completed while away triggers install without a new prompt', () async {
    info = _info(installStatus: InstallStatus.downloaded);

    await buildService().check();

    expect(calls, ['check', 'completeFlexible']);
  });

  test('interrupted immediate update is resumed', () async {
    info = _info(updateAvailability: UpdateAvailability.developerTriggeredUpdateInProgress);

    await buildService().check();

    expect(calls, ['check', 'immediate']);
  });

  test('platform errors are swallowed and the next check still runs', () async {
    var shouldThrow = true;
    final service = AppUpdateService(
      checkForUpdate: () async {
        calls.add('check');
        if (shouldThrow) throw PlatformException(code: 'API_NOT_AVAILABLE');
        return info;
      },
      performImmediateUpdate: () async => AppUpdateResult.success,
      startFlexibleUpdate: () async => flexibleResult,
      completeFlexibleUpdate: () async {},
    );

    await service.check();

    shouldThrow = false;
    await service.check();

    expect(calls, ['check', 'check']);
  });

  test('overlapping checks are ignored while one is in flight', () async {
    final gate = Completer<AppUpdateInfo>();
    final service = AppUpdateService(
      checkForUpdate: () {
        calls.add('check');
        return gate.future;
      },
      performImmediateUpdate: () async => AppUpdateResult.success,
      startFlexibleUpdate: () async => flexibleResult,
      completeFlexibleUpdate: () async {},
    );

    final first = service.check();
    final second = service.check();
    gate.complete(_info());
    await Future.wait([first, second]);

    expect(calls, ['check']);
  });
}
