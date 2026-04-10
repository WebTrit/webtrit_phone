import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';

import '../data/data.dart';

class MockSmsConversationCubit extends MockCubit<SmsConversationState> implements SmsConversationCubit {
  MockSmsConversationCubit();

  factory MockSmsConversationCubit.withMessages() {
    final mock = MockSmsConversationCubit();
    whenListen(
      mock,
      const Stream<SmsConversationState>.empty(),
      initialState: SCSReady(
        (
          firstNumber: dConversationsMockSmsConversationsCubit[0].firstPhoneNumber,
          secondNumber: dConversationsMockSmsConversationsCubit[0].secondPhoneNumber,
          recipientId: null,
        ),
        conversation: dConversationsMockSmsConversationsCubit[0],
        messages: dMessagesMockSmsConversationsCubit,
      ),
    );
    when(() => mock.userReadedUntilUpdate(any())).thenAnswer((_) async {});
    return mock;
  }
}
