import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/login/login.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockAppInfo extends Mock implements AppInfo {}

class _MockPackageInfo extends Mock implements PackageInfo {}

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

  LoginCubit buildCubit() {
    final appInfo = _MockAppInfo();
    when(() => appInfo.version).thenReturn(Version.parse('1.0.0'));
    final packageInfo = _MockPackageInfo();
    when(() => packageInfo.version).thenReturn('0.0.0');
    when(() => packageInfo.buildNumber).thenReturn('0');
    return LoginCubit(
      authRepository: authRepository,
      notificationsBloc: notificationsBloc,
      appInfo: appInfo,
      packageInfo: packageInfo,
      appCompatibilityResolver: const DefaultAppCompatibilityResolver(),
      onLoginSuccess: (_, _) {},
    );
  }

  Future<LoginCubit> submitCoreUrl(Object error) async {
    when(() => authRepository.getSystemInfo(any(), any())).thenThrow(error);

    final cubit = buildCubit();
    cubit.coreUrlInputChanged('demo.example.com');
    cubit.loginCoreUrlAssignSubmitted();
    await pumpEventQueue();
    return cubit;
  }

  test('system-info failure without a WebTrit error body sets the inline core URL error', () async {
    final cubit = await submitCoreUrl(
      RequestFailure(
        url: Uri.parse('https://demo.example.com/api/v1/system-info'),
        statusCode: 404,
        requestId: 'test-request-id',
        rawBody: '404 page not found',
      ),
    );

    expect(cubit.state.coreUrlAssignError, isA<RequestFailure>());
    expect(cubit.state.processing, isFalse);
  });

  test('non-JSON payload on a success status sets the inline core URL error', () async {
    final cubit = await submitCoreUrl(const FormatException('Unexpected character'));

    expect(cubit.state.coreUrlAssignError, isA<FormatException>());
  });

  test('structured WebTrit error keeps the generic error path instead of the inline error', () async {
    final cubit = await submitCoreUrl(
      RequestFailure(
        url: Uri.parse('https://demo.example.com/api/v1/system-info'),
        statusCode: 404,
        requestId: 'test-request-id',
        error: ErrorResponse(code: 'user_not_found'),
      ),
    );

    expect(cubit.state.coreUrlAssignError, isNull);
    expect(notificationsBloc.state.lastNotification, isA<LoginUserNotFoundNotification>());
  });

  test('editing the core URL input clears the inline error', () async {
    final cubit = await submitCoreUrl(const FormatException('Unexpected character'));
    expect(cubit.state.coreUrlAssignError, isNotNull);

    cubit.coreUrlInputChanged('demo.example.org');

    expect(cubit.state.coreUrlAssignError, isNull);
  });
}
