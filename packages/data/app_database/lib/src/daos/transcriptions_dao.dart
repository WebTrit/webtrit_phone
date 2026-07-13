import 'package:drift/drift.dart';
import 'package:app_database/src/app_database.dart';

part 'transcriptions_dao.g.dart';

@DriftAccessor(tables: [TranscriptionTable])
class TranscriptionsDao extends DatabaseAccessor<AppDatabase> with _$TranscriptionsDaoMixin {
  TranscriptionsDao(super.db);

  Future<TranscriptionData?> getByMedia(String mediaType, String mediaId) {
    final query = select(transcriptionTable)
      ..where((tbl) => tbl.mediaType.equals(mediaType) & tbl.mediaId.equals(mediaId));
    return query.getSingleOrNull();
  }

  Future<List<TranscriptionData>> getAllForType(String mediaType) {
    return (select(transcriptionTable)..where((tbl) => tbl.mediaType.equals(mediaType))).get();
  }

  /// Inserts or fully replaces the row of the addressed media. Built from an
  /// explicit companion because a data-class upsert treats null fields as
  /// absent and could never clear a previously written transcript or status.
  Future<void> upsertTranscription(TranscriptionData transcription) {
    return into(transcriptionTable).insertOnConflictUpdate(
      TranscriptionDataCompanion(
        mediaType: Value(transcription.mediaType),
        mediaId: Value(transcription.mediaId),
        transcript: Value(transcription.transcript),
        status: Value(transcription.status),
        engine: Value(transcription.engine),
        updatedAtUsec: Value(transcription.updatedAtUsec),
      ),
    );
  }

  Future<int> deleteByMedia(String mediaType, String mediaId) {
    return (delete(
      transcriptionTable,
    )..where((tbl) => tbl.mediaType.equals(mediaType) & tbl.mediaId.equals(mediaId))).go();
  }

  Future<int> deleteAllForType(String mediaType) {
    return (delete(transcriptionTable)..where((tbl) => tbl.mediaType.equals(mediaType))).go();
  }
}
