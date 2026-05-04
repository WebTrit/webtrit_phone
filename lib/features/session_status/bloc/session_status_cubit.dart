import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
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

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;
  late final StreamSubscription<CallState> _callSubscription;

  PushTokensState? _lastPushTokensState;
  CallState? _lastCallState;

  /// The [CallStatus] of the last successfully emitted state.
  /// Used to check whether the previous emitted state was in the transient zone.
  CallStatus? _lastEmittedCallStatus;

  /// Debounces transitions within the transient reconnecting zone to prevent
  /// AnimatedSwitcher from animating on every reconnect attempt.
  final _debounce = Debounce(kSignalingStatusDebounce);

  /// The [CallStatus] queued by [_debounce] but not yet emitted.
  /// Prevents the debounce timer from resetting when the same target status
  /// arrives repeatedly during the reconnect backoff cycle.
  ///
  /// Note: when statuses alternate (e.g. inProgress, connectError, inProgress)
  /// each arrival carries a different target, so the timer keeps resetting and
  /// fires only once the cycle stabilises. The UI intentionally stays on the
  /// last emitted pre-transient status (e.g. connectIssue) until the connection
  /// resolves or the cycle stops alternating.
  CallStatus? _pendingCallStatus;

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
      _logger.warning('resolveCurrentStatus: skipped — pushTokens=$pushTokens, call=$call');
      return;
    }

    final newCallStatus = call.status;
    final lastEmitted = _lastEmittedCallStatus;

    if (lastEmitted != null && newCallStatus.isTransientReconnecting && lastEmitted.isTransientReconnecting) {
      // Suppress AnimatedSwitcher flicker during reconnect backoff (WT-1431).
      // Debounce fires only when the target status changes — not on every event —
      // so rapid transitions between connectIssue, inProgress, connectError do not animate.
      if (newCallStatus == _pendingCallStatus) return;
      _pendingCallStatus = newCallStatus;
      _debounce.schedule(_emitDebouncedStatus);
    } else {
      // Critical boundary: ready, connectivityNone, appUnregistered — immediate.
      _pendingCallStatus = null;
      _debounce.cancel();
      _emitMapped(newCallStatus, pushTokens);
    }
  }

  void _emitDebouncedStatus() {
    _pendingCallStatus = null;
    final pushTokens = _lastPushTokensState;
    final call = _lastCallState;
    if (pushTokens == null || call == null) return;
    _logger.info('debounce fired, callStatus: ${call.status}');
    _emitMapped(call.status, pushTokens);
  }

  void _emitMapped(CallStatus callStatus, PushTokensState pushTokens) {
    _lastEmittedCallStatus = callStatus;
    emit(state.copyWith(status: _mapCallStatusToSessionStatus(callStatus, pushTokens)));
  }

  SessionStatus _mapCallStatusToSessionStatus(CallStatus callStatus, PushTokensState pushTokens) {
    final pushTokenError = (pushTokens.pushToken == null && pushTokens.errorMessage != null)
        ? pushTokens.errorMessage
        : null;
    return SessionStatus(signalingStatus: callStatus, pushTokenError: pushTokenError);
  }

  @override
  Future<void> close() {
    _callSubscription.cancel();
    _pushTokensSubscription.cancel();
    _debounce.dispose();
    return super.close();
  }
}
