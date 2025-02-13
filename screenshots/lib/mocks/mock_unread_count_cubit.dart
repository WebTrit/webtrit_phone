import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockUnreadCountCubit extends MockCubit<UnreadCountState> implements UnreadCountCubit {
  MockUnreadCountCubit();

  factory MockUnreadCountCubit.initial() {
    final mock = MockUnreadCountCubit();
    whenListen(
      mock,
      const Stream<UnreadCountState>.empty(),
      initialState: UnreadCountState.initial(),
    );
    return mock;
  }

  factory MockUnreadCountCubit.withUnreadMessages() {
    final mock = MockUnreadCountCubit();

    final unreadState =
        UnreadCountState.fromCountPerChat(dChatUnreadCountsMockUnreadCountCubit, dSmsUnreadCountsMockUnreadCountCubit);

    whenListen(
      mock,
      Stream.fromIterable([
        UnreadCountState.initial(),
        unreadState,
      ]),
      initialState: UnreadCountState.initial(),
    );
    return mock;
  }

  factory MockUnreadCountCubit.empty() {
    final mock = MockUnreadCountCubit();
    whenListen(
      mock,
      Stream.fromIterable([
        UnreadCountState.initial(),
        UnreadCountState.fromCountPerChat({}, {}),
      ]),
      initialState: UnreadCountState.initial(),
    );
    return mock;
  }
}
