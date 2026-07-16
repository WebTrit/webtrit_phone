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

  TranscriptionData createTranscription({
    String mediaType = 'voicemail',
    String mediaId = 'vm-1',
    String? transcript,
    String? status,
    String? engine,
  }) {
    return TranscriptionData(
      mediaType: mediaType,
      mediaId: mediaId,
      transcript: transcript,
      status: status,
      engine: engine,
    );
  }

  test('upsert inserts and then replaces the row of the same media', () async {
    await db.transcriptionsDao.upsertTranscription(createTranscription(status: 'inProgress'));
    await db.transcriptionsDao.upsertTranscription(
      createTranscription(transcript: 'hello', status: 'done', engine: 'whisper-ggml:base'),
    );

    final row = await db.transcriptionsDao.getByMedia('voicemail', 'vm-1');
    expect(row!.transcript, 'hello');
    expect(row.status, 'done');
    expect(row.engine, 'whisper-ggml:base');
  });

  test('upsert clears previously written fields with explicit nulls', () async {
    await db.transcriptionsDao.upsertTranscription(
      createTranscription(transcript: 'old', status: 'done', engine: 'whisper-ggml:base'),
    );

    await db.transcriptionsDao.upsertTranscription(createTranscription());

    final row = await db.transcriptionsDao.getByMedia('voicemail', 'vm-1');
    expect(row!.transcript, isNull);
    expect(row.status, isNull);
    expect(row.engine, isNull);
  });

  test('rows are scoped per media type', () async {
    await db.transcriptionsDao.upsertTranscription(createTranscription());
    await db.transcriptionsDao.upsertTranscription(createTranscription(mediaType: 'recording'));

    expect(await db.transcriptionsDao.getAllForType('voicemail'), hasLength(1));
    expect(await db.transcriptionsDao.getByMedia('recording', 'vm-1'), isNotNull);
  });

  test('deleteByMedia removes only the addressed row', () async {
    await db.transcriptionsDao.upsertTranscription(createTranscription());
    await db.transcriptionsDao.upsertTranscription(createTranscription(mediaId: 'vm-2'));

    await db.transcriptionsDao.deleteByMedia('voicemail', 'vm-1');

    expect(await db.transcriptionsDao.getByMedia('voicemail', 'vm-1'), isNull);
    expect(await db.transcriptionsDao.getByMedia('voicemail', 'vm-2'), isNotNull);
  });

  test('deleteAllForType keeps other media types intact', () async {
    await db.transcriptionsDao.upsertTranscription(createTranscription());
    await db.transcriptionsDao.upsertTranscription(createTranscription(mediaType: 'recording'));

    await db.transcriptionsDao.deleteAllForType('voicemail');

    expect(await db.transcriptionsDao.getAllForType('voicemail'), isEmpty);
    expect(await db.transcriptionsDao.getAllForType('recording'), hasLength(1));
  });
}
