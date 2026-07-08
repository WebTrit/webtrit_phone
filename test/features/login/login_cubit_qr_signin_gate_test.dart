import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockAppInfo extends Mock implements AppInfo {}

WebtritSystemInfo _systemInfo({List<String> supported = const ['passwordSignin']}) {
  return WebtritSystemInfo(
    core: CoreInfo(version: Version(1, 0, 0)),
    postgres: PostgresInfo(),
    adapter: AdapterInfo(supported: supported),
  );
}

void main() {
  late _MockAuthRepository authRepository;
  late NotificationsBloc notificationsBloc;

  setUp(() {
    authRepository = _MockAuthRepository();
    notificationsBloc = NotificationsBloc();
  });

  tearDown(() {
    notificationsBloc.close();
  });

  LoginCubit buildCubit({QrSigninConfig? qrSigninConfig, List<String> signinOrder = const []}) {
    final appInfo = _MockAppInfo();
    when(() => appInfo.version).thenReturn(Version.parse('1.0.0'));
    return LoginCubit(
      authRepository: authRepository,
      notificationsBloc: notificationsBloc,
      appInfo: appInfo,
      appCompatibilityResolver: const DefaultAppCompatibilityResolver(),
      signinOrder: signinOrder,
      qrSigninConfig: qrSigninConfig,
      onLoginSuccess: (_, _) {},
    );
  }

  Future<void> submitCoreUrl(LoginCubit cubit) async {
    cubit.coreUrlInputChanged('https://demo.example.com');
    cubit.loginCoreUrlAssignSubmitted();
    await pumpEventQueue();
  }

  group('QR sign-in tab gating', () {
    test('offered after the backend types when enabled and password sign-in is supported', () async {
      when(
        () => authRepository.getSystemInfo(any(), any()),
      ).thenAnswer((_) async => _systemInfo(supported: ['otpSignin', 'passwordSignin']));

      final cubit = buildCubit(qrSigninConfig: QrSigninConfig(enabled: true));
      await submitCoreUrl(cubit);

      expect(cubit.state.supportedLoginTypes, [LoginType.passwordSignin, LoginType.otpSignin, LoginType.qrSignin]);
    });

    test('not offered when disabled', () async {
      when(() => authRepository.getSystemInfo(any(), any())).thenAnswer((_) async => _systemInfo());

      final cubit = buildCubit();
      await submitCoreUrl(cubit);

      expect(cubit.state.supportedLoginTypes, [LoginType.passwordSignin]);
    });

    test('not offered when the backend has no password sign-in', () async {
      when(
        () => authRepository.getSystemInfo(any(), any()),
      ).thenAnswer((_) async => _systemInfo(supported: ['otpSignin']));

      final cubit = buildCubit(qrSigninConfig: QrSigninConfig(enabled: true));
      await submitCoreUrl(cubit);

      expect(cubit.state.supportedLoginTypes, [LoginType.otpSignin]);
    });

    test('a backend-advertised qrSignin is ignored: it must not bypass the config gate', () async {
      when(
        () => authRepository.getSystemInfo(any(), any()),
      ).thenAnswer((_) async => _systemInfo(supported: ['passwordSignin', 'qrSignin']));

      final cubit = buildCubit();
      await submitCoreUrl(cubit);

      expect(cubit.state.supportedLoginTypes, [LoginType.passwordSignin]);
    });

    test('a backend-advertised qrSignin does not duplicate the enabled tab', () async {
      when(
        () => authRepository.getSystemInfo(any(), any()),
      ).thenAnswer((_) async => _systemInfo(supported: ['passwordSignin', 'qrSignin']));

      final cubit = buildCubit(qrSigninConfig: QrSigninConfig(enabled: true));
      await submitCoreUrl(cubit);

      expect(cubit.state.supportedLoginTypes, [LoginType.passwordSignin, LoginType.qrSignin]);
    });

    test('position follows the configured sign-in order', () async {
      when(() => authRepository.getSystemInfo(any(), any())).thenAnswer((_) async => _systemInfo());

      final cubit = buildCubit(
        qrSigninConfig: QrSigninConfig(enabled: true),
        signinOrder: ['qrSignin', 'passwordSignin'],
      );
      await submitCoreUrl(cubit);

      expect(cubit.state.supportedLoginTypes, [LoginType.qrSignin, LoginType.passwordSignin]);
    });
  });
}
