import 'package:drift/drift.dart';

/// One transcription of a media object, keyed by the owning media.
///
/// The table is media-agnostic: voicemail audio is the first consumer, call
/// recordings or chat attachments can attach their transcriptions later with
/// their own [mediaType].
@DataClassName('TranscriptionData')
class TranscriptionTable extends Table {
  @override
  String get tableName => 'transcriptions';

  @override
  Set<Column> get primaryKey => {mediaType, mediaId};

  TextColumn get mediaType => text()();

  TextColumn get mediaId => text()();

  TextColumn get transcript => text().nullable()();

  TextColumn get status => text().nullable()();

  /// Identity of the engine/model that produced [transcript].
  TextColumn get engine => text().nullable()();
}
