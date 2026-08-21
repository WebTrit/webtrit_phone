/// Secure storage no longer loads anything up front: a record is fetched the
/// first time somebody asks for it and remembered from then on. These tests
/// pin what that costs and what it must keep doing - one keychain round trip
/// per record, no reads nobody asked for, and an install too old to carry a
/// user id still counting as no session at all.
library;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/data/data.dart';

const _channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Map<String, String> stored;
  late List<String> reads;
  late Completer<void>? gate;

  setUp(() {
    stored = {};
    reads = [];
    gate = null;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, (call) async {
      final key = call.arguments['key'] as String?;
      switch (call.method) {
        case 'read':
          reads.add(key!);
          // Taken before the wait, the way a real read fetches its value when
          // it starts rather than when it is allowed to finish.
          final value = stored[key];
          if (gate != null) await gate!.future;
          return value;
        case 'write':
          stored[key!] = call.arguments['value'] as String;
          return null;
        case 'delete':
          stored.remove(key);
          return null;
        case 'readAll':
          return Map<String, String>.from(stored);
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, null);
  });

  test('a record is fetched once and answered from memory after that', () async {
    stored.addAll({'user-id': 'u', 'token': 'tok'});
    final storage = await SecureStorageImpl.init();

    expect(await storage.readToken(), 'tok');
    expect(await storage.readToken(), 'tok');

    expect(reads.where((key) => key == 'token'), hasLength(1));
  });

  test('nothing is read until somebody asks for it', () async {
    stored.addAll({'user-id': 'u', 'token': 'tok', 'external-page-access-token': 'page-token'});
    final storage = await SecureStorageImpl.init();

    await storage.readToken();

    expect(reads, isNot(contains('external-page-access-token')));
  });

  test('readers that arrive together share one round trip', () async {
    stored.addAll({'user-id': 'u', 'external-page-access-token': 'page-token'});
    final storage = await SecureStorageImpl.init();

    gate = Completer<void>();
    final first = storage.readExternalPageAccessToken();
    final second = storage.readExternalPageAccessToken();
    gate!.complete();

    expect(await first, 'page-token');
    expect(await second, 'page-token');
    expect(reads.where((key) => key == 'external-page-access-token'), hasLength(1));
  });

  test('a record the keychain does not hold is remembered as absent', () async {
    stored['user-id'] = 'u';
    final storage = await SecureStorageImpl.init();

    expect(await storage.readToken(), isNull);
    expect(await storage.readToken(), isNull);

    expect(reads.where((key) => key == 'token'), hasLength(1));
  });

  test('a session record is ignored while no user id is stored with it', () async {
    // Installations that predate the user id kept a session the app can no
    // longer make sense of, and it must not come back signed in.
    stored.addAll({'core-url': 'https://core', 'token': 'tok'});
    final storage = await SecureStorageImpl.init();

    expect(await storage.readCoreUrl(), isNull);
    expect(await storage.readToken(), isNull);
    expect(await storage.readTenantId(), isNull);
  });

  test('a record written before a user id exists still reads back', () async {
    // patchSession writes a token or a core url on its own, and the value it
    // just wrote must not be denied by the rule about old installs.
    final storage = await SecureStorageImpl.init();

    await storage.writeToken('fresh');

    expect(await storage.readToken(), 'fresh');
  });

  test('the session records are asked for together with the user id', () async {
    stored.addAll({'user-id': 'u', 'token': 'tok'});
    final storage = await SecureStorageImpl.init();

    gate = Completer<void>();
    final pending = storage.readToken();
    await pumpEventQueue();

    // Both are in flight while nothing has answered yet: honouring the rule
    // costs no round trip of its own.
    expect(reads, containsAll(<String>['user-id', 'token']));

    gate!.complete();
    expect(await pending, 'tok');
  });

  test('the page token is not tied to the user id', () async {
    stored['external-page-access-token'] = 'page-token';
    final storage = await SecureStorageImpl.init();

    expect(await storage.readExternalPageAccessToken(), 'page-token');
  });

  test('what was just written is what the next read gets, without asking the keychain', () async {
    stored['user-id'] = 'u';
    final storage = await SecureStorageImpl.init();
    await storage.readToken();
    reads.clear();

    await storage.writeToken('new');

    expect(await storage.readToken(), 'new');
    expect(reads, isEmpty);
  });

  test('a write during an in-flight read is not overwritten by the older value', () async {
    stored['external-page-access-token'] = 'old';
    final storage = await SecureStorageImpl.init();

    gate = Completer<void>();
    final pending = storage.readExternalPageAccessToken();
    await storage.writeExternalPageTokenData('new', 'refresh', 'expires', 'assoc');
    gate!.complete();
    await pending;

    expect(await storage.readExternalPageAccessToken(), 'new');
  });

  test('a deleted record reads as absent', () async {
    stored.addAll({'user-id': 'u', 'token': 'tok'});
    final storage = await SecureStorageImpl.init();

    await storage.deleteToken();

    expect(await storage.readToken(), isNull);
  });
}
