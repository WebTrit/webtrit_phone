import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';

class MockNotificationsBloc extends MockBloc<NotificationsEvent, NotificationsState> implements NotificationsBloc {
  MockNotificationsBloc();

  factory MockNotificationsBloc.initial() {
    final mock = MockNotificationsBloc();
    whenListen(mock, const Stream<NotificationsState>.empty(), initialState: const NotificationsState());
    return mock;
  }
}
