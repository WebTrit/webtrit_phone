import 'package:test/test.dart';

import 'package:drift/native.dart';

import 'package:app_database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  VoicemailData createVoicemail({
    String id = 'vm-1',
    String date = '2026-01-01T00:00:00Z',
    bool seen = false,
    String? transcript,
    String? transcriptStatus,
  }) {
    return VoicemailData(
      id: id,
      date: date,
      duration: 3.5,
      sender: '555001',
      receiver: '555002',
      seen: seen,
      size: 5,
      type: 'voice',
      transcript: transcript,
      transcriptStatus: transcriptStatus,
    );
  }

  group('clearTranscripts', () {
    test('resets transcript state on every row', () async {
      await db.voicemailDao.insertOrUpdateVoicemail(
        createVoicemail(id: 'vm-1', transcript: 'finished', transcriptStatus: 'done'),
      );
      await db.voicemailDao.insertOrUpdateVoicemail(createVoicemail(id: 'vm-2', transcriptStatus: 'unavailable'));

      await db.voicemailDao.clearTranscripts();

      for (final id in ['vm-1', 'vm-2']) {
        final row = await db.voicemailDao.getVoicemailById(id);
        expect(row!.transcript, isNull);
        expect(row.transcriptStatus, isNull);
      }
    });
  });

  group('upsertVoicemailFromRemote', () {
    test('inserts a new row with empty transcript columns', () async {
      await db.voicemailDao.upsertVoicemailFromRemote(createVoicemail());

      final row = await db.voicemailDao.getVoicemailById('vm-1');
      expect(row, isNotNull);
      expect(row!.transcript, isNull);
      expect(row.transcriptStatus, isNull);
    });

    test('updates remote fields but never touches transcript columns on conflict', () async {
      await db.voicemailDao.insertOrUpdateVoicemail(
        createVoicemail(transcript: 'finished transcript', transcriptStatus: 'done'),
      );

      await db.voicemailDao.upsertVoicemailFromRemote(createVoicemail(date: '2026-01-02T00:00:00Z', seen: true));

      final row = await db.voicemailDao.getVoicemailById('vm-1');
      expect(row!.date, '2026-01-02T00:00:00Z');
      expect(row.seen, isTrue);
      expect(row.transcript, 'finished transcript');
      expect(row.transcriptStatus, 'done');
    });
  });
}
