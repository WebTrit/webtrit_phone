import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockKeypadCubit extends MockCubit<KeypadState> implements KeypadCubit {
  MockKeypadCubit();

  factory MockKeypadCubit.mainScreen() {
    final mock = MockKeypadCubit();
    whenListen(
      mock,
      const Stream<KeypadState>.empty(),
      initialState: const KeypadState(),
    );
    return mock;
  }
}
