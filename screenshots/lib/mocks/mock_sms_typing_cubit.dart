import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockSmsTypingCubit extends MockCubit<TypingNumbers> implements SmsTypingCubit {
  MockSmsTypingCubit();

  factory MockSmsTypingCubit.idle() {
    final mock = MockSmsTypingCubit();
    whenListen(mock, const Stream<TypingNumbers>.empty(), initialState: <String>{});
    return mock;
  }
}
