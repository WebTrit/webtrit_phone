import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

// ignore: depend_on_referenced_packages
import 'package:drift/native.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/app/session/session.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../mocks/mocks.dart';
import '../mocks/voicemails_fixture_factory.dart';

class _TranscriptionApiClient extends MockWebtritApiClient {
  _TranscriptionApiClient({required this.items});

  final List<api.UserVoicemailItem> items;
  final List<String?> requestedAttachmentFormats = [];
  Object? attachmentError;

  @override
  Future<api.UserVoicemailListResponse> getUserVoicemailList(
    String token, {
    String? locale,
    api.RequestOptions options = const api.RequestOptions(),
  }) async {
    return api.UserVoicemailListResponse(hasNewMessages: false, items: items);
  }

  @override
  Future<api.UserVoicemail> getUserVoicemail(
    String token,
    String messageId, {
    String? locale,
    api.RequestOptions options = const api.RequestOptions(),
  }) async {
    final item = items.firstWhere((item) => item.id == messageId);
    return api.UserVoicemail(
      id: item.id,
      date: item.date,
      duration: item.duration,
      sender: '555001',
      receiver: '555002',
      seen: item.seen,
      size: item.size,
      type: item.type,
      attachments: const [],
    );
  }

  @override
  Future<Uint8List> getUserVoicemailAttachment(
    String token,
    String messageId, {
    String? locale,
    String? fileFormat,
    api.RequestOptions options = const api.RequestOptions(),
  }) async {
    requestedAttachmentFormats.add(fileFormat);
    final error = attachmentError;
    if (error != null) throw error;
    return Uint8List.fromList(const [1, 2, 3]);
  }

  @override
  String getVoicemailAttachmentUrl(String voicemailId, {String fileFormat = 'mp3'}) {
    return 'http://example.com/voicemails/$voicemailId';
  }
}

class _FakeTranscriptionDataSource implements TranscriptionDataSource {
  _FakeTranscriptionDataSource({this.result = 'hello world', this.error});

  final String result;
  final Object? error;
  int calls = 0;

  @override
  Future<String> transcribe(Uint8List audio, {String? language}) async {
    calls++;
    final error = this.error;
    if (error != null) throw error;
    return result;
  }
}

api.UserVoicemailItem createVoicemailItem({String id = '1', String type = 'voice'}) {
  return api.UserVoicemailItem(id: id, date: '2026-01-01T00:00:00Z', duration: 3.5, seen: false, size: 5, type: type);
}

Future<VoicemailData> waitForTranscriptStatus(AppDatabase appDatabase, String id, String? status) async {
  for (var attempt = 0; attempt < 200; attempt++) {
    final row = await appDatabase.voicemailDao.getVoicemailById(id);
    if (row != null && row.transcriptStatus == status) return row;
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('voicemail $id did not reach transcript status $status');
}

Future<void> waitFor(bool Function() condition, String description) async {
  for (var attempt = 0; attempt < 200; attempt++) {
    if (condition()) return;
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('condition not reached: $description');
}

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
  });

  group('transcription', () {
    late AppDatabase transcriptionDatabase;

    setUp(() {
      transcriptionDatabase = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await transcriptionDatabase.close();
    });

    VoicemailRepositoryImpl createRepo(_TranscriptionApiClient client, TranscriptionDataSource? dataSource) {
      return VoicemailRepositoryImpl(
        webtritApiClient: client,
        token: 'user_token',
        appDatabase: transcriptionDatabase,
        sessionGuard: const EmptySessionGuard(),
        transcriptionDataSource: dataSource,
      );
    }

    test('transcribes a fetched voicemail from its wav attachment and stores the result', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()]);
      final dataSource = _FakeTranscriptionDataSource(result: 'hello world');

      createRepo(client, dataSource);

      final row = await waitForTranscriptStatus(transcriptionDatabase, '1', TranscriptStatus.done.name);
      expect(row.transcript, 'hello world');
      expect(client.requestedAttachmentFormats, ['wav']);
    });

    test('marks the voicemail unavailable when transcription fails', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()]);
      final dataSource = _FakeTranscriptionDataSource(error: const TranscriptionException('engine failed'));

      createRepo(client, dataSource);

      final row = await waitForTranscriptStatus(transcriptionDatabase, '1', TranscriptStatus.unavailable.name);
      expect(row.transcript, isNull);
    });

    test('marks the voicemail unavailable when the attachment download fails permanently', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()])
        ..attachmentError = api.RequestFailure(url: Uri.parse('http://example.com'), statusCode: 404, requestId: 'r1');
      final dataSource = _FakeTranscriptionDataSource();

      createRepo(client, dataSource);

      final row = await waitForTranscriptStatus(transcriptionDatabase, '1', TranscriptStatus.unavailable.name);
      expect(row.transcript, isNull);
      expect(dataSource.calls, 0);
    });

    test('rolls back to not-attempted and retries on the next fetch after a server error', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()])
        ..attachmentError = api.RequestFailure(url: Uri.parse('http://example.com'), statusCode: 500, requestId: 'r1');
      final dataSource = _FakeTranscriptionDataSource(result: 'hello world');

      final repo = createRepo(client, dataSource);
      await waitFor(() => client.requestedAttachmentFormats.length == 1, 'first attachment attempt');

      // The failed attempt rolls the row back from inProgress to not-attempted.
      var row = await waitForTranscriptStatus(transcriptionDatabase, '1', null);
      expect(row.transcript, isNull);

      client.attachmentError = null;
      await repo.fetchVoicemails();

      row = await waitForTranscriptStatus(transcriptionDatabase, '1', TranscriptStatus.done.name);
      expect(row.transcript, 'hello world');
      expect(client.requestedAttachmentFormats.length, 2);
    });

    test('rolls back to not-attempted after a transient transcription failure', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()]);
      final dataSource = _FakeTranscriptionDataSource(
        error: const TranscriptionException('rate limited', transient: true),
      );

      createRepo(client, dataSource);
      await waitFor(() => dataSource.calls == 1, 'first transcription attempt');

      final row = await waitForTranscriptStatus(transcriptionDatabase, '1', null);
      expect(row.transcript, isNull);
    });

    test('preserves the transcript on refetch and does not transcribe twice', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()]);
      final dataSource = _FakeTranscriptionDataSource(result: 'hello world');

      final repo = createRepo(client, dataSource);
      await waitForTranscriptStatus(transcriptionDatabase, '1', TranscriptStatus.done.name);

      await repo.fetchVoicemails();
      await pumpEventQueue();

      final row = await waitForTranscriptStatus(transcriptionDatabase, '1', TranscriptStatus.done.name);
      expect(row.transcript, 'hello world');
      expect(dataSource.calls, 1);
    });

    test('does not retry a voicemail already marked unavailable', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()]);
      final dataSource = _FakeTranscriptionDataSource(error: const TranscriptionException('engine failed'));

      final repo = createRepo(client, dataSource);
      await waitForTranscriptStatus(transcriptionDatabase, '1', TranscriptStatus.unavailable.name);
      expect(dataSource.calls, 1);

      await repo.fetchVoicemails();
      await pumpEventQueue();

      expect(dataSource.calls, 1);
    });

    test('skips fax messages', () async {
      final client = _TranscriptionApiClient(
        items: [createVoicemailItem(id: 'fax-1', type: 'fax')],
      );
      final dataSource = _FakeTranscriptionDataSource();

      final repo = createRepo(client, dataSource);
      await repo.fetchVoicemails();
      await pumpEventQueue();

      final row = await transcriptionDatabase.voicemailDao.getVoicemailById('fax-1');
      expect(row, isNotNull);
      expect(row!.transcriptStatus, isNull);
      expect(dataSource.calls, 0);
    });

    test('leaves transcript columns untouched when no datasource is configured', () async {
      final client = _TranscriptionApiClient(items: [createVoicemailItem()]);

      final repo = createRepo(client, null);
      await repo.fetchVoicemails();
      await pumpEventQueue();

      final row = await transcriptionDatabase.voicemailDao.getVoicemailById('1');
      expect(row, isNotNull);
      expect(row!.transcript, isNull);
      expect(row.transcriptStatus, isNull);
    });
  });
}
