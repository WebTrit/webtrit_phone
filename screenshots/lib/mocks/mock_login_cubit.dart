import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// TODO: Remove the webtrit_api depencencies from LoginState
// ignore: depend_on_referenced_packages
import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {
  MockLoginCubit();

  factory MockLoginCubit.loginModeSelectScreen() {
    final mock = MockLoginCubit();
    whenListen(
      mock,
      const Stream<LoginState>.empty(),
      initialState: const LoginState(),
    );
    when(() => mock.isDemoModeEnabled).thenReturn(false);
    when(() => mock.isCredentialsRequestUrlEnabled).thenReturn(false);
    return mock;
  }

  factory MockLoginCubit.loginCoreUrlAssignScreen() {
    final mock = MockLoginCubit();
    whenListen(
      mock,
      const Stream<LoginState>.empty(),
      initialState: const LoginState(),
    );
    return mock;
  }

  factory MockLoginCubit.loginSwitchScreen({EmbeddedData? embedded}) {
    final mock = MockLoginCubit();
    whenListen(
      mock,
      const Stream<LoginState>.empty(),
      initialState: LoginState(
        embedded: embedded,
        processing: false,
        mode: LoginMode.demoCore,
        coreUrl: '_',
        tenantId: '_',
        token: '_',
        otpSigninSessionOtpProvisionalWithDateTime: (
          const SessionResult.otpProvisional(otpId: '_')
              as SessionOtpProvisional,
          DateTime.now(),
        ),
        signupSessionOtpProvisionalWithDateTime: (
          const SessionResult.otpProvisional(otpId: '_')
              as SessionOtpProvisional,
          DateTime.now(),
        ),
        supportedLoginTypes: [
          LoginType.otpSignin,
          LoginType.passwordSignin,
          LoginType.signup,
        ],
      ),
    );
    when(() => mock.isDemoModeEnabled).thenReturn(false);
    return mock;
  }
}
