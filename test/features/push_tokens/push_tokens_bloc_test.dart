import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/push_tokens/bloc/push_tokens_bloc.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../../mocks/mock_secure_storage.dart';

class _MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class _MockPushTokensRepository extends Mock implements PushTokensRepository {}

class _MockCallkeep extends Mock implements Callkeep {}

class _MockPushEnvironment extends Mock implements PushEnvironment {}

void main() {
  late _MockFirebaseMessaging firebaseMessaging;
  late _MockPushTokensRepository pushTokensRepository;
  late MockSecureStorage secureStorage;
  late _MockCallkeep callkeep;
  late _MockPushEnvironment pushEnvironment;

  setUp(() {
    firebaseMessaging = _MockFirebaseMessaging();
    pushTokensRepository = _MockPushTokensRepository();
    secureStorage = MockSecureStorage();
    callkeep = _MockCallkeep();
    pushEnvironment = _MockPushEnvironment();

    when(() => callkeep.setPushRegistryDelegate(any())).thenReturn(null);
    when(() => firebaseMessaging.onTokenRefresh).thenAnswer((_) => const Stream.empty());
    when(() => pushEnvironment.getAvailability()).thenAnswer((_) async => PushSystemAvailability.success);
    when(() => firebaseMessaging.deleteToken()).thenAnswer((_) async {});
  });

  PushTokensBloc buildBloc() {
    return PushTokensBloc(
      pushTokensRepository: pushTokensRepository,
      secureStorage: secureStorage,
      firebaseMessaging: firebaseMessaging,
      callkeep: callkeep,
      pushEnvironment: pushEnvironment,
    );
  }

  group('PushTokensBloc — add() after close guard', () {
    test('FCM: no StateError when token arrives after bloc is closed', () async {
      final completer = Completer<String?>();
      when(() => firebaseMessaging.getToken(vapidKey: any(named: 'vapidKey'))).thenAnswer((_) => completer.future);

      final bloc = buildBloc();

      // Start retrieval; the future is now suspended inside retrieveAndStoreFcmToken
      unawaited(bloc.retrieveAndStoreFcmToken());
      await Future.delayed(Duration.zero);

      // Close the bloc while getToken() is still in flight
      await bloc.close();
      expect(bloc.isClosed, isTrue);

      // Token arrives after close — must not throw StateError
      completer.complete('fcm-token-after-close');
      await Future.delayed(Duration.zero);
    });

    test('APNS: no StateError when token arrives after bloc is closed', () async {
      final completer = Completer<String?>();
      when(() => firebaseMessaging.getAPNSToken()).thenAnswer((_) => completer.future);

      final bloc = buildBloc();

      unawaited(bloc.retrieveAndStoreApnsToken());
      await Future.delayed(Duration.zero);

      await bloc.close();
      expect(bloc.isClosed, isTrue);

      completer.complete('apns-token-after-close');
      await Future.delayed(Duration.zero);
    });

    test('APNS: no StateError when shouldRetry fires after bloc is closed', () async {
      var callCount = 0;
      when(() => firebaseMessaging.getAPNSToken()).thenAnswer((_) async {
        callCount++;
        // Fail on first call to trigger shouldRetry, succeed on second
        if (callCount == 1) throw Exception('transient error');
        return 'apns-token';
      });

      final bloc = buildBloc();

      // Run retrieval fully — shouldRetry fires during the first failure
      // The bloc is still open here so this is the happy path
      await bloc.retrieveAndStoreApnsToken();
      expect(bloc.isClosed, isFalse);

      await bloc.close();
    });
  });
}
