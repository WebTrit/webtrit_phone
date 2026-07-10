import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'cdrs_list_cubit.dart';

class FullRecentCdrsCubit extends CdrsListCubit {
  FullRecentCdrsCubit(super.localRepository, super.remoteRepository, {super.pageSize});

  @override
  Future<List<CdrRecord>> queryLocal({DateTime? from}) => localRepository.getHistory(from: from, limit: pageSize);

  @override
  bool matches(CdrRecord cdr) => true;

  // The full list paginates on scroll; init never pre-fetches.
  @override
  bool get fetchesOnShortInit => false;

  @override
  Future<void> resolveInitialLoad() async {
    // Re-read instead of just clearing the flag: records upserted before the
    // subscription was attached would otherwise be missed.
    final recentCdrs = await queryLocal();
    if (isClosed) return;
    emit(state.copyWith(records: recentCdrs));
  }

  /// Scroll pagination: the next local page, falling back to one remote page
  /// (persisted silently) when the local store runs out.
  @override
  Future<void> fetchHistory() async {
    if (state.fetchingHistory || state.historyEndReached) return;

    emit(state.copyWith(fetchingHistory: true));
    try {
      final oldestLocal = state.records.lastOrNull?.connectTime;
      var history = await queryLocal(from: oldestLocal);
      if (history.isEmpty) {
        history = await remoteRepository.getHistory(to: oldestLocal, limit: pageSize);
        await localRepository.upsertCdrs(history, silent: true);
      }
      if (history.isEmpty) {
        emit(state.copyWith(fetchingHistory: false, historyEndReached: true));
      } else {
        final recentCdrs = state.records.mergeWithHistory(history).toList();
        emit(state.copyWith(records: recentCdrs, fetchingHistory: false, historyEndReached: false));
      }
    } catch (e, s) {
      logger.severe('Failed to load CDRs', e, s);
      CrashlyticsUtils.recordError(
        e,
        stack: s,
        reason: '$runtimeType.fetchHistory',
        information: [
          'oldestLocal: ${state.records.isNotEmpty ? state.records.last.connectTime.toIso8601String() : 'none'}',
          'pageSize: ${pageSize.toString()}',
          'currentCount: ${state.records.length.toString()}',
        ],
      );
      emit(state.copyWith(fetchingHistory: false));
    }
  }
}
