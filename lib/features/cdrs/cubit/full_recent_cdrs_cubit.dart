import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';

part 'full_recent_cdrs_state.dart';

final _logger = Logger('FullRecentCdrsCubit');

class FullRecentCdrsCubit extends Cubit<FullRecentCdrsState> {
  FullRecentCdrsCubit(
    this._cdrsLocalRepository,
    this._cdrsRemoteRepository,
    this._submitNotification, {
    this.pageSize = 50,
  }) : super(const FullRecentCdrsState());

  final CdrsLocalRepository _cdrsLocalRepository;
  final CdrsRemoteRepository _cdrsRemoteRepository;
  final Function(Notification) _submitNotification;
  final int pageSize;
  late final StreamSubscription _eventsSub;

  init() async {
    _logger.info('Loading recent CDRs');
    final recentCdrs = await _cdrsLocalRepository.getHistory(limit: pageSize);
    emit(state.copyWith(records: recentCdrs, isLoading: false));
    _eventsSub = _cdrsLocalRepository.events.listen(_handleEvent);
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
      _submitNotification(DefaultErrorNotification(e));
      _logger.severe('Failed to load CDRs', e, s);
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
