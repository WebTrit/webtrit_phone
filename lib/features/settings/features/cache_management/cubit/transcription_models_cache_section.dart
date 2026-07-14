import 'package:app_transcription/app_transcription.dart';

import 'package:webtrit_phone/models/models.dart';

/// The downloaded on-device Whisper model files as a manageable
/// [CacheSection].
///
/// Model tiers are downloaded on first use (or when picked on the
/// transcription settings page) and are the heaviest cache the app keeps
/// (~142 MB to ~1.5 GB per tier). Clearing is safe: the active model is
/// downloaded again on the next transcription - the source re-verifies the
/// file instead of trusting a cached preparation.
class TranscriptionModelsCacheSection implements CacheSection {
  TranscriptionModelsCacheSection({Future<int> Function()? sizeBytes, Future<void> Function()? deleteAll})
    : _sizeBytes = sizeBytes ?? LocalWhisperTranscriptionDataSource.downloadedModelsSizeBytes,
      _deleteAll = deleteAll ?? LocalWhisperTranscriptionDataSource.deleteDownloadedModels;

  final Future<int> Function() _sizeBytes;
  final Future<void> Function() _deleteAll;

  @override
  String get id => 'transcription_models';

  @override
  String get titleL10n => 'transcription_Cache_title';

  @override
  String get descriptionL10n => 'transcription_Cache_description';

  @override
  Future<CacheUsage> usage() async => CacheUsage.bytes(await _sizeBytes());

  @override
  Future<void> clear() => _deleteAll();
}
