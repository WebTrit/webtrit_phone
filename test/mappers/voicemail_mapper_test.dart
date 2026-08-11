import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

import '../mocks/voicemails_fixture_factory.dart';

class _Mapper with VoicemailMapper {}

void main() {
  final mapper = _Mapper();

  final item = api.UserVoicemailItem(
    id: 'vm-1',
    date: '2026-01-01T00:00:00Z',
    duration: 3.5,
    seen: false,
    size: 5,
    type: 'voice',
  );

  final details = api.UserVoicemail(
    id: 'vm-1',
    date: '2026-01-01T00:00:00Z',
    duration: 3.5,
    sender: '555001',
    receiver: '555002',
    seen: false,
    size: 5,
    type: 'voice',
    attachments: const [],
  );

  group('voicemailToDrift', () {
    test('maps only the remote fields (transcripts live in their own table)', () {
      final data = mapper.voicemailToDrift(item, details, 'http://example/vm-1');

      expect(data.id, 'vm-1');
      expect(data.sender, '555001');
      expect(data.attachmentPath, 'http://example/vm-1');
    });
  });

  group('voicemailFromDrift', () {
    test('maps a stored transcription row and its status', () {
      final data = VoicemailsFixtureFactory.createVoicemail(id: 'vm-1');
      const transcription = TranscriptionData(
        mediaType: kVoicemailTranscriptionMediaType,
        mediaId: 'vm-1',
        transcript: 'hello',
        status: 'done',
      );

      final voicemail = mapper.voicemailFromDrift(data, null, transcription: transcription);

      expect(voicemail.transcript, 'hello');
      expect(voicemail.transcriptStatus, TranscriptStatus.done);
    });

    test('maps a missing transcription to none', () {
      final data = VoicemailsFixtureFactory.createVoicemail(id: 'vm-1');

      final voicemail = mapper.voicemailFromDrift(data, null);

      expect(voicemail.transcript, isNull);
      expect(voicemail.transcriptStatus, TranscriptStatus.none);
    });

    test('maps an unknown status string to none', () {
      final data = VoicemailsFixtureFactory.createVoicemail(id: 'vm-1');
      const transcription = TranscriptionData(
        mediaType: kVoicemailTranscriptionMediaType,
        mediaId: 'vm-1',
        status: 'weird',
      );

      final voicemail = mapper.voicemailFromDrift(data, null, transcription: transcription);

      expect(voicemail.transcriptStatus, TranscriptStatus.none);
    });
  });
}
