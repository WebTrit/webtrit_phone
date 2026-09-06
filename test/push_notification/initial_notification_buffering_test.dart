import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/push_notification/push_notifications.dart';

void main() {
  test('remote initial notification is buffered until a listener is ready', () async {
    final notification = ChatsMessagePush('push-id', 11, 22);

    RemotePushBroker.handleOpenedPush(notification);

    final received = <MessagePush>[];
    final firstReceived = Completer<void>();
    final subscription = RemotePushBroker.messagingOpenedPushs.listen((event) {
      received.add(event);
      if (!firstReceived.isCompleted) firstReceived.complete();
    });

    await firstReceived.future.timeout(const Duration(seconds: 1));
    await Future<void>.delayed(Duration.zero);
    await subscription.cancel();

    expect(received, [same(notification)]);
  });

  test('local initial notification is buffered until a listener is ready', () async {
    const response = NotificationResponse(
      notificationResponseType: NotificationResponseType.selectedNotification,
      payload: '{"source":"messaging"}',
    );

    await LocalPushsBroker.handleActionReceived(response);

    final received = <NotificationResponse>[];
    final firstReceived = Completer<void>();
    final subscription = LocalPushsBroker.messagingActions.listen((event) {
      received.add(event);
      if (!firstReceived.isCompleted) firstReceived.complete();
    });

    await firstReceived.future.timeout(const Duration(seconds: 1));
    await Future<void>.delayed(Duration.zero);
    await subscription.cancel();

    expect(received, [same(response)]);
  });
}
