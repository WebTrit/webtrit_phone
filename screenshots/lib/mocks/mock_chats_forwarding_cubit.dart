import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/messaging/cubits/chats_forwarding/chats_forwarding_cubit.dart';
import 'package:webtrit_phone/models/messaging/messaging.dart';

class MockChatsForwardingCubit extends MockCubit<ChatMessage?> implements ChatsForwardingCubit {
  MockChatsForwardingCubit();

  factory MockChatsForwardingCubit.initial() {
    final mock = MockChatsForwardingCubit();
    whenListen(
      mock,
      const Stream<ChatMessage?>.empty(),
      initialState: null,
    );
    return mock;
  }
}
