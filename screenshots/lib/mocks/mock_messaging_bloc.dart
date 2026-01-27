import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'clients/clients.dart';

class MockSubmitNotification extends Mock {
  void call(Notification notification);
}

class MockMessagingBloc extends MockBloc<MessagingEvent, MessagingState> implements MessagingBloc {
  MockMessagingBloc();

  factory MockMessagingBloc.initial() {
    final mock = MockMessagingBloc();
    whenListen(
      mock,
      const Stream<MessagingState>.empty(),
      initialState: MessagingState.initial(
          MockPhoenixSocket(),
          MessagingConfig(
            coreSmsSupport: true,
            coreChatsSupport: true,
            tabEnabled: true,
            groupChatSupport: true,
            contactInfoVideoCallSupport: true,
          )).copyWith(status: ConnectionStatus.connected),
    );
    return mock;
  }
}
