import 'package:bloc_test/bloc_test.dart';

import 'package:webtrit_phone/features/features.dart';

class MockSystemNotificationCounterCubit extends MockCubit<int>
    implements SystemNotificationsCounterCubit {
  MockSystemNotificationCounterCubit();

  factory MockSystemNotificationCounterCubit.withDefaults({
    int initialState = 3,
    Stream<int> stream = const Stream<int>.empty(),
  }) {
    final mock = MockSystemNotificationCounterCubit();
    whenListen(
      mock,
      stream,
      initialState: initialState,
    );
    return mock;
  }
}
