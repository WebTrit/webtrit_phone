import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:webtrit_api/webtrit_api.dart';

class MockAuthTypesCubit extends MockCubit<LoginTypesState> implements LoginTypesCubit {
  MockAuthTypesCubit();

  factory MockAuthTypesCubit.loginScreen() {
    final mock = MockAuthTypesCubit();
    whenListen(
      mock,
      const Stream<LoginTypesState>.empty(),
      initialState: const LoginTypesState(supportedLogin: [
        SupportedLoginType.otpSignIn,
        SupportedLoginType.passwordSignIn,
      ]),
    );
    return mock;
  }
}
