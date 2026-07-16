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
      ),
    );
  }

  /// Resets rows holding [status] back to "not attempted" (status and engine
  /// cleared); used to recover items left mid-lifecycle by an interrupted run.
  Future<int> clearStatuses(String status) {
    return (update(transcriptionTable)..where((tbl) => tbl.status.equals(status))).write(
      const TranscriptionDataCompanion(status: Value(null), engine: Value(null)),
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

  /// Wipes every transcription for regeneration (a model switch). Callers
  /// rely on watchers of [TranscriptionTable] (e.g. the missing-transcription
  /// join) re-running right after this to re-enqueue - but drift only
  /// notifies watchers when a write actually changes rows, so a switch that
  /// starts from an empty table (nothing was ever transcribed, e.g. coming
  /// from an "off" selection) would otherwise leave those watchers silent
  /// forever. [markTablesUpdated] forces the notification unconditionally.
  Future<int> deleteAll() async {
    final deleted = await delete(transcriptionTable).go();
    markTablesUpdated({transcriptionTable});
    return deleted;
  }
}
