import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'session_status_state.dart';

part 'session_status_cubit.freezed.dart';

final _logger = Logger('SessionStatusCubit');

class SessionStatusCubit extends Cubit<SessionStatusState> {
  SessionStatusCubit({required PushTokensBloc pushTokensBloc, required CallBloc callBloc})
    : super(const SessionStatusState()) {
    _lastPushTokensState = pushTokensBloc.state;
    _lastCallState = callBloc.state;
    _pushTokensSubscription = pushTokensBloc.stream.listen(_onPushTokensChanged);
    _callSubscription = callBloc.stream.listen(_onCallChanged);

    _emitCombinedStatus();
  }

  // Reconnect cycle fires every 3 sec; 3.5 sec absorbs status changes within
  // a cycle without delaying genuine transitions between ready and error states.
  static const _kReconnectDebounce = Duration(milliseconds: 3500);

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;
  late final StreamSubscription<CallState> _callSubscription;

  PushTokensState? _lastPushTokensState;
  CallState? _lastCallState;

  final _debounce = DebounceMap<String>(_kReconnectDebounce);
  SessionStatus? _pendingStatus;

  void _onPushTokensChanged(PushTokensState pushTokens) {
    _lastPushTokensState = pushTokens;
    _emitCombinedStatus();
  }

  void _onCallChanged(CallState call) {
    _lastCallState = call;
    _emitCombinedStatus();
  }

  void _emitCombinedStatus() {
    _logger.finest('emitCombinedStatus: $_lastPushTokensState, $_lastCallState');

    final pushTokens = _lastPushTokensState;
    final call = _lastCallState;

    if (pushTokens == null || call == null) {
      _logger.warning('emitCombinedStatus: skipped — pushTokens=$pushTokens, call=$call');
      return;
    }

    final newStatus = _mapCallStatusToSessionStatus(call.status, pushTokens);

    if (_isTransientReconnecting(newStatus) && _isTransientReconnecting(state.status)) {
      // Suppress AnimatedSwitcher flicker during reconnect backoff (WT-1431).
      // Debounce fires only when the target status changes — not on every event —
      // so rapid transitions between connectIssue, inProgress, connectError do not animate.
      if (newStatus == state.status || newStatus == _pendingStatus) return;
      _pendingStatus = newStatus;
      _debounce.schedule('status', _emitDebouncedStatus);
    } else {
      // Critical boundary: ready, error, connectivityNone, appUnregistered — immediate.
      _pendingStatus = null;
      _debounce.cancel('status');
      emit(state.copyWith(status: newStatus));
    }
  }

  void _emitDebouncedStatus() {
    _pendingStatus = null;
    final pushTokens = _lastPushTokensState;
    final call = _lastCallState;
    if (pushTokens == null || call == null) {
      _logger.warning('emitDebouncedStatus: skipped — pushTokens=$pushTokens, call=$call');
      return;
    }
    final freshStatus = _mapCallStatusToSessionStatus(call.status, pushTokens);
    _logger.info('debounce fired, status: $freshStatus');
    emit(state.copyWith(status: freshStatus));
  }

  bool _isTransientReconnecting(SessionStatus status) =>
      status == SessionStatus.connectIssue ||
      status == SessionStatus.inProgress ||
      status == SessionStatus.connectError;

  SessionStatus _mapCallStatusToSessionStatus(CallStatus callStatus, PushTokensState pushTokens) {
    final pushTokenError = (pushTokens.pushToken == null && pushTokens.errorMessage != null)
        ? pushTokens.errorMessage
        : null;
    return SessionStatus(signalingStatus: callStatus, pushTokenError: pushTokenError);
  }

  @override
  Future<void> close() {
    _debounce.dispose();
    _pushTokensSubscription.cancel();
    _callSubscription.cancel();
    return super.close();
  }
}
