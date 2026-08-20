import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/push_platform_initializer.dart';
import 'package:webtrit_phone/app/startup_trace.dart';

void main() {
  late StartupTrace startupTrace;

  setUp(() {
    startupTrace = StartupTrace(output: (_) {});
  });

  test('starts local notifications with Firebase core and waits for both branches', () async {
    final firebaseCore = Completer<void>();
    final firebaseMessaging = Completer<void>();
    final localNotifications = Completer<void>();
    var firebaseCoreStarted = false;
    var firebaseMessagingStarted = false;
    var localNotificationsStarted = false;
    var initializationCompleted = false;

    final initialization = initializePushPlatform(
      startupTrace: startupTrace,
      initializeFirebase: () {
        firebaseCoreStarted = true;
        return firebaseCore.future;
      },
      initializeFirebaseMessaging: () {
        firebaseMessagingStarted = true;
        return firebaseMessaging.future;
      },
      initializeLocalNotifications: () {
        localNotificationsStarted = true;
        return localNotifications.future;
      },
    );
    unawaited(initialization.then((_) => initializationCompleted = true));

    expect(firebaseCoreStarted, isTrue);
    expect(localNotificationsStarted, isTrue);
    expect(firebaseMessagingStarted, isFalse);

    firebaseCore.complete();
    await Future<void>.delayed(Duration.zero);
    expect(firebaseMessagingStarted, isTrue);

    firebaseMessaging.complete();
    await Future<void>.delayed(Duration.zero);
    expect(initializationCompleted, isFalse);

    localNotifications.complete();
    await initialization;
  });

  test('reports a Firebase error without waiting for local notifications', () async {
    final firebaseError = StateError('firebase failed');
    final localNotifications = Completer<void>();
    var localNotificationsStarted = false;

    final initialization = initializePushPlatform(
      startupTrace: startupTrace,
      initializeFirebase: () => Future<void>.error(firebaseError),
      initializeFirebaseMessaging: () async => fail('messaging must not start'),
      initializeLocalNotifications: () {
        localNotificationsStarted = true;
        return localNotifications.future;
      },
    );

    await expectLater(initialization, throwsA(same(firebaseError)));
    expect(localNotificationsStarted, isTrue);

    localNotifications.complete();
  });

  test('keeps Firebase error priority when local notifications fail first', () async {
    final firebaseCore = Completer<void>();
    final firebaseError = StateError('firebase failed');

    final initialization = initializePushPlatform(
      startupTrace: startupTrace,
      initializeFirebase: () async {
        await firebaseCore.future;
        throw firebaseError;
      },
      initializeFirebaseMessaging: () async => fail('messaging must not start'),
      initializeLocalNotifications: () => Future<void>.error(StateError('local notifications failed')),
    );

    firebaseCore.complete();
    await expectLater(initialization, throwsA(same(firebaseError)));
  });

  test('reports a local notification error after Firebase succeeds', () async {
    final localError = StateError('local notifications failed');

    await expectLater(
      initializePushPlatform(
        startupTrace: startupTrace,
        initializeFirebase: () async {},
        initializeFirebaseMessaging: () async {},
        initializeLocalNotifications: () => Future<void>.error(localError),
      ),
      throwsA(same(localError)),
    );
  });
}
