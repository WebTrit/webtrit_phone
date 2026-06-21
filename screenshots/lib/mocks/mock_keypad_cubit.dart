import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class MockKeypadCubit extends MockCubit<KeypadState> implements KeypadCubit {
  MockKeypadCubit();

  factory MockKeypadCubit.mainScreen() {
    final mock = MockKeypadCubit();
    whenListen(mock, const Stream<KeypadState>.empty(), initialState: KeypadState());
    return mock;
  }

  /// A keypad with a number already dialed and a matching contact resolved —
  /// drives the input field, contact name, and enabled call actions.
  factory MockKeypadCubit.dialing() {
    final mock = MockKeypadCubit();
    whenListen(
      mock,
      const Stream<KeypadState>.empty(),
      initialState: KeypadState(
        value: '+1 202 555 0142',
        contact: Contact(
          id: 0,
          sourceType: ContactSourceType.external,
          kind: ContactKind.visible,
          sourceId: '1',
          registered: true,
          aliasName: 'Thomas Anderson',
        ),
      ),
    );
    return mock;
  }
}
