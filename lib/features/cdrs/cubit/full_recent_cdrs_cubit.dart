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
  FullRecentCdrsCubit(this._cdrsLocalRepository, this._cdrsRemoteRepository, {this.pageSize = 50})
    : super(const FullRecentCdrsState());

  final CdrsLocalRepository _cdrsLocalRepository;
  final CdrsRemoteRepository _cdrsRemoteRepository;
  final int pageSize;
  late final StreamSubscription _eventsSub;

  Future<void> init() async {
    _logger.info('Loading recent CDRs');
    final recentCdrs = await _cdrsLocalRepository.getHistory(limit: pageSize);
    // An empty cache only means "loading" while the initial remote sync has not
    // completed yet (no sync cursor); after it, an empty list is genuinely empty.
    final synced = await _cdrsLocalRepository.getLastSyncTime() != null;
    emit(state.copyWith(records: recentCdrs, isLoading: recentCdrs.isEmpty && !synced));
    _eventsSub = _cdrsLocalRepository.events.listen(_handleEvent);

    // Close the race between the cursor read above and the subscription: if the
    // initial sync completed in that window, resolve the loading state now.
    if (state.isLoading && await _cdrsLocalRepository.getLastSyncTime() != null) {
      await _resolveInitialLoad();
    }
  }

  Future<void> _resolveInitialLoad() async {
    final recentCdrs = await _cdrsLocalRepository.getHistory(limit: pageSize);
    if (isClosed) return;
    emit(state.copyWith(records: recentCdrs, isLoading: false));
  }

  Future<void> fetchHistory() async {
    if (state.fetchingHistory || state.historyEndReached) return;

    emit(state.copyWith(fetchingHistory: true));
    try {
      final oldestLocal = state.records.lastOrNull?.connectTime;
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
      emit(state.copyWith(records: recentCdrs, isLoading: false));
    }
    if (event is CdrsInitialSyncCompleted && state.isLoading) {
      // Re-read instead of just clearing the flag: records upserted before the
      // subscription was attached would otherwise be missed.
      _resolveInitialLoad();
    }
    if (event is CdrRecordsWiped) {
      emit(state.copyWith(records: const [], historyEndReached: false));
    }
  }

  @override
  Future<void> close() async {
    await _eventsSub.cancel();
    return super.close();
  }
}
