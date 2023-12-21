import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockAuthModeSelectCubit extends MockCubit<ModeSelectState> implements ModeSelectCubit {
  MockAuthModeSelectCubit();

  factory MockAuthModeSelectCubit.loginScreen() {
    final mock = MockAuthModeSelectCubit();
    whenListen(
      mock,
      const Stream<ModeSelectState>.empty(),
      initialState: const ModeSelectState(
        demo: true,
      ),
    );
    return mock;
  }
}
