import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

final _logger = Logger('CallPullCubit');

class CallPullCubit extends Cubit<List<DialogInfo>> {
  CallPullCubit({required this.userRepository, required this.dialogInfoRepository, required this.linesStateRepository})
    : super([]);

  final UserRepository userRepository;
  final DialogInfoRepository dialogInfoRepository;
  final LinesStateRepository linesStateRepository;
  StreamSubscription? _userSub;
  StreamSubscription? _dialogInfoSub;
  StreamSubscription? _linesStateSub;

  String? _mainNumber;
  List<String> _activeCallIds = [];
  List<DialogInfo> _dialogInfos = [];

  void init() {
    _userSub = userRepository.getAndListen().listen(
      (userInfo) {
        if (isClosed) return;
        _mainNumber = userInfo.numbers.main;
        _logger.info('Main number updated: $_mainNumber');
        _subscribeToDialogs();
      },
      onError: (e, st) {
        _logger.warning('Failed to get user info', e, st);
      },
      cancelOnError: false,
    );

    _linesStateSub = linesStateRepository.getStateAndListen().listen((linesState) {
      if (isClosed) return;
      _activeCallIds = [
        ...linesState.mainLines.whereType<InUseLineState>().map((line) => line.callId),
        if (linesState.guestLine is InUseLineState) (linesState.guestLine as InUseLineState).callId,
      ];
      _logger.info('Lines state updated: $linesState, activeCallIds: $_activeCallIds');
      _computeState();
    });
  }

  void _subscribeToDialogs() {
    _dialogInfoSub?.cancel();
    if (_mainNumber == null) return;
    _dialogInfoSub = dialogInfoRepository.watchNumberDialogs(_mainNumber!).listen((dialogs) {
      if (isClosed) return;
      _logger.info('Dialogs updated: ${dialogs.length} dialogs');
      _dialogInfos = dialogs;
      _computeState();
    });
  }

  void _computeState() {
    final notMine = _dialogInfos
        .where((dialog) => dialog.callId != null && !_activeCallIds.contains(dialog.callId))
        .toList();

    final uniqCallIds = notMine
        .map((e) => e.callId!)
        .toSet()
        .map((e) => _dialogInfos.firstWhere((d) => d.callId == e))
        .toList();

    _logger.info('Computed pullable dialogs: ${uniqCallIds.length}/${notMine.length}/${_dialogInfos.length} dialogs');

    emit(uniqCallIds);
  }

  @override
  Future<void> close() {
    _userSub?.cancel();
    _dialogInfoSub?.cancel();
    _linesStateSub?.cancel();
    return super.close();
  }
}
