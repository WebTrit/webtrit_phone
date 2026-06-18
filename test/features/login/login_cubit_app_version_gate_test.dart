import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _FakePackageInfo implements PackageInfo {
  _FakePackageInfo(this.version);

  @override
  final String version;

  @override
  String get appName => 'WebTrit';

  @override
  String get packageName => 'com.webtrit.app';

  @override
  String get buildNumber => '0';
}

WebtritSystemInfo _systemInfo({Version? minSupportedAppVersion, List<String> supported = const ['passwordSignin']}) {
  return WebtritSystemInfo(
    core: CoreInfo(version: Version(1, 0, 0)),
    postgres: PostgresInfo(),
    adapter: AdapterInfo(supported: supported),
    minSupportedAppVersion: minSupportedAppVersion,
  );
}

void main() {
  late _MockAuthRepository authRepository;
  late NotificationsBloc notificationsBloc;
  late List<Session> loginSuccesses;

  setUp(() {
    authRepository = _MockAuthRepository();
    notificationsBloc = NotificationsBloc();
    loginSuccesses = [];
  });

  tearDown(() {
    notificationsBloc.close();
  });

  LoginCubit buildCubit(String appVersion) {
    return LoginCubit(
      authRepository: authRepository,
      notificationsBloc: notificationsBloc,
      packageInfo: _FakePackageInfo(appVersion),
      onLoginSuccess: (session, _) => loginSuccesses.add(session),
    );
  }

  Future<void> submitCoreUrl(LoginCubit cubit) async {
    cubit.coreUrlInputChanged('https://demo.example.com');
    cubit.loginCoreUrlAssignSubmitted();
    await pumpEventQueue();
  }

  test('blocks login when the app is older than min_supported_app_version', () async {
    when(
      () => authRepository.getSystemInfo(any(), any()),
    ).thenAnswer((_) async => _systemInfo(minSupportedAppVersion: Version(2, 0, 0)));

    final cubit = buildCubit('1.15.3');
    await submitCoreUrl(cubit);

    expect(notificationsBloc.state.lastNotification, isA<AppVersionUnsupportedErrorNotification>());
    expect(cubit.state.systemInfo, isNull);
    expect(cubit.state.supportedLoginTypes, isNull);
    expect(loginSuccesses, isEmpty);

    await cubit.close();
  });

  test('proceeds when the app satisfies min_supported_app_version', () async {
    when(
      () => authRepository.getSystemInfo(any(), any()),
    ).thenAnswer((_) async => _systemInfo(minSupportedAppVersion: Version(1, 0, 0)));

    final cubit = buildCubit('1.15.3');
    await submitCoreUrl(cubit);

    expect(notificationsBloc.state.lastNotification, isNot(isA<AppVersionUnsupportedErrorNotification>()));
    expect(cubit.state.systemInfo, isNotNull);

    await cubit.close();
  });

  test('proceeds when the backend declares no minimum (null)', () async {
    when(
      () => authRepository.getSystemInfo(any(), any()),
    ).thenAnswer((_) async => _systemInfo(minSupportedAppVersion: null));

    final cubit = buildCubit('1.15.3');
    await submitCoreUrl(cubit);

    expect(notificationsBloc.state.lastNotification, isNot(isA<AppVersionUnsupportedErrorNotification>()));
    expect(cubit.state.systemInfo, isNotNull);

    await cubit.close();
  });
}
