import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
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

  // Slightly longer than kSignalingClientReconnectDelay so the debounce absorbs
  // all status changes within one reconnect cycle without delaying genuine
  // transitions between ready and error states.
  static final _kReconnectDebounce = kSignalingClientReconnectDelay + const Duration(milliseconds: 500);

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;
  late final StreamSubscription<CallState> _callSubscription;

  PushTokensState? _lastPushTokensState;
  CallState? _lastCallState;

  /// Debounces transitions within the transient reconnecting zone to prevent
  /// AnimatedSwitcher from animating on every reconnect attempt.
  final _debounce = Debounce(_kReconnectDebounce);

  /// The status queued by [_debounce] but not yet emitted.
  /// Prevents the debounce timer from resetting when the same target status
  /// arrives repeatedly during the reconnect backoff cycle.
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

    final newStatus = _resolveCurrentStatus();
    if (newStatus == null) return;

    if (_isTransientReconnecting(newStatus) && _isTransientReconnecting(state.status)) {
      // Suppress AnimatedSwitcher flicker during reconnect backoff (WT-1431).
      // Debounce fires only when the target status changes — not on every event —
      // so rapid transitions between connectIssue, inProgress, connectError do not animate.
      if (newStatus == state.status || newStatus == _pendingStatus) return;
      _pendingStatus = newStatus;
      _debounce.schedule(_emitDebouncedStatus);
    } else {
      // Critical boundary: ready, error, connectivityNone, appUnregistered — immediate.
      _pendingStatus = null;
      _debounce.cancel();
      emit(state.copyWith(status: newStatus));
    }
  }

  void _emitDebouncedStatus() {
    _pendingStatus = null;
    final freshStatus = _resolveCurrentStatus();
    if (freshStatus == null) return;
    _logger.info('debounce fired, status: $freshStatus');
    emit(state.copyWith(status: freshStatus));
  }

  SessionStatus? _resolveCurrentStatus() {
    final pushTokens = _lastPushTokensState;
    final call = _lastCallState;
    if (pushTokens == null || call == null) {
      _logger.warning('resolveCurrentStatus: skipped — pushTokens=$pushTokens, call=$call');
      return null;
    }
    return _mapCallStatusToSessionStatus(call.status, pushTokens);
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
