import 'dart:async';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/constants.dart';

import 'signaling_module.dart';

final _logger = Logger('SignalingReconnectController');

/// Centralizes all signaling reconnect logic and connection-failure notification
/// decisions for both the foreground [CallBloc] and background [IsolateManager].
///
/// ## Responsibilities
///
/// - Schedules reconnect timers after [SignalingConnectionFailed],
///   [SignalingConnectionLost], and [SignalingDisconnected] events.
/// - Guards reconnects by [_appActive] and [_networkActive] flags.
/// - Tracks consecutive connect failures and calls [onConnectionFailed] only
///   after [notifyAfterConsecutiveFailures] attempts — suppressing spurious
///   toasts for transient failures (e.g. brief DNS unavailability on screen
///   unlock).
/// - Calls [onConnectionFailed] immediately on [SignalingConnectionLost]
///   because a previously established session was dropped, which is always
///   user-visible.
/// - Tracks persistent connection availability and calls
///   [onConnectionPresenceChanged] whenever the availability transitions
///   between available and unavailable — suitable for driving a persistent
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
///   onConnectionFailed: () => submitNotification(SignalingConnectFailedNotification()),
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
    required SignalingReconnectable signalingModule,
    void Function()? onConnectionFailed,
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

  final SignalingReconnectable _module;
  final void Function()? _onConnectionFailed;
  final void Function(bool isAvailable)? _onConnectionPresenceChanged;
  final int _notifyThreshold;
  final bool _reconnectEnabled;

  late final StreamSubscription<SignalingModuleEvent> _subscription;
  Timer? _reconnectTimer;

  int _consecutiveFailures = 0;
  bool _appActive = true;
  bool _networkActive = true;
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
  /// state — e.g. when a new active call appears while the app is in the
  /// background and the signaling client is not connected.
  void notifyForceReconnect() {
    _logger.fine('notifyForceReconnect');
    _scheduleReconnect(kSignalingClientFastReconnectDelay, force: true);
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
        _logger.fine('_onEvent: connected — resetting failure counter');
        _consecutiveFailures = 0;
        _reconnectTimer?.cancel();
        _emitPresence(true);

      // Initial connect attempt failed before any session was established.
      // May be transient (e.g. DNS not ready on screen unlock) — notify only
      // after [_notifyThreshold] consecutive failures.
      case SignalingConnectionFailed(:final recommendedReconnectDelay):
        _consecutiveFailures++;
        _logger.fine('_onEvent: connection failed (consecutive=$_consecutiveFailures)');
        if (_consecutiveFailures == _notifyThreshold) {
          _logger.info('_onEvent: notifying — consecutive failures reached threshold ($_notifyThreshold)');
          _onConnectionFailed?.call();
          _emitPresence(false);
        }
        _scheduleReconnect(recommendedReconnectDelay);

      // Established session was lost — always notify immediately and reset
      // the counter so the next reconnect loop starts fresh.
      case SignalingConnectionLost(:final recommendedReconnectDelay):
        _logger.fine('_onEvent: connection lost — notifying immediately');
        _consecutiveFailures = 0;
        _onConnectionFailed?.call();
        _emitPresence(false);
        _scheduleReconnect(recommendedReconnectDelay);

      case SignalingDisconnected(:final recommendedReconnectDelay):
        if (recommendedReconnectDelay != null) {
          _scheduleReconnect(recommendedReconnectDelay);
        }

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
        '_scheduleReconnect timer fired after $delay — '
        'appActive=$_appActive networkActive=$_networkActive '
        'force=$force connected=${_module.isConnected}',
      );

      if (!force && !_appActive) {
        _logger.info('_scheduleReconnect: skipped — app not active');
        return;
      }
      if (!force && !_networkActive) {
        _logger.info('_scheduleReconnect: skipped — network unavailable');
        return;
      }
      if (!force && _module.isConnected) {
        _logger.info('_scheduleReconnect: skipped — already connected');
        return;
      }

      _module.connect();
    });
  }

  void _disconnect() {
    _reconnectTimer?.cancel();
    _consecutiveFailures = 0;
    _module.disconnect();
  }

  void _emitPresence(bool isAvailable) {
    if (_lastPresence == isAvailable) return;
    _lastPresence = isAvailable;
    _logger.info('_emitPresence: connection presence changed → isAvailable=$isAvailable');
    _onConnectionPresenceChanged?.call(isAvailable);
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  void dispose() {
    _disposed = true;
    _reconnectTimer?.cancel();
    _subscription.cancel();
  }
}
