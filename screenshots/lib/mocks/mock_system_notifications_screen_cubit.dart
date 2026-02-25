import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import '../data/data.dart';

class _FakeSystemNotification extends Fake implements SystemNotification {}

class MockSystemNotificationsScreenCubit extends MockCubit<SystemNotificationScreenState>
    implements SystemNotificationsScreenCubit {
  MockSystemNotificationsScreenCubit();

  static bool _fallbackRegistered = false;

  factory MockSystemNotificationsScreenCubit.withNotifications() {
    if (!_fallbackRegistered) {
      registerFallbackValue(_FakeSystemNotification());
      _fallbackRegistered = true;
    }
    final mock = MockSystemNotificationsScreenCubit();
    whenListen(
      mock,
      const Stream<SystemNotificationScreenState>.empty(),
      initialState: SystemNotificationScreenState(
        notifications: dMockSystemNotifications,
        isLoading: false,
      ),
    );
    when(() => mock.markAsSeen(any())).thenAnswer((_) async {});
    return mock;
  }
}
