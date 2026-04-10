import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockChatTypingCubit extends MockCubit<TypingUsers> implements ChatTypingCubit {
  MockChatTypingCubit();

  factory MockChatTypingCubit.idle() {
    final mock = MockChatTypingCubit();
    whenListen(mock, const Stream<TypingUsers>.empty(), initialState: <String>{});
    return mock;
  }
}
