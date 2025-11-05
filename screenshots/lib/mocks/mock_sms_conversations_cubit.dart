import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockSmsConversationsCubit extends MockCubit<SmsConversationsState>
    implements SmsConversationsCubit {
  MockSmsConversationsCubit();

  factory MockSmsConversationsCubit.initial() {
    final mock = MockSmsConversationsCubit();
    whenListen(
      mock,
      const Stream<SmsConversationsState>.empty(),
      initialState: SmsConversationsState.initial(),
    );
    return mock;
  }

  factory MockSmsConversationsCubit.withConversations() {
    final mock = MockSmsConversationsCubit();

    final testConversationsWithMessages = [
      (
        dConversationsMockSmsConversationsCubit[0],
        dMessagesMockSmsConversationsCubit[0]
      ),
      (
        dConversationsMockSmsConversationsCubit[1],
        dMessagesMockSmsConversationsCubit[1]
      ),
    ];

    whenListen(
      mock,
      Stream.fromIterable([
        SmsConversationsState.initial(),
        SmsConversationsState(testConversationsWithMessages, false),
      ]),
      initialState: SmsConversationsState.initial(),
    );
    return mock;
  }

  factory MockSmsConversationsCubit.empty() {
    final mock = MockSmsConversationsCubit();
    whenListen(
      mock,
      Stream.fromIterable([
        SmsConversationsState.initial(),
        SmsConversationsState([], false),
      ]),
      initialState: SmsConversationsState.initial(),
    );
    return mock;
  }
}
