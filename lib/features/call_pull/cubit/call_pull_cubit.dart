import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:quiver/collection.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('CallPullCubit');

class CallPullCubit extends Cubit<List<DialogInfo>> {
  CallPullCubit({required this.userRepository, required this.dialogInfoRepository, required this.linesStateRepository})
    : super([]);

  final UserRepository userRepository;
  final DialogInfoRepository dialogInfoRepository;
  final LinesStateRepository linesStateRepository;
  final _activeCallIdsTtl = Duration(minutes: 5);
  final LruMap<String, DateTime> _activeCallIds = LruMap<String, DateTime>(maximumSize: 50);
  StreamSubscription? _userSub;
  StreamSubscription? _dialogInfoSub;
  StreamSubscription? _linesStateSub;
  List<DialogInfo> _dialogInfos = [];
  String? _mainNumber;

  void init() {
    _userSub = userRepository.getAndListen().listen(_onUserInfo, onError: _onUserError, cancelOnError: false);

    _linesStateSub = linesStateRepository.getStateAndListen().listen(_onLinesState);
  }

  void _onUserInfo(UserInfo userInfo) {
    if (isClosed) return;
    _mainNumber = userInfo.numbers.main;
    _logger.info('Main number updated: $_mainNumber');
    _subscribeToDialogs();
  }

  void _onUserError(Object error, StackTrace stackTrace) {
    _logger.warning('Failed to get user info', error, stackTrace);
  }

  void _onLinesState(LinesState linesState) {
    if (isClosed) return;
    final now = DateTime.now();
    final activeCallIds = [
      ...linesState.mainLines.whereType<InUseLineState>().map((line) => line.callId),
      if (linesState.guestLine is InUseLineState) (linesState.guestLine as InUseLineState).callId,
    ];
    for (final callId in activeCallIds) {
      _activeCallIds[callId] = now;
    }
    _removeExpiredActiveCallIds(now);
    _logger.info('Lines state updated: $linesState, activeCallIds: ${_activeCallIds.length}');
    _computeState();
  }

  void _subscribeToDialogs() {
    _dialogInfoSub?.cancel();
    if (_mainNumber == null) return;
    _dialogInfoSub = dialogInfoRepository.watchNumberDialogs(_mainNumber!).listen(_onDialogs);
  }

  void _onDialogs(List<DialogInfo> dialogs) {
    if (isClosed) return;
    _logger.info('Dialogs updated: ${dialogs.length} dialogs');
    _dialogInfos = dialogs;
    _computeState();
  }

  void _removeExpiredActiveCallIds(DateTime now) {
    final expiredCallIds = _activeCallIds.entries
        .where((entry) => now.difference(entry.value) > _activeCallIdsTtl)
        .map((entry) => entry.key)
        .toList();
    for (final callId in expiredCallIds) {
      _activeCallIds.remove(callId);
    }
  }

  bool _isActiveOrRecentlyActiveCallId(String callId, DateTime now) {
    final updatedAt = _activeCallIds[callId];
    if (updatedAt == null) {
      return false;
    }
    if (now.difference(updatedAt) > _activeCallIdsTtl) {
      _activeCallIds.remove(callId);
      return false;
    }
    return true;
  }

  void _computeState() {
    final now = DateTime.now();
    _removeExpiredActiveCallIds(now);

    final notMine = _dialogInfos
        .where((dialog) => dialog.callId != null && !_isActiveOrRecentlyActiveCallId(dialog.callId!, now))
        .toList();

    final uniqCallIds = <String, DialogInfo>{};
    for (final dialog in notMine) {
      uniqCallIds.putIfAbsent(dialog.callId!, () => dialog);
    }

    _logger.info('Computed pullable dialogs: ${uniqCallIds.length}/${notMine.length}/${_dialogInfos.length} dialogs');

    emit(uniqCallIds.values.toList());
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    _dialogInfoSub?.cancel();
    _linesStateSub?.cancel();
    return super.close();
  }
}
