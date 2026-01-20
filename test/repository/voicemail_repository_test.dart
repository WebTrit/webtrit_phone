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
  late VoicemailRepositoryImpl dataSource;
  late MockWebtritApiClient apiClient;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    apiClient = MockWebtritApiClient();
    dataSource = VoicemailRepositoryImpl(webtritApiClient: apiClient, token: 'user_token', appDatabase: appDatabase, sessionGuard: const EmptySessionGuard());
  });

  tearDown(() async {
    await appDatabase.close();
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

      await dataSource.updateVoicemailSeenStatus('1', false);
      await dataSource.updateVoicemailSeenStatus('2', true);
      await dataSource.updateVoicemailSeenStatus('4', true);

      voicemails = await appDatabase.voicemailDao.getAllVoicemails();
      expect(voicemails.where((voicemail) => voicemail.seen).length, 3);
      expect(voicemails.where((voicemail) => !voicemail.seen).length, 1);
    });
  });
}
