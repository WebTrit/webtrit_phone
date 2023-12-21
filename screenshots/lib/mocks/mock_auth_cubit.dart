import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {
  MockAuthCubit();

  factory MockAuthCubit.loginScreen() {
    final mock = MockAuthCubit();
    whenListen(
      mock,
      const Stream<AuthState>.empty(),
      initialState: const AuthState(
        demo: true,
      ),
    );
    return mock;
  }
}
