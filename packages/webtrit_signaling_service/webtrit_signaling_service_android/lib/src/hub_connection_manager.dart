import 'dart:async';

import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

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
  }) : _onEvent = onEvent,
       _onError = onError,
       _isActive = isActive,
       _consumerId = consumerId;

  final void Function(SignalingModuleEvent) _onEvent;
  final void Function(Object, StackTrace) _onError;
  final bool Function() _isActive;
  final String _consumerId;

  SignalingHubModule? _module;
  StreamSubscription<SignalingModuleEvent>? _moduleSub;
  int _generation = 0;
  Future<void>? _initTask;

  bool get isConnected => _module?.isConnected ?? false;

  Future<void>? execute(Request request) => _module?.execute(request);

  /// Starts or restarts the hub-init polling loop.
  ///
  /// No-op if a module is already wired up. Increments the generation so
  /// any concurrent in-progress loop exits on its next iteration.
  void begin() {
    if (_module != null) return;
    _generation++;
    final generation = _generation;
    _logger.fine('begin generation=$generation taskRunning=${_initTask != null}');
    _initTask ??= _initLoop(generation).whenComplete(() {
      _initTask = null;
      if (_module == null && _isActive()) {
        _logger.fine('begin restarting loop after gen-mismatch exit (gen=$_generation)');
        begin();
      }
    });
  }

  /// Cancels any in-progress init loop and tears down the current module.
  Future<void> tearDown() async {
    _logger.fine('tearDown generation=$_generation');
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

    _logger.fine('_initLoop started gen=$generation');
    var attempts = 0;

    while (true) {
      if (_generation != generation || !_isActive()) {
        _logger.fine(
          '_initLoop gen=$generation exiting (currentGen=$_generation active=${_isActive()}) after $attempts attempts',
        );
        return;
      }

      final client = SignalingHubClient.tryConnect(_consumerId);
      if (client != null) {
        _logger.fine('_initLoop gen=$generation hub port found after $attempts attempts, awaiting ack');
        // awaitAck MUST be called before SignalingHubModule is constructed so the
        // internal Completer is in place before the hub's sub-ack can arrive.
        final ackFuture = client.awaitAck(timeout: ackTimeout);
        final module = SignalingHubModule(client);
        final ackReceived = await ackFuture;

        if (ackReceived) {
          if (_generation != generation || !_isActive()) {
            _logger.fine('_initLoop gen=$generation ack received but generation changed, disposing stale module');
            await module.dispose();
            return;
          }
          _module = module;
          _logger.info('_initLoop gen=$generation hub connected (consumerId=${client.consumerId})');
          _moduleSub = _module!.events.listen(_onEvent, onError: _onError);
          return;
        }

        _logger.fine('_initLoop gen=$generation ack timeout -- stale port, retrying');
        await module.dispose();
      }

      attempts++;
      await Future<void>.delayed(retryDelay);
    }
  }
}
