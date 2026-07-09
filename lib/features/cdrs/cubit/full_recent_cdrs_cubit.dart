import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'full_recent_cdrs_state.dart';

final _logger = Logger('FullRecentCdrsCubit');

class FullRecentCdrsCubit extends Cubit<FullRecentCdrsState> {
  FullRecentCdrsCubit(
    this._cdrsLocalRepository,
    this._cdrsRemoteRepository, {
    this.pageSize = 50,
    Future<void>? initialSyncDone,
  }) : _initialSyncDone = initialSyncDone,
       super(const FullRecentCdrsState());

  final CdrsLocalRepository _cdrsLocalRepository;
  final CdrsRemoteRepository _cdrsRemoteRepository;
  final int pageSize;

  /// Resolves when the first remote sync cycle has completed. Used to keep the
  /// initial loading indicator visible until the first `/user/history` fetch
  /// resolves, instead of flashing an empty list while it is still in flight.
  final Future<void>? _initialSyncDone;

  late final StreamSubscription _eventsSub;

  Future<void> init() async {
    _logger.info('Loading recent CDRs');
    _eventsSub = _cdrsLocalRepository.events.listen(_handleEvent);

    final recentCdrs = await _cdrsLocalRepository.getHistory(limit: pageSize);
    if (recentCdrs.isNotEmpty || _initialSyncDone == null) {
      emit(state.copyWith(records: recentCdrs, isLoading: false));
      return;
    }

    // Local cache is empty: keep loading until the first remote sync resolves,
    // then re-read whatever it stored (records also arrive live via events).
    await _initialSyncDone;
    if (isClosed) return;
    final syncedCdrs = await _cdrsLocalRepository.getHistory(limit: pageSize);
    emit(state.copyWith(records: syncedCdrs, isLoading: false));
  }

  Future<void> fetchHistory() async {
    if (state.fetchingHistory || state.historyEndReached) return;

    emit(state.copyWith(fetchingHistory: true));
    try {
      final oldestLocal = state.records.last.connectTime;
      var history = await _cdrsLocalRepository.getHistory(from: oldestLocal, limit: pageSize);
      if (history.isEmpty) {
        history = await _cdrsRemoteRepository.getHistory(to: oldestLocal, limit: pageSize);
        await _cdrsLocalRepository.upsertCdrs(history, silent: true);
      }
      if (history.isEmpty) {
        emit(state.copyWith(fetchingHistory: false, historyEndReached: true));
      } else {
        final recentCdrs = state.records.mergeWithHistory(history).toList();
        emit(state.copyWith(records: recentCdrs, fetchingHistory: false, historyEndReached: false));
      }
    } catch (e, s) {
      _logger.severe('Failed to load CDRs', e, s);
      CrashlyticsUtils.recordError(
        e,
        stack: s,
        reason: 'FullRecentCdrsCubit.fetchHistory',
        information: [
          'oldestLocal: ${state.records.isNotEmpty ? state.records.last.connectTime.toIso8601String() : 'none'}',
          'pageSize: ${pageSize.toString()}',
          'currentCount: ${state.records.length.toString()}',
        ],
      );
      emit(state.copyWith(fetchingHistory: false));
    }
  }

  void _handleEvent(CdrRecordsEvent event) {
    if (event is CdrRecordUpserted) {
      final recentCdrs = state.records.mergeWithUpdate(event.cdr).toList();
      emit(state.copyWith(records: recentCdrs));
    }
  }

  @override
  Future<void> close() async {
    await _eventsSub.cancel();
    return super.close();
  }
}
