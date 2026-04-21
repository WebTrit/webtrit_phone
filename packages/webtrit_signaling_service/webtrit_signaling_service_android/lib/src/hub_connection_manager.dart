import 'dart:async';
import 'dart:ui' show IsolateNameServer;

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'constants.dart';
import 'hub/signaling_hub_client.dart';
import 'hub/signaling_hub_module.dart';

final _logger = Logger('HubConnectionManager');

/// Manages the lifecycle of a [SignalingHubModule] connection.
///
/// Polls [IsolateNameServer] for the hub port, wires up a [SignalingHubModule]
/// when the port becomes available, and tears it down on demand.
///
/// Generation-based cancellation prevents stale polling loops from completing
/// after a concurrent [begin] or [tearDown] call.
///
/// TODO(hub-discovery): Replace polling with a push-based discovery mechanism.
/// Current approach polls [IsolateNameServer] every 100 ms because the background
/// isolate starts asynchronously and there is no signal for when it is ready.
/// A cleaner alternative: pass a [SendPort] from the main isolate to the
/// background isolate at startup (via Pigeon or [RootIsolateToken]), so the
/// background isolate notifies the main isolate directly when the hub is ready.
/// This eliminates the polling delay and the 500 ms ack timeout, but requires
/// changes to the Kotlin bootstrap flow in [FlutterEngineHelper].
class HubConnectionManager {
  HubConnectionManager({
    required void Function(SignalingModuleEvent) onEvent,
    required void Function(Object, StackTrace) onError,
    required bool Function() isActive,
    required String consumerId,
    this.pingInterval = const Duration(seconds: 15),
    this.pongTimeout = const Duration(seconds: 2),
    this.stalePortThreshold = 3,
    this.noPortTimeout = const Duration(seconds: 8),
    this.onServiceDead,
  }) : _onEvent = onEvent,
       _onError = onError,
       _isActive = isActive,
       _consumerId = consumerId;

  final void Function(SignalingModuleEvent) _onEvent;
  final void Function(Object, StackTrace) _onError;
  final bool Function() _isActive;
  final String _consumerId;

  /// How often the hub liveness ping is sent.
  final Duration pingInterval;

  /// How long to wait for a pong before treating the hub as dead.
  final Duration pongTimeout;

  /// Number of consecutive stale ack timeouts before the hub service is
  /// declared dead: the stale port is removed from [IsolateNameServer], a
  /// [SignalingConnectionFailed] event is emitted, and [onServiceDead] is
  /// called so the caller can restart the foreground service.
  final int stalePortThreshold;

  /// How long [_initLoop] waits for a hub port to appear before treating the
  /// service as dead. When no port is found for this duration, a
  /// [SignalingConnectionFailed] event is emitted and [onServiceDead] is
  /// called so the caller can attempt to restart the foreground service.
  final Duration noPortTimeout;

  /// Called when [stalePortThreshold] consecutive ack timeouts indicate the
  /// hub service is no longer running. Use this to restart the foreground
  /// service so the hub is re-registered.
  final void Function()? onServiceDead;

  SignalingHubModule? _module;
  StreamSubscription<SignalingModuleEvent>? _moduleSub;
  int _generation = 0;
  Future<void>? _initTask;

  // Set by tearDown() to prevent the whenComplete restart from calling begin()
  // while teardown is in progress. Reset by begin() so the cycle can restart.
  bool _tearingDown = false;

  bool get isConnected => _module?.isConnected ?? false;

  Future<void>? execute(Request request) => _module?.execute(request);

  /// Starts or restarts the hub-init polling loop.
  ///
  /// No-op if a module is already wired up. Increments the generation so
  /// any concurrent in-progress loop exits on its next iteration.
  void begin() {
    if (_module != null) return;
    _tearingDown = false;
    _generation++;
    final generation = _generation;
    _logger.fine('begin generation=$generation taskRunning=${_initTask != null}');
    _initTask ??= _initLoop(generation).whenComplete(() {
      _initTask = null;
      if (!_tearingDown && _module == null && _isActive()) {
        _logger.fine('begin restarting loop after gen-mismatch exit (gen=$_generation)');
        begin();
      }
    });
  }

  /// Cancels any in-progress init loop and tears down the current module.
  ///
  /// Sets [_tearingDown] before bumping the generation so the [whenComplete]
  /// restart guard in [begin] sees the flag and does not start a new polling
  /// loop while teardown is still running.
  Future<void> tearDown() async {
    _logger.fine('tearDown generation=$_generation');
    _tearingDown = true;
    _generation++;
    await _initTask;
    _initTask = null;

    await _moduleSub?.cancel();
    _moduleSub = null;
    await _module?.dispose();
    _module = null;
    _logger.fine('tearDown complete');
  }

  Future<void> _initLoop(int generation) async {
    const retryDelay = Duration(milliseconds: 100);
    const ackTimeout = Duration(milliseconds: 500);
    // Clamp to 1 so a noPortTimeout shorter than retryDelay (e.g. in tests)
    // never fires the watchdog on the very first poll before any waiting occurs.
    final noPortDeadThreshold = (noPortTimeout.inMilliseconds ~/ retryDelay.inMilliseconds).clamp(1, 1 << 31);

    _logger.fine('_initLoop started gen=$generation');
    var attempts = 0;
    var consecutiveStaleAcks = 0;
    var emptyPortPolls = 0;

    while (true) {
      if (_generation != generation || !_isActive()) {
        _logger.fine(
          '_initLoop gen=$generation exiting (currentGen=$_generation active=${_isActive()}) after $attempts attempts',
        );
        return;
      }

      final client = SignalingHubClient.tryConnect(_consumerId, pingInterval: pingInterval, pongTimeout: pongTimeout);
      if (client != null) {
        emptyPortPolls = 0;
        _logger.fine('_initLoop gen=$generation hub port found after $attempts attempts, awaiting ack');
        // awaitAck MUST be called before SignalingHubModule is constructed so the
        // internal Completer is in place before the hub's sub-ack can arrive.
        final ackFuture = client.awaitAck(timeout: ackTimeout);
        final module = SignalingHubModule(client);
        final ackReceived = await ackFuture;

        if (ackReceived) {
          consecutiveStaleAcks = 0;
          if (_generation != generation || !_isActive()) {
            _logger.fine('_initLoop gen=$generation ack received but generation changed, disposing stale module');
            await module.dispose();
            return;
          }
          _module = module;
          _logger.info('_initLoop gen=$generation hub connected (consumerId=${client.consumerId})');
          _moduleSub = _module!.events.listen(
            _onEvent,
            onError: _onError,
            onDone: () {
              if (_tearingDown) return;
              _logger.warning('HubConnectionManager: hub module stream closed — hub died, restarting discovery');
              _module = null;
              _moduleSub = null;
              if (_isActive()) begin();
            },
          );
          return;
        }

        consecutiveStaleAcks++;
        _logger.fine(
          '_initLoop gen=$generation ack timeout -- stale port ($consecutiveStaleAcks/$stalePortThreshold), retrying',
        );
        await module.dispose();

        if (consecutiveStaleAcks >= stalePortThreshold) {
          consecutiveStaleAcks = 0;
          if (_generation != generation || !_isActive() || _tearingDown) return;
          _logger.warning(
            '_initLoop gen=$generation stale port threshold reached -- hub service presumed dead, clearing port',
          );
          IsolateNameServer.removePortNameMapping(kSignalingHubPortName);
          _onEvent(
            SignalingConnectionFailed(
              error: StateError('Signaling hub service died'),
              isRepeated: false,
              recommendedReconnectDelay: kSignalingClientReconnectDelay,
            ),
          );
          onServiceDead?.call();
        }
      } else {
        consecutiveStaleAcks = 0;
        // No-port watchdog: hub port absent for noPortTimeout → FGS likely failed
        // to start or was killed before registering. Emit a failure event so
        // SignalingReconnectController can schedule a reconnect, then call
        // onServiceDead to trigger a FGS restart attempt.
        // Return immediately after onServiceDead — it increments the generation
        // so the generation guard at the top of begin() stops this loop cleanly,
        // preventing repeated watchdog firing before the new loop takes over.
        emptyPortPolls++;
        if (emptyPortPolls >= noPortDeadThreshold) {
          emptyPortPolls = 0;
          if (_generation != generation || !_isActive() || _tearingDown) return;
          _logger.warning(
            '_initLoop gen=$generation no hub port for ${noPortTimeout.inSeconds}s — service likely dead, triggering recovery',
          );
          _onEvent(
            SignalingConnectionFailed(
              error: StateError('Signaling hub service not found'),
              isRepeated: false,
              recommendedReconnectDelay: kSignalingClientReconnectDelay,
            ),
          );
          onServiceDead?.call();
          return;
        }
      }

      attempts++;
      await Future<void>.delayed(retryDelay);
    }
  }
}
