// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract class CdrsLocalRepository {
  /// Fetches the history of Call Detail Records (CDRs) from the local database.
  ///
  /// [number] - Optional parameter to filter records by phone number.
  /// [status] - Optional parameter to filter records by call status.
  /// [direction] - Optional parameter to filter records by call direction.
  /// [from] - Optional parameter to filter records `from` this date.
  /// [to] - Optional parameter to filter records `to` this date.
  /// [limit] - Optional parameter to limit the number of records returned.
  Future<List<CdrRecord>> getHistory({
    String? number,
    String? destination,
    CdrStatus? status,
    CallDirection? direction,
    DateTime? from,
    DateTime? to,
    int? limit,
  });

  /// Inserts or updates a list of Call Detail Records (CDRs) in the local database.
  /// [cdrs] - List of CDRs to be upserted.
  /// Returns a Future that completes when the operation is done.
  Future<void> upsertCdrs(List<CdrRecord> cdrs, {bool silent = false});

  /// Stream of events related to Call Detail Records (CDRs).
  /// Emits events when CDRs are upserted.
  Stream<CdrRecordsEvent> get events;

  /// Retrieves the timestamp of the last update made to the Call Detail Records (CDRs).
  Future<DateTime?> getLastUpdate();

  /// Retrieves the timestamp of the first record in the Call Detail Records (CDRs).
  Future<DateTime?> getFirstRecordTime();

  /// Wipes all Call Detail Records (CDRs) data from the local database.
  Future<void> wipeData();
}

class CdrsLocalRepositoryDriftImpl with CdrDriftMapper implements CdrsLocalRepository {
  CdrsLocalRepositoryDriftImpl(this._appDatabase);

  final AppDatabase _appDatabase;
  late final _dao = _appDatabase.cdrsDao;

  final StreamController<CdrRecordsEvent> _eventBus = StreamController.broadcast();

  @override
  Future<void> upsertCdrs(List<CdrRecord> cdrs, {bool silent = false}) async {
    final driftCdrs = cdrs.map(cdrToDrift).toList();
    await _dao.upsertCdrs(driftCdrs);
    if (silent) return;
    cdrs.forEach((cdr) => _eventBus.add(CdrRecordUpserted(cdr)));
  }

  @override
  Future<List<CdrRecord>> getHistory({
    String? number,
    String? destination,
    CdrStatus? status,
    CallDirection? direction,
    DateTime? from,
    DateTime? to,
    int? limit,
  }) async {
    final driftCdrs = await _dao.getHistory(
      number: number,
      destination: destination,
      from: from,
      to: to,
      limit: limit,
      status: status != null ? CdrStatusData.values.byName(status.name) : null,
      direction: direction != null ? CallDirectionData.values.byName(direction.name) : null,
    );
    return driftCdrs.map(cdrFromDrift).toList();
  }

  @override
  Future<DateTime?> getLastUpdate() async {
    return await _dao.getLastUpdate();
  }

  @override
  Future<DateTime?> getFirstRecordTime() async {
    return await _dao.getFirstRecordTime();
  }

  @override
  Stream<CdrRecordsEvent> get events => _eventBus.stream;

  @override
  Future<void> wipeData() async {
    await _dao.wipeData();
  }
}

class CdrRecordsEvent {}

class CdrRecordUpserted extends CdrRecordsEvent {
  CdrRecordUpserted(this.cdr);

  final CdrRecord cdr;
}
