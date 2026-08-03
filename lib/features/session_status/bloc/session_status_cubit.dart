import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/call_status.dart';
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
    _fetchCallDeliveryMode();
  }

  late final StreamSubscription<PushTokensState> _pushTokensSubscription;
  late final StreamSubscription<CallState> _callSubscription;

  PushTokensState? _lastPushTokensState;
  CallState? _lastCallState;
  CallkeepAndroidCallDeliveryMode _callDeliveryMode = CallkeepAndroidCallDeliveryMode.unknown;

  final Debounce _transientDebounce = Debounce(kSignalingStatusDebounce);
  SessionStatusState? _pendingTransient;

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
    _emitDebounced(
      state.copyWith(
        status: SessionStatus(signalingStatus: call.status, pushTokenError: pushTokenError),
        issues: _buildIssues(),
      ),
    );
  }

  /// Smooths the transient reconnecting states so a reconnect cycle does not
  /// flicker the UI. Hard states (ready, no network, unregistered) always show
  /// immediately; a transient state is held back for [kSignalingStatusDebounce]
  /// and only surfaces if the episode outlives the window:
  ///
  /// - from ready the previous status stays on screen, so the re-register blip
  ///   after a recovery never reaches the UI;
  /// - from a hard non-ready state (e.g. the network just came back) a calm
  ///   "connecting" shows right away instead of the real derived state, which
  ///   at that moment still carries a stale connect error from the outage;
  /// - transient-to-transient changes only update the pending state.
  ///
  /// The window is scheduled once per transient episode (not reset by further
  /// transient changes): during a prolonged outage the reconnect cycle keeps
  /// oscillating between transient states, and re-scheduling on each of them
  /// would postpone the real status forever.
  void _emitDebounced(SessionStatusState next) {
    if (!next.status.signalingStatus.isTransientReconnecting) {
      _pendingTransient = null;
      _transientDebounce.cancel();
      emit(next);
      return;
    }

    if (_pendingTransient == null) {
      _transientDebounce.schedule(() {
        final pending = _pendingTransient;
        _pendingTransient = null;
        if (pending != null && !isClosed) emit(pending);
      });
    }
    _pendingTransient = next;

    final displayed = state.status.signalingStatus;
    if (displayed == CallStatus.ready || displayed.isTransientReconnecting) return;

    emit(
      next.copyWith(
        status: SessionStatus(signalingStatus: CallStatus.inProgress, pushTokenError: next.status.pushTokenError),
      ),
    );
  }

  @override
  Future<void> close() {
    _transientDebounce.dispose();
    _callSubscription.cancel();
    _pushTokensSubscription.cancel();
    return super.close();
  }
}
