import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/app/constants.dart';

final _logger = Logger('SignalingReconnectController');

/// Carries the full context of a connection failure passed to
/// [SignalingReconnectController.onConnectionFailed].
///
/// - [knownCode] is `null` for initial-connect failures ([SignalingConnectionFailed]),
///   or the decoded [SignalingDisconnectCode] for unexpected disconnects.
/// - [systemCode] and [systemReason] are the raw WebSocket close code and reason
///   from the server, useful for detailed error display.
typedef SignalingFailureInfo = ({SignalingDisconnectCode? knownCode, int? systemCode, String? systemReason});

/// Centralizes all signaling reconnect logic and connection-failure notification
/// decisions for both the foreground [CallBloc] and background [IsolateManager].
///
/// ## Responsibilities
///
/// - Schedules reconnect timers after [SignalingConnectionFailed] and
///   [SignalingDisconnected] events.
/// - Guards reconnects by [_appActive] and [_networkActive] flags.
/// - Tracks consecutive connect failures and calls [onConnectionFailed] only
///   after [notifyAfterConsecutiveFailures] attempts - suppressing spurious
///   toasts for transient failures (e.g. brief DNS unavailability on screen
///   unlock).
/// - Calls [onConnectionFailed] immediately when an established connection is
///   lost, because a previously established session was dropped, which is always
///   user-visible.
/// - Tracks persistent connection availability and calls
///   [onConnectionPresenceChanged] whenever the availability transitions
///   between available and unavailable - suitable for driving a persistent
///   UI indicator (e.g. a "No connection" banner).
///
/// ## Usage
///
/// Feed external lifecycle and connectivity events via the `notify*` methods.
/// The controller subscribes to [SignalingModule.events] internally and manages
/// the reconnect timer on its own. Consumers must call [dispose] when done.
///
/// ```dart
/// final controller = SignalingReconnectController(
///   signalingModule: module,
///   onConnectionFailed: (failure) => submitNotification(SignalingConnectFailedNotification()),
///   onConnectionPresenceChanged: (isAvailable) => add(_SignalingPresenceChanged(isAvailable)),
/// );
///
/// // On app lifecycle change:
/// controller.notifyAppResumed();
/// controller.notifyAppPaused(hasActiveCalls: state.isActive);
///
/// // On connectivity change:
/// controller.notifyNetworkAvailable();
/// controller.notifyNetworkUnavailable();
/// ```
class SignalingReconnectController {
  SignalingReconnectController({
    required SignalingModule signalingModule,
    void Function(SignalingFailureInfo)? onConnectionFailed,
    void Function(bool isAvailable)? onConnectionPresenceChanged,
    int notifyAfterConsecutiveFailures = 2,
    bool reconnectEnabled = true,
  }) : assert(notifyAfterConsecutiveFailures >= 1, 'notifyAfterConsecutiveFailures must be >= 1'),
       _module = signalingModule,
       _onConnectionFailed = onConnectionFailed,
       _onConnectionPresenceChanged = onConnectionPresenceChanged,
       _notifyThreshold = notifyAfterConsecutiveFailures,
       _reconnectEnabled = reconnectEnabled {
    _subscription = _module.events.listen(_onEvent);
  }

  final SignalingModule _module;
  final void Function(SignalingFailureInfo)? _onConnectionFailed;
  final void Function(bool isAvailable)? _onConnectionPresenceChanged;
  final int _notifyThreshold;
  final bool _reconnectEnabled;

  late final StreamSubscription<SignalingModuleEvent> _subscription;

  /// Tracks whether a connection was successfully established in the current session.
  /// Used to distinguish transient connect failures from established-connection drops.
  bool _wasConnected = false;
  Timer? _reconnectTimer;

  int _consecutiveFailures = 0;
  bool _appActive = true;
  bool _networkActive = true;
  bool _hasActiveCalls = false;
  bool _disposed = false;

  /// Last value passed to [_onConnectionPresenceChanged].
  /// Starts as `true` (assumed available) to avoid a spurious "available"
  /// callback on the first [SignalingConnected] event.
  bool _lastPresence = true;

  // ---------------------------------------------------------------------------
  // External lifecycle / connectivity notifications
  // ---------------------------------------------------------------------------

  /// Call when [AppLifecycleState.resumed] fires.
  void notifyAppResumed() {
    _logger.fine('notifyAppResumed');
    _appActive = true;
    _scheduleReconnect(kSignalingClientFastReconnectDelay);
  }

  /// Call when [AppLifecycleState.paused] or [AppLifecycleState.detached] fires.
  ///
  /// Disconnects immediately when there are no active calls.
  /// When [hasActiveCalls] is true the signaling connection is kept alive so
  /// the ongoing call is not interrupted, and reconnects remain enabled so
  /// a dropped connection during a call can recover.
  void notifyAppPaused({required bool hasActiveCalls}) {
    _logger.fine('notifyAppPaused hasActiveCalls=$hasActiveCalls');
    if (!hasActiveCalls) {
      _appActive = false;
      _disconnect();
    }
  }

  /// Call when the app needs an immediate reconnect regardless of lifecycle
  /// state - e.g. when a new active call appears while the app is in the
  /// background and the signaling client is not connected.
  ///
  /// Uses [Duration.zero] so the reconnect fires in the next event-loop tick.
  /// Callers (outgoing call start, incoming call answer from push) need the
  /// WebSocket ready as fast as possible; any delay here directly adds latency
  /// before the SDP offer reaches the server.
  ///
  /// Spurious "connection failed" toasts on transient failures are suppressed
  /// by the consecutive-failure threshold, not by this delay, so reducing the
  /// delay here is safe.
  void notifyForceReconnect() {
    _logger.fine('notifyForceReconnect');
    _scheduleReconnect(Duration.zero, force: true);
  }

  /// Call when active-call presence changes while the app may be in the
  /// background.
  ///
  /// When [hasActiveCalls] is true the app-active guard is bypassed so that
  /// reconnects triggered by [SignalingConnectionFailed] or an unexpected
  /// [SignalingDisconnected] can still fire during a background call.
  /// When [hasActiveCalls] is false and the app is not active, disconnects
  /// immediately - the call ended while backgrounded so signaling is no
  /// longer needed.
  void notifyHasActiveCalls({required bool hasActiveCalls}) {
    _logger.fine('notifyHasActiveCalls hasActiveCalls=$hasActiveCalls');
    _hasActiveCalls = hasActiveCalls;
    if (!hasActiveCalls && !_appActive) {
      _disconnect();
    }
  }

  /// Call when network becomes available ([ConnectivityResult] != none).
  void notifyNetworkAvailable() {
    _logger.fine('notifyNetworkAvailable');
    _networkActive = true;
    _scheduleReconnect(kSignalingClientFastReconnectDelay);
  }

  /// Call when network is lost ([ConnectivityResult.none]).
  void notifyNetworkUnavailable() {
    _logger.fine('notifyNetworkUnavailable');
    _networkActive = false;
    _disconnect();
    _emitPresence(false);
  }

  // ---------------------------------------------------------------------------
  // SignalingModule event handler
  // ---------------------------------------------------------------------------

  void _onEvent(SignalingModuleEvent event) {
    switch (event) {
      case SignalingConnected():
        _logger.fine('_onEvent: connected - resetting failure counter');
        _wasConnected = true;
        _consecutiveFailures = 0;
        _reconnectTimer?.cancel();
        _emitPresence(true);

      // Covers two scenarios:
      // 1. Initial connect attempt failed before a session was established -
      //    may be transient, notify only after [_notifyThreshold] consecutive failures.
      // 2. An error fired on an already-established WebSocket connection -
      //    always notify immediately because the user-visible session was lost.
      case SignalingConnectionFailed(:final recommendedReconnectDelay):
        if (_wasConnected) {
          _logger.fine('_onEvent: connection lost after established session - notifying immediately');
          _wasConnected = false;
          _consecutiveFailures = 0;
          _onConnectionFailed?.call((knownCode: null, systemCode: null, systemReason: null));
          _emitPresence(false);
        } else {
          _consecutiveFailures++;
          _logger.fine('_onEvent: connection failed (consecutive=$_consecutiveFailures)');
          if (_consecutiveFailures == _notifyThreshold) {
            _logger.info('_onEvent: notifying - consecutive failures reached threshold ($_notifyThreshold)');
            _onConnectionFailed?.call((knownCode: null, systemCode: null, systemReason: null));
            _emitPresence(false);
          }
        }
        _scheduleReconnect(recommendedReconnectDelay);

      // Unexpected TCP-level close without a preceding error event.
      // Notify immediately - an established session was lost.
      case SignalingDisconnected(:final recommendedReconnectDelay, :final knownCode, :final code, :final reason)
          when recommendedReconnectDelay != null:
        _logger.fine('_onEvent: unexpected disconnect - notifying immediately');
        _wasConnected = false;
        _consecutiveFailures = 0;
        _onConnectionFailed?.call((knownCode: knownCode, systemCode: code, systemReason: reason));
        _emitPresence(false);
        _scheduleReconnect(recommendedReconnectDelay);

      // Intentional disconnect (recommendedReconnectDelay == null) - no action.
      case SignalingDisconnected():
        break;

      default:
        break;
    }
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  void _scheduleReconnect(Duration delay, {bool force = false}) {
    if (!_reconnectEnabled) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      if (_disposed) return;
      _logger.info(
        '_scheduleReconnect timer fired after $delay - '
        'appActive=$_appActive networkActive=$_networkActive '
        'force=$force connected=${_module.isConnected}',
      );

      if (!force && !_appActive && !_hasActiveCalls) {
        _logger.info('_scheduleReconnect: skipped - app not active and no active calls');
        return;
      }
      if (!force && !_networkActive) {
        _logger.info('_scheduleReconnect: skipped - network unavailable');
        return;
      }
      if (!force && _module.isConnected) {
        _logger.info('_scheduleReconnect: skipped - already connected');
        return;
      }

      _module.connect();
    });
  }

  void _disconnect() {
    _reconnectTimer?.cancel();
    _consecutiveFailures = 0;
    _module.disconnect().ignore();
  }

  void _emitPresence(bool isAvailable) {
    if (_lastPresence == isAvailable) return;
    _lastPresence = isAvailable;
    _logger.info('_emitPresence: connection presence changed -> isAvailable=$isAvailable');
    _onConnectionPresenceChanged?.call(isAvailable);
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  void dispose() {
    _disposed = true;
    _reconnectTimer?.cancel();
    _subscription.cancel().ignore();
  }
}
