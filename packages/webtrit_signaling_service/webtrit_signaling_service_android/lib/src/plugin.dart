import 'dart:async';
import 'dart:convert';

import 'dart:ui' show IsolateNameServer, PluginUtilities;
import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'hub/signaling_hub_client.dart';
import 'hub/signaling_hub_module.dart';
import 'isolate/entry_point.dart' show signalingServiceCallbackDispatcher;
import 'messages.g.dart';
import 'mode_mapping.dart';

final _logger = Logger('WebtritSignalingServiceAndroid');

/// Android implementation of [SignalingServicePlatform].
///
/// Both modes run the WebSocket inside an Android foreground service
/// (background isolate + [SignalingHub]). The only difference is the
/// service lifecycle controlled by Kotlin:
///
/// **pushBound** -- [SignalingForegroundService.onTaskRemoved] calls stopSelf().
/// The service dies when the user closes the app. The server detects the
/// disconnect and sends an FCM push for the next incoming call. The
/// push-notification isolate calls [start] to bring the service back up;
/// the main isolate calls [attach] when the Activity opens.
///
/// **persistent** -- onTaskRemoved does NOT stop the service. The WebSocket
/// stays alive indefinitely. Incoming calls arrive directly via the running
/// WebSocket; no FCM push is required. The service is restarted by
/// [SignalingBootReceiver] after device reboot.
///
/// In both modes the WebSocket lives exclusively in the foreground-service
/// background isolate. Push and main isolates only connect to the hub via
/// [IsolateNameServer] -- they never open their own WebSocket.
///
/// Lifecycle:
///   1. [start] -- initialises the foreground service + hub init loop.
///   2. [attach] -- connects to an already-running hub without starting a
///      new service (used by the main isolate when the Activity opens).
///   3. [updateMode] -- switches lifecycle mode without restarting the
///      WebSocket connection.
///   4. [dispose] -- tears down Dart-side resources. The Android service
///      lifecycle is managed by Kotlin:
///        - pushBound: onTaskRemoved -> stopSelf()
///        - persistent: service keeps running; BootReceiver restarts after reboot.
class WebtritSignalingServiceAndroid extends SignalingServicePlatform {
  WebtritSignalingServiceAndroid._();

  static WebtritSignalingServiceAndroid? _instance;

  /// Registers this class as the default [SignalingServicePlatform] instance.
  static void registerWith() {
    _instance ??= WebtritSignalingServiceAndroid._();
    SignalingServicePlatform.instance = _instance!;
  }

  final _hostApi = PSignalingServiceHostApi();

  // ---------------------------------------------------------------------------
  // Hub mode (persistent) state
  // ---------------------------------------------------------------------------

  SignalingHubModule? _hubModule;
  StreamSubscription<SignalingModuleEvent>? _hubModuleSub;

  // Hub init background loop state.
  // Incremented on every teardown or new init to invalidate in-progress loops.
  int _hubInitGeneration = 0;
  Future<void>? _hubInitTask;

  // ---------------------------------------------------------------------------
  // Shared state
  // ---------------------------------------------------------------------------

  StreamController<SignalingModuleEvent> _eventsController = StreamController<SignalingModuleEvent>.broadcast();

  final _eventBuffer = SignalingEventBuffer();

  /// Last config passed to [start] -- reused when switching modes via [updateMode].
  SignalingServiceConfig? _currentConfig;

  /// Last mode explicitly set via [start] or [updateMode].
  ///
  /// When [start] is called for reconnection with the initial mode (e.g.
  /// [SignalingServiceMode.pushBound]), this field ensures the most recently
  /// chosen mode is used instead of reverting to the stale parameter.
  SignalingServiceMode? _currentMode;

  // ---------------------------------------------------------------------------
  // SignalingServicePlatform -- events
  // ---------------------------------------------------------------------------

  @override
  Stream<SignalingModuleEvent> get events {
    return Stream.multi((sink) {
      final sub = _eventsController.stream.listen(sink.add, onError: sink.addError, onDone: sink.close);
      sink.onCancel = sub.cancel;
      for (final event in _eventBuffer.snapshot) {
        sink.add(event);
      }
    }, isBroadcast: true);
  }

  // ---------------------------------------------------------------------------
  // SignalingServicePlatform -- start / attach / execute / updateMode / dispose
  // ---------------------------------------------------------------------------

  @override
  Future<void> start(
    SignalingServiceConfig config, {
    SignalingServiceMode mode = SignalingServiceMode.persistent,
  }) async {
    _currentConfig = config;
    // Use the mode from the last explicit start/updateMode call so that
    // reconnect calls (which always pass the initial mode) do not revert
    // a user-selected mode change.
    _currentMode ??= mode;
    final effectiveMode = _currentMode!;

    _logger.info('start effectiveMode=$effectiveMode tenantId=${config.tenantId}');

    if (_eventsController.isClosed) {
      _eventsController = StreamController<SignalingModuleEvent>.broadcast();
    }

    await _startHubMode(config, effectiveMode);
  }

  @override
  Future<void> attach() async {
    _logger.info('attach');
    _beginHubInit();
  }

  @override
  Future<void> execute(Request request) async {
    final hub = _hubModule;
    if (hub != null && hub.isConnected) {
      _logger.fine('execute ${request.runtimeType}');
      await hub.execute(request)!;
      return;
    }
    _logger.warning('execute called but not connected (${request.runtimeType})');
    throw StateError('SignalingServiceAndroid: not connected');
  }

  /// Switches the service lifecycle mode.
  ///
  /// Updates the Kotlin-side lifecycle behaviour (whether [onTaskRemoved]
  /// stops the service) by restarting the foreground service with the new
  /// mode. The WebSocket connection in the background isolate is preserved
  /// across the mode switch because the service is not stopped -- only the
  /// mode flag stored by [StorageDelegate] changes.
  @override
  Future<void> updateMode(SignalingServiceMode mode) async {
    _logger.info('updateMode $mode');
    _currentMode = mode;
    final config = _currentConfig;
    if (config == null) {
      _logger.warning('updateMode called before start -- no config available, skipping');
      return;
    }

    _eventBuffer.clear();
    await _startHubMode(config, mode);
  }

  @override
  Future<void> dispose() async {
    _logger.info('dispose');
    _hubInitGeneration++;
    await _hubInitTask;

    await _tearDownHubMode();

    // NOTE: stopService() is intentionally NOT called here.
    // The Android service lifecycle is managed by the Kotlin side:
    //   - pushBound: onTaskRemoved -> stopSelf()
    //   - persistent: service keeps running until the next explicit stop
    // Calling stopService() here would kill the persistent service when the
    // widget tree is torn down (e.g. swipe from recents), which defeats the
    // purpose of persistent mode.
    _currentMode = null;
    _eventBuffer.clear();
    // NOTE: _eventsController is intentionally NOT closed here.
    // Closing it would deliver onDone to any active subscriber (e.g. CallBloc),
    // silently ending their subscription. The next start() call would create a
    // fresh controller, but old subscribers would never reattach.
    // Leaving it open means existing subscriptions survive the dispose/start cycle.
    _logger.info('dispose complete');
  }

  @override
  Future<void> setIncomingCallHandler(Function callback) async {
    final handle = PluginUtilities.getCallbackHandle(callback);
    if (handle == null) {
      _logger.warning(
        'setIncomingCallHandler: could not obtain callback handle -- '
        'ensure the function is top-level and annotated with @pragma(\'vm:entry-point\')',
      );
      return;
    }
    await _hostApi.saveIncomingCallHandler(handle.toRawHandle());
  }

  @override
  Future<void> setModuleFactory(SignalingModuleFactory factory) async {
    final handle = PluginUtilities.getCallbackHandle(factory);
    if (handle == null) {
      _logger.warning(
        'setModuleFactory: could not obtain callback handle -- '
        'ensure the function is top-level and annotated with @pragma(\'vm:entry-point\')',
      );
      return;
    }
    await _hostApi.saveModuleFactory(handle.toRawHandle());
  }

  /// Stops the foreground service and clears stored credentials.
  ///
  /// Call this on explicit user logout so the service does not keep
  /// reconnecting with stale tokens after the session ends.
  Future<void> stopService() async {
    await _hostApi.stopService();
  }

  // ---------------------------------------------------------------------------
  // Hub mode internals
  // ---------------------------------------------------------------------------

  Future<void> _startHubMode(SignalingServiceConfig config, SignalingServiceMode mode) async {
    _logger.fine('_startHubMode mode=$mode generation=$_hubInitGeneration');
    final dispatcherHandle = PluginUtilities.getCallbackHandle(signalingServiceCallbackDispatcher);
    if (dispatcherHandle == null) {
      throw StateError(
        'Could not obtain callback handle for signalingServiceCallbackDispatcher. '
        'Ensure it is annotated with @pragma(\'vm:entry-point\').',
      );
    }

    await _hostApi.initializeServiceCallback(
      dispatcherHandle.toRawHandle(),
      // onSync handle is not used directly by Kotlin -- the background isolate
      // calls onSignalingServiceSync via PSignalingServiceFlutterApi.setUp.
      // Pass 0 as a placeholder.
      0,
    );

    await _hostApi.saveConnectionConfig(config.coreUrl, config.tenantId, config.token);
    await _hostApi.saveTrustedCertificates(_encodeTrustedCertificates(config.trustedCertificates));
    await _hostApi.startService(signalingModeToNative(mode));

    // Do NOT clear the hub port here.
    //
    // SignalingHub.start() already removes the stale mapping before registering
    // its own port, so stale ports from crashed sessions are handled at the
    // source. Clearing here causes a different failure: when the foreground
    // service is already running (persistent mode), its background isolate's
    // _started guard prevents _hub.start() from being called again, so the
    // port would never be re-registered after being cleared -- _hubInitLoop
    // would poll forever and the signaling status would be stuck on
    // "connecting". If a stale port does reach _hubInitLoop, the 500 ms ack
    // timeout causes a safe retry without blocking the happy path.
    _beginHubInit();
  }

  Future<void> _tearDownHubMode() async {
    _logger.fine('_tearDownHubMode generation=$_hubInitGeneration');
    _hubInitGeneration++;
    await _hubInitTask;
    _hubInitTask = null;

    await _hubModuleSub?.cancel();
    _hubModuleSub = null;
    await _hubModule?.dispose();
    _hubModule = null;
    _logger.fine('_tearDownHubMode complete');
  }

  // ---------------------------------------------------------------------------
  // Hub module init
  // ---------------------------------------------------------------------------

  /// Starts the hub-init background loop if it is not already running and
  /// no hub module is wired up yet.
  ///
  /// Increments [_hubInitGeneration] so any concurrent in-progress loop exits
  /// on its next iteration check, preventing two concurrent loops.
  ///
  /// When an in-progress loop exits due to a generation mismatch (caused by a
  /// concurrent [_beginHubInit] call), the [whenComplete] callback restarts the
  /// loop so polling continues with the latest generation instead of stopping.
  void _beginHubInit() {
    if (_hubModule != null) return;
    _hubInitGeneration++;
    final generation = _hubInitGeneration;
    _logger.fine('_beginHubInit generation=$generation taskRunning=${_hubInitTask != null}');
    _hubInitTask ??= _hubInitLoop(generation).whenComplete(() {
      _hubInitTask = null;
      if (_hubModule == null && !_eventsController.isClosed) {
        _logger.fine('_beginHubInit restarting loop after gen-mismatch exit (gen=$_hubInitGeneration)');
        _beginHubInit();
      }
    });
  }

  /// Polls [IsolateNameServer] indefinitely until the hub port is registered,
  /// then wires up [SignalingHubModule] and forwards its events to
  /// [_eventsController].
  ///
  /// The loop exits when [_hubInitGeneration] no longer matches [generation]
  /// (i.e. a newer [_beginHubInit] or [_tearDownHubMode] was called) or the
  /// events controller is closed.
  Future<void> _hubInitLoop(int generation) async {
    const retryDelay = Duration(milliseconds: 100);
    const ackTimeout = Duration(milliseconds: 500);

    _logger.fine('_hubInitLoop started gen=$generation');
    var attempts = 0;

    while (true) {
      if (_hubInitGeneration != generation || _eventsController.isClosed) {
        _logger.fine(
          '_hubInitLoop gen=$generation exiting (currentGen=$_hubInitGeneration closed=${_eventsController.isClosed}) after $attempts attempts',
        );
        return;
      }

      final client = SignalingHubClient.tryConnect('android_plugin_$hashCode');
      if (client != null) {
        _logger.fine('_hubInitLoop gen=$generation hub port found after $attempts attempts, awaiting ack');
        // awaitAck MUST be called before start() so the internal Completer
        // is in place before the hub's sub-ack can arrive.
        final ackFuture = client.awaitAck(timeout: ackTimeout);
        final module = SignalingHubModule(client); // subscribes, then calls client.start()
        final ackReceived = await ackFuture;

        if (ackReceived) {
          if (_hubInitGeneration != generation || _eventsController.isClosed) {
            _logger.fine('_hubInitLoop gen=$generation ack received but generation changed, disposing stale module');
            await module.dispose();
            return;
          }
          _hubModule = module;
          _logger.info('_hubInitLoop gen=$generation hub connected (consumerId=${client.consumerId})');
          _hubModuleSub = _hubModule!.events.listen(
            (event) {
              _eventBuffer.onEvent(event);
              if (!_eventsController.isClosed) _eventsController.add(event);
            },
            onError: (Object e, StackTrace st) {
              if (!_eventsController.isClosed) _eventsController.addError(e, st);
            },
          );
          return;
        }

        _logger.fine('_hubInitLoop gen=$generation ack timeout -- stale port, retrying');
        await module.dispose();
      }

      attempts++;
      await Future<void>.delayed(retryDelay);
    }
  }
}

// ---------------------------------------------------------------------------
// Trusted certificates serialization
// ---------------------------------------------------------------------------

/// Encodes [TrustedCertificates] to a JSON string for cross-isolate transport.
///
/// Returns null when [certs] is empty (background isolate uses system trust store).
String? _encodeTrustedCertificates(TrustedCertificates certs) {
  if (!certs.hasAvailableCertificates) return null;
  return jsonEncode(
    certs.certificates
        .map((c) => <String, dynamic>{'bytes': c.bytes, if (c.password != null) 'password': c.password})
        .toList(),
  );
}
