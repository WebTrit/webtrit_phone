import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';

part 'number_cdrs_log_state.dart';

final _logger = Logger('NumberCdrsLogCubit');

class NumberCdrsLogCubit extends Cubit<NumberCdrsLogState> {
  NumberCdrsLogCubit(
    this.number,
    this._cdrsLocalRepository,
    this._cdrsRemoteRepository,
    this._submitNotification, {
    this.pageSize = 50,
  }) : super(const NumberCdrsLogState());

  final String number;
  final CdrsLocalRepository _cdrsLocalRepository;
  final CdrsRemoteRepository _cdrsRemoteRepository;
  final Function(Notification) _submitNotification;
  final int pageSize;
  late final StreamSubscription _eventsSub;

  init() async {
    _logger.info('Loading number CDRs');
    final numberCdrs = await _cdrsLocalRepository.getHistory(
      number: number,
      limit: pageSize,
    );
    emit(state.copyWith(records: numberCdrs, isLoading: false));
    _eventsSub = _cdrsLocalRepository.events.listen(_handleEvent);

    // If we didn't load enough missed CDRs, try to scan more from remote
    if (numberCdrs.length < pageSize) fetchHistory();
  }

  Future<void> fetchHistory() async {
    if (state.fetchingHistory || state.historyEndReached) return;

    emit(state.copyWith(fetchingHistory: true));
    try {
      final oldestLocal = state.records.lastOrNull?.connectTime;
      List<CdrRecord> history = await _cdrsLocalRepository.getHistory(
        number: number,
        from: oldestLocal,
        limit: pageSize,
      );
      emit(state.copyWith(records: state.records.mergeWithHistory(history).toList()));

      /// If we didn't find enough number CDRs locally, we need to scan remote history
      /// to find more number calls, as they might be outside of the local database range.
      /// this is rough workaround because we don't have a dedicated API or filters to fetch only number CDRs.
      /// scan limited to 10 pages to avoid excessive data fetching.
      if (history.length < pageSize) {
        _logger.info('No more local number CDRs, scanning remote history');
        DateTime? oldestSynced = await _cdrsLocalRepository.getFirstRecordTime();
        List<CdrRecord> numberScanResult = [];
        int scannedPages = 0;

        while (scannedPages < 10 && numberScanResult.length < pageSize) {
          _logger.info('Scanning remote CDRs iteration: $scannedPages time: $oldestSynced');

          final scanPage = await _cdrsRemoteRepository.getHistory(to: oldestSynced, limit: pageSize);
          if (scanPage.isEmpty) {
            _logger.info('No more remote CDRs to scan, stopping search');
            break;
          }
          await _cdrsLocalRepository.upsertCdrs(scanPage, silent: true);
          oldestSynced = scanPage.last.connectTime;
          final numberCdrs = scanPage.where((cdr) => cdr.callerNumber == number || cdr.calleeNumber == number);
          _logger.info('Found number CDRs: ${numberCdrs.length} in ${scanPage.length} scanned');

          numberScanResult.addAll(numberCdrs);
          scannedPages++;

          emit(state.copyWith(records: state.records.mergeWithHistory(numberCdrs).toList()));
        }

        history.addAll(numberScanResult);
      }
      if (history.isEmpty) {
        emit(state.copyWith(fetchingHistory: false, historyEndReached: true));
      } else {
        emit(state.copyWith(fetchingHistory: false));
      }
    } catch (e, s) {
      _submitNotification(DefaultErrorNotification(e));
      _logger.severe('Failed to load CDRs', e, s);
      emit(state.copyWith(fetchingHistory: false));
    }
  }

  void _handleEvent(CdrRecordsEvent event) {
    if (event is CdrRecordUpserted && (event.cdr.callerNumber == number || event.cdr.calleeNumber == number)) {
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
