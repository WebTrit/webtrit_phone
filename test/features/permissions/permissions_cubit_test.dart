import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/permissions/permissions.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockAppPermissions extends Mock implements AppPermissions {}

class _MockDeviceInfo extends Mock implements DeviceInfo {}

class _MockSpecialPermissionsRepository extends Mock implements SpecialPermissionsRepository {}

void main() {
  late _MockAppPermissions appPermissions;
  late _MockDeviceInfo deviceInfo;
  late _MockSpecialPermissionsRepository specialPermissionsRepository;

  const fullScreenIntent = CallkeepSpecialPermissions.fullScreenIntent;

  PermissionsCubit buildCubit() => PermissionsCubit(
    appPermissions: appPermissions,
    deviceInfo: deviceInfo,
    specialPermissionsRepository: specialPermissionsRepository,
  );

  /// Sets up a device where the full-screen intent permission is denied and
  /// everything else is out of the way.
  void givenFullScreenIntentDenied() {
    when(
      () => appPermissions.getSpecialPermissionStatuses(),
    ).thenAnswer((_) async => {fullScreenIntent: CallkeepSpecialPermissionStatus.denied});
    // The app's own gate never counts a special permission, so it stays satisfied.
    when(() => appPermissions.isDenied).thenAnswer((_) async => false);
  }

  setUpAll(() {
    registerFallbackValue(fullScreenIntent);
  });

  setUp(() {
    appPermissions = _MockAppPermissions();
    deviceInfo = _MockDeviceInfo();
    specialPermissionsRepository = _MockSpecialPermissionsRepository();

    // A manufacturer without its own lock-screen quirks, so the OEM tip stays out.
    when(() => deviceInfo.manufacturer).thenReturn('google');
    when(() => specialPermissionsRepository.getAcknowledged()).thenReturn({});
    when(() => specialPermissionsRepository.acknowledge(any())).thenAnswer((_) async {});
  });

  test('the permission is explained but does not keep the user out', () async {
    givenFullScreenIntentDenied();

    final cubit = buildCubit();
    cubit.checkPermissions();
    await pumpEventQueue();

    expect(cubit.state.missingSpecialPermissions, [fullScreenIntent]);
    expect(cubit.state.isPermanentlyDenied, isFalse);

    await cubit.close();
  });

  test('skipping the permission clears the way and is remembered', () async {
    givenFullScreenIntentDenied();

    final cubit = buildCubit();
    cubit.checkPermissions();
    await pumpEventQueue();

    await cubit.skipSpecialPermission(fullScreenIntent);

    expect(cubit.state.missingSpecialPermissions, isEmpty);
    expect(cubit.state.requiresSpecialPermissionsAction, isFalse);
    verify(() => specialPermissionsRepository.acknowledge(fullScreenIntent)).called(1);

    await cubit.close();
  });

  test('a permission skipped earlier is not explained again', () async {
    givenFullScreenIntentDenied();
    when(() => specialPermissionsRepository.getAcknowledged()).thenReturn({fullScreenIntent});

    final cubit = buildCubit();
    cubit.checkPermissions();
    await pumpEventQueue();

    expect(cubit.state.missingSpecialPermissions, isEmpty);

    await cubit.close();
  });
}
