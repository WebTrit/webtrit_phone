import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/messaging.dart';
import 'repository/repository.dart';

class MockChatConversationsCubit extends MockCubit<ChatConversationsState> implements ChatConversationsCubit {
  MockChatConversationsCubit();

  factory MockChatConversationsCubit.initial(
      MockChatsRepository chatsRepository, MockContactsRepository contactsRepository) {
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

    when(() => MockChatsRepository().getChatsWithLastMessages()).thenAnswer((_) async {
      return [
        (dChatsMockChatsRepository[0], dMessagesMockChatsRepository[0]),
        (dChatsMockChatsRepository[1], dMessagesMockChatsRepository[1]),
      ];
    });

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

  factory MockChatConversationsCubit.empty(
      MockChatsRepository chatsRepository, MockContactsRepository contactsRepository) {
    final mock = MockChatConversationsCubit();

    when(() => chatsRepository.getChatsWithLastMessages()).thenAnswer((_) async => []);

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
