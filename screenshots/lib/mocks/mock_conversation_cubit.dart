import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockConversationCubit extends MockCubit<ConversationState> implements ConversationCubit {
  MockConversationCubit();

  factory MockConversationCubit.withMessages() {
    final mock = MockConversationCubit();
    whenListen(
      mock,
      const Stream<ConversationState>.empty(),
      initialState: CVSReady(
        (chatId: dChatsMockChatsRepository[0].id, participantId: 'user_1'),
        chat: dChatsMockChatsRepository[0],
        messages: dMessagesMockChatsRepository,
      ),
    );
    when(() => mock.userReadedUntilUpdate(any())).thenAnswer((_) async {});
    return mock;
  }
}
