import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/messaging.dart';

class MockChatConversationsCubit extends MockCubit<ChatConversationsState> implements ChatConversationsCubit {
  MockChatConversationsCubit();

  factory MockChatConversationsCubit.initial() {
    final mock = MockChatConversationsCubit();

    whenListen(
      mock,
      const Stream<ChatConversationsState>.empty(),
      initialState: ChatConversationsState.initial(),
    );

    return mock;
  }

  factory MockChatConversationsCubit.withMockData() {
    final mock = MockChatConversationsCubit();

    whenListen(
      mock,
      Stream.fromIterable([
        ChatConversationsState.initial(),
        ChatConversationsState(
          [
            (chat: dChatsMockChatsRepository[0], message: dMessagesMockChatsRepository[0], contacts: []),
            (chat: dChatsMockChatsRepository[1], message: dMessagesMockChatsRepository[1], contacts: []),
          ],
          false,
        ),
      ]),
      initialState: ChatConversationsState.initial(),
    );

    return mock;
  }

  factory MockChatConversationsCubit.empty() {
    final mock = MockChatConversationsCubit();

    whenListen(
      mock,
      Stream.fromIterable([
        ChatConversationsState.initial(),
        ChatConversationsState([], false),
      ]),
      initialState: ChatConversationsState.initial(),
    );

    return mock;
  }
}
