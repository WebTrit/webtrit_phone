import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

part 'session_status_state.dart';

part 'session_status_cubit.freezed.dart';

final _logger = Logger('SessionStatusCubit');

class SessionStatusCubit extends Cubit<SessionStatusState> {
  SessionStatusCubit({required PushTokensBloc pushTokensBloc, required CallBloc callBloc})
    : super(const SessionStatusState()) {
    _pushTokensSubscription = pushTokensBloc.stream.listen(_onPushTokensChanged);
    _callSubscription = callBloc.stream.listen(_onCallChanged);

    _emitCombinedStatus(pushTokensBloc.state, callBloc.state);
  }

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;
  late final StreamSubscription<CallState> _callSubscription;

  PushTokensState? _lastPushTokensState;
  CallState? _lastCallState;

  void _onPushTokensChanged(PushTokensState pushTokens) {
    _lastPushTokensState = pushTokens;
    _emitCombinedStatus();
  }

  void _onCallChanged(CallState call) {
    _lastCallState = call;
    _emitCombinedStatus();
  }

  void _emitCombinedStatus([PushTokensState? initialPushTokens, CallState? initialCall]) {
    _logger.finest('emitCombinedStatus: $_lastPushTokensState, $_lastCallState');

    final pushTokens = initialPushTokens ?? _lastPushTokensState;
    final call = initialCall ?? _lastCallState;

    if (pushTokens != null && call != null) {
      emit(state.copyWith(status: _mapCallStatusToSessionStatus(call.status, pushTokens)));
    }
  }

  SessionStatus _mapCallStatusToSessionStatus(CallStatus callStatus, PushTokensState pushTokens) {
    // Use push token error as the main status if there is no push token or push token not delivered
    if (pushTokens.pushToken == null && pushTokens.errorMessage != null) {
      return SessionStatus.pushTokenError;
    }

    // Use call status as the main status
    return switch (callStatus) {
      CallStatus.connectivityNone => SessionStatus.connectivityNone,
      CallStatus.connectError => SessionStatus.connectError,
      CallStatus.appUnregistered => SessionStatus.appUnregistered,
      CallStatus.connectIssue => SessionStatus.connectIssue,
      CallStatus.inProgress => SessionStatus.inProgress,
      CallStatus.ready => SessionStatus.ready,
    };
  }

  @override
  Future<void> close() {
    _pushTokensSubscription.cancel();
    _callSubscription.cancel();
    return super.close();
  }
}
