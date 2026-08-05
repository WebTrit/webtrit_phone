import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'cdrs_list_state.dart';

/// Base for the CDR list cubits (full, missed, per-number). Owns the shared
/// lifecycle: the initial load with its loading gate (an empty cache only
/// means "loading" until the first remote sync completes), the repository
/// event handling, and the remote scan used by the filtered lists. Subclasses
/// provide the local query and the event predicate, and may override the
/// history fetching strategy.
abstract class CdrsListCubit extends Cubit<CdrsListState> {
  CdrsListCubit(this.localRepository, this.remoteRepository, {this.pageSize = 50}) : super(const CdrsListState());

  final CdrsLocalRepository localRepository;
  final CdrsRemoteRepository remoteRepository;
  final int pageSize;

  late final Logger logger = Logger(runtimeType.toString());

  StreamSubscription<CdrRecordsEvent>? _eventsSub;
  bool _initialSyncHandled = false;

  /// Local query backing this list; [from] is the pagination watermark.
  Future<List<CdrRecord>> queryLocal({DateTime? from});

  /// Whether an upserted record belongs to this list.
  bool matches(CdrRecord cdr);

  /// Whether [init] should immediately fetch more when the cache holds fewer
  /// than [pageSize] records. The scan-driven lists do; plain scroll
  /// pagination does not.
  bool get fetchesOnShortInit => true;

  Future<void> init() async {
    logger.info('Loading CDRs');
    try {
      final cached = await queryLocal();
      if (isClosed) return;
      // An empty cache only means "loading" while the initial remote sync has
      // not completed yet; after it, an empty list is genuinely empty.
      final synced = await localRepository.getLastSyncTime() != null;
      if (isClosed) return;
      emit(state.copyWith(records: cached, isLoading: cached.isEmpty && !synced));
      _eventsSub = localRepository.events.listen(_handleEvent);

      if (state.isLoading) {
        // Close the race between the sync-time read above and the subscription:
        // if the initial sync completed in that window, resolve now.
        final syncedNow = await localRepository.getLastSyncTime() != null;
        if (isClosed) return;
        if (syncedNow) await _onInitialSyncCompleted();
      } else {
        _initialSyncHandled = true;
        if (fetchesOnShortInit && cached.length < pageSize) fetchHistory();
      }
    } catch (e, s) {
      logger.severe('Failed to initialize', e, s);
      // Resolve rather than spin forever on an unexpected local failure.
      if (!isClosed) emit(state.copyWith(isLoading: false));
    }
  }

  /// Runs once the initial remote sync has completed: brings the list up to
  /// date and only then resolves the loading state, keeping the loader
  /// visible for the whole first load.
  Future<void> _onInitialSyncCompleted() async {
    if (_initialSyncHandled) return;
    _initialSyncHandled = true;
    try {
      await resolveInitialLoad();
    } catch (e, s) {
      logger.severe('Failed to resolve the initial load', e, s);
    }
    if (isClosed) return;
    emit(state.copyWith(isLoading: false));
  }

  /// Resolves the loading state when a sync cycle fails before the initial
  /// sync ever completed, so a permanently failing or offline backend shows
  /// the empty state instead of an endless spinner. Nothing is latched: the
  /// eventual successful cycle still triggers [resolveInitialLoad] once.
  void _onInitialSyncFailed() {
    if (state.isLoading) emit(state.copyWith(isLoading: false));
  }

  /// Brings the list up to date after the initial sync. Defaults to
  /// [fetchHistory] (local re-read plus remote scan); override when a plain
  /// local re-read is enough.
  Future<void> resolveInitialLoad() => fetchHistory();

  /// Loads more records into the list. The default implementation reads the
  /// next local page and, when it comes up short, scans remote history
  /// (persisting fetched pages silently) for records matching this list.
  ///
  /// The scan is a rough workaround for the missing dedicated API filters and
  /// is limited to 10 pages to avoid excessive data fetching.
  Future<void> fetchHistory() async {
    if (state.fetchingHistory || state.historyEndReached) return;

    emit(state.copyWith(fetchingHistory: true));
    try {
      final oldestLocal = state.records.lastOrNull?.connectTime;
      List<CdrRecord> history = await queryLocal(from: oldestLocal);
      if (isClosed) return;
      emit(state.copyWith(records: state.records.mergeWithHistory(history).toList()));

      if (history.length < pageSize) {
        logger.info('No more local CDRs, scanning remote history');
        DateTime? oldestSynced = await localRepository.getFirstRecordTime();
        List<CdrRecord> scanResult = [];
        int scannedPages = 0;

        while (!isClosed && scannedPages < 10 && scanResult.length < pageSize) {
          logger.info('Scanning remote CDRs iteration: $scannedPages time: $oldestSynced');

          final scanPage = await remoteRepository.getHistory(to: oldestSynced, limit: pageSize);
          if (scanPage.isEmpty) {
            logger.info('No more remote CDRs to scan, stopping search');
            break;
          }
          await localRepository.upsertCdrs(scanPage, silent: true);
          if (isClosed) return;
          oldestSynced = scanPage.last.connectTime;
          final matched = scanPage.where(matches);
          logger.info('Found matching CDRs: ${matched.length} in ${scanPage.length} scanned');

          scanResult.addAll(matched);
          scannedPages++;

          emit(state.copyWith(records: state.records.mergeWithHistory(matched).toList()));
        }

        history.addAll(scanResult);
      }
      if (isClosed) return;
      if (history.isEmpty) {
        emit(state.copyWith(fetchingHistory: false, historyEndReached: true));
      } else {
        emit(state.copyWith(fetchingHistory: false));
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
      if (!isClosed) emit(state.copyWith(fetchingHistory: false));
    }
  }

  void _handleEvent(CdrRecordsEvent event) {
    if (event is CdrRecordUpserted && matches(event.cdr)) {
      final records = state.records.mergeWithUpdate(event.cdr).toList();
      emit(state.copyWith(records: records, isLoading: false));
    }
    if (event is CdrsInitialSyncCompleted) {
      _onInitialSyncCompleted();
    }
    if (event is CdrsInitialSyncFailed) {
      _onInitialSyncFailed();
    }
    if (event is CdrRecordsWiped) {
      // A wipe clears the sync cursor as well, returning the store to its
      // pre-initial-sync state: drop the in-memory records and re-arm the
      // loading gate until the next sync cycle reports the fresh state.
      _initialSyncHandled = false;
      emit(state.copyWith(records: const [], isLoading: true, historyEndReached: false));
    }
  }

  @override
  Future<void> close() async {
    await _eventsSub?.cancel();
    return super.close();
  }
}
