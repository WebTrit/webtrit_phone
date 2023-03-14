import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {
  MockLoginCubit();

  factory MockLoginCubit.loginScreen(LoginStep step) {
    final mock = MockLoginCubit();
    whenListen(
      mock,
      const Stream<LoginState>.empty(),
      initialState: LoginState(
        step: step,
      ),
    );
    when(() => mock.isDemoModeEnabled).thenReturn(false);
    return mock;
  }
}
