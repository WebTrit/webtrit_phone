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

RequestFailure _requestFailure(String code, {int statusCode = 422}) {
  return RequestFailure(
    url: Uri.parse('https://demo.example.com/api/v1/session/otp-create'),
    statusCode: statusCode,
    requestId: 'test-request-id',
    error: ErrorResponse(code: code),
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

  test('maps delivery_channel_unspecified to a visible notification', () async {
    final cubit = buildCubit();

    cubit.handleError(_requestFailure('delivery_channel_unspecified'), StackTrace.current, 'test');
    await pumpEventQueue();

    expect(notificationsBloc.state.lastNotification, isA<LoginDeliveryChannelUnspecifiedNotification>());
  });

  test('maps empty_email to a visible notification', () async {
    final cubit = buildCubit();

    cubit.handleError(_requestFailure('empty_email'), StackTrace.current, 'test');
    await pumpEventQueue();

    expect(notificationsBloc.state.lastNotification, isA<LoginEmptyEmailNotification>());
  });
}
