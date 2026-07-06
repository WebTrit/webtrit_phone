import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

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
    _fetchCallDeliveryMode();
  }

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;
  late final StreamSubscription<CallState> _callSubscription;

  PushTokensState? _lastPushTokensState;
  CallState? _lastCallState;
  CallkeepAndroidCallDeliveryMode _callDeliveryMode = CallkeepAndroidCallDeliveryMode.unknown;

  void _onPushTokensChanged(PushTokensState pushTokens) {
    _lastPushTokensState = pushTokens;
    _emitCombinedStatus();
  }

  void _onCallChanged(CallState call) {
    _lastCallState = call;
    _emitCombinedStatus();
  }

  /// The call-delivery mode is a device capability that does not change at
  /// runtime, so it is fetched once at session start.
  Future<void> _fetchCallDeliveryMode() async {
    try {
      _callDeliveryMode = await WebtritCallkeepPermissions().getCallDeliveryMode();
      _emitCombinedStatus();
    } catch (e) {
      _logger.warning('fetchCallDeliveryMode', e);
    }
  }

  /// Builds the generic side-issue list from the known sources. Add a source
  /// here to surface a new issue; the UI consumes the list generically.
  List<SessionIssue> _buildIssues() {
    final issues = <SessionIssue>[];
    if (_callDeliveryMode == CallkeepAndroidCallDeliveryMode.standalone) {
      issues.add(
        const SessionIssue(id: SessionIssueId.limitedStandaloneCallMode, severity: SessionIssueSeverity.warning),
      );
    }
    return issues;
  }

  void _emitCombinedStatus() {
    _logger.finest('emitCombinedStatus: $_lastPushTokensState, $_lastCallState');

    final pushTokens = _lastPushTokensState;
    final call = _lastCallState;
    if (pushTokens == null || call == null) {
      _logger.warning('emitCombinedStatus: skipped — pushTokens=$pushTokens, call=$call');
      return;
    }

    final pushTokenError = (pushTokens.pushToken == null && pushTokens.errorMessage != null)
        ? pushTokens.errorMessage
        : null;
    emit(
      state.copyWith(
        status: SessionStatus(signalingStatus: call.status, pushTokenError: pushTokenError),
        issues: _buildIssues(),
      ),
    );
  }

  @override
  Future<void> close() {
    _callSubscription.cancel();
    _pushTokensSubscription.cancel();
    return super.close();
  }
}
