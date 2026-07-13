import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:drift/native.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../mocks/mocks.dart';
import '../mocks/voicemails_fixture_factory.dart';

void main() {
  late AppDatabase appDatabase;
  late VoicemailRepositoryImpl repo;
  late MockWebtritApiClient apiClient;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    apiClient = MockWebtritApiClient();
    repo = VoicemailRepositoryImpl(
      webtritApiClient: apiClient,
      token: 'user_token',
      appDatabase: appDatabase,
      sessionGuard: const EmptySessionGuard(),
    );
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group('watchUnreadVoicemailsCount', () {
    test('emits 0 when database is empty', () async {
      expect(await repo.watchUnreadVoicemailsCount().first, equals(0));
    });

    test('emits total count when all voicemails are unread', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: false),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '2', seen: false),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '3', seen: false),
      );

      expect(await repo.watchUnreadVoicemailsCount().first, equals(3));
    });

    test('emits 0 when all voicemails are read', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: true),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '2', seen: true),
      );

      expect(await repo.watchUnreadVoicemailsCount().first, equals(0));
    });

    test('emits only the unread count when voicemails are mixed', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: false),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '2', seen: true),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '3', seen: false),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '4', seen: true),
      );

      expect(await repo.watchUnreadVoicemailsCount().first, equals(2));
    });

    test('decreases reactively when an unread voicemail is marked as seen', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: false),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '2', seen: false),
      );

      final future = expectLater(repo.watchUnreadVoicemailsCount(), emitsInOrder([2, 1]));
      await pumpEventQueue();
      await repo.updateVoicemailSeenStatus('1', true);
      await future;
    });

    test('drops to 0 reactively when the last unread voicemail is marked as seen', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: false),
      );

      final future = expectLater(repo.watchUnreadVoicemailsCount(), emitsInOrder([1, 0]));
      await pumpEventQueue();
      await repo.updateVoicemailSeenStatus('1', true);
      await future;
    });

    test('decreases reactively when an unread voicemail is deleted', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: false),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '2', seen: false),
      );

      final future = expectLater(repo.watchUnreadVoicemailsCount(), emitsInOrder([2, 1]));
      await pumpEventQueue();
      await repo.removeVoicemail('1');
      await future;
    });

    test('does not change count reactively when a read voicemail is deleted', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: false),
      );
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '2', seen: true),
      );

      final events = <int>[];
      final subscription = repo.watchUnreadVoicemailsCount().listen(events.add);
      await pumpEventQueue();

      await repo.removeVoicemail('2');
      await pumpEventQueue();

      expect(events.last, equals(1));
      await subscription.cancel();
    });

    test('increases reactively when a new unread voicemail is inserted', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '1', seen: false),
      );

      final future = expectLater(repo.watchUnreadVoicemailsCount(), emitsInOrder([1, 2]));
      await pumpEventQueue();
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(
        VoicemailsFixtureFactory.createVoicemail(id: '2', seen: false),
      );
      await future;
    });
  });

  group('VoicemailRepository', () {
    test('changeVoicemailSeenStatus', () async {
      final firstVoicemail = VoicemailsFixtureFactory.createVoicemail(id: '1', seen: true);
      final secondVoicemail = VoicemailsFixtureFactory.createVoicemail(id: '2', seen: false);
      final thirdVoicemail = VoicemailsFixtureFactory.createVoicemail(id: '3', seen: true);
      final fourthVoicemail = VoicemailsFixtureFactory.createVoicemail(id: '4', seen: false);

      await appDatabase.voicemailDao.insertOrUpdateVoicemail(firstVoicemail);
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(secondVoicemail);
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(thirdVoicemail);
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(fourthVoicemail);

      var voicemails = await appDatabase.voicemailDao.getAllVoicemails();
      expect(voicemails.length, 4);
      expect(voicemails.where((voicemail) => voicemail.seen).length, 2);
      expect(voicemails.where((voicemail) => !voicemail.seen).length, 2);

      await repo.updateVoicemailSeenStatus('1', false);
      await repo.updateVoicemailSeenStatus('2', true);
      await repo.updateVoicemailSeenStatus('4', true);

      voicemails = await appDatabase.voicemailDao.getAllVoicemails();
      expect(voicemails.where((voicemail) => voicemail.seen).length, 3);
      expect(voicemails.where((voicemail) => !voicemail.seen).length, 1);
    });

    test('deleteMultipleVoicemails', () async {
      final firstVoicemail = VoicemailsFixtureFactory.createVoicemail(id: '1');
      final secondVoicemail = VoicemailsFixtureFactory.createVoicemail(id: '2');
      final thirdVoicemail = VoicemailsFixtureFactory.createVoicemail(id: '3');

      await appDatabase.voicemailDao.insertOrUpdateVoicemail(firstVoicemail);
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(secondVoicemail);
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(thirdVoicemail);

      var voicemails = await appDatabase.voicemailDao.getAllVoicemails();
      expect(voicemails.length, 3);

      await repo.removeMultipleVoicemails(['1', '3']);

      voicemails = await appDatabase.voicemailDao.getAllVoicemails();
      expect(voicemails.length, 1);
      expect(voicemails.first.id, '2');
    });

    test('localRecordsCount and wipeLocalRecords cover only the local database', () async {
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(VoicemailsFixtureFactory.createVoicemail(id: '1'));
      await appDatabase.voicemailDao.insertOrUpdateVoicemail(VoicemailsFixtureFactory.createVoicemail(id: '2'));

      expect(await repo.localRecordsCount(), 2);

      await repo.wipeLocalRecords();

      expect(await repo.localRecordsCount(), 0);
      expect(await appDatabase.voicemailDao.getAllVoicemails(), isEmpty);
    });
  });
}
