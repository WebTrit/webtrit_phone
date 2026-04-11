import 'dart:async';
import 'dart:convert';

import 'dart:ui' show PluginUtilities;
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart' show BinaryMessenger;
import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'constants.dart';
import 'hub/signaling_hub_client.dart';
import 'hub/signaling_hub_module.dart';
import 'hub_connection_manager.dart';
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
  WebtritSignalingServiceAndroid._({BinaryMessenger? binaryMessenger})
    : _hostApi = PSignalingServiceHostApi(binaryMessenger: binaryMessenger);

  @visibleForTesting
  WebtritSignalingServiceAndroid.forTesting({BinaryMessenger? binaryMessenger})
    : _hostApi = PSignalingServiceHostApi(binaryMessenger: binaryMessenger);

  static WebtritSignalingServiceAndroid? _instance;

  /// Registers this class as the default [SignalingServicePlatform] instance.
  static void registerWith() {
    _instance ??= WebtritSignalingServiceAndroid._();
    SignalingServicePlatform.instance = _instance!;
  }

  final PSignalingServiceHostApi _hostApi;

  StreamController<SignalingModuleEvent> _eventsController = StreamController<SignalingModuleEvent>.broadcast();

  final _eventBuffer = SignalingEventBuffer();

  late final _hubManager = HubConnectionManager(
    consumerId: 'android_plugin_$hashCode',
    onEvent: (event) {
      _eventBuffer.onEvent(event);
      if (!_eventsController.isClosed) _eventsController.add(event);
    },
    onError: (e, st) {
      if (!_eventsController.isClosed) _eventsController.addError(e, st);
    },
    isActive: () => !_eventsController.isClosed,
  );

  /// Last config passed to [start] -- reused when switching modes via [updateMode].
  SignalingServiceConfig? _currentConfig;

  /// Last mode explicitly set via [start] or [updateMode].
  ///
  /// When [start] is called for reconnection with the initial mode (e.g.
  /// [SignalingServiceMode.pushBound]), this field ensures the most recently
  /// chosen mode is used instead of reverting to the stale parameter.
  SignalingServiceMode? _currentMode;

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

    await _startService(config, effectiveMode);
  }

  @override
  Future<void> attach() async {
    _logger.info('attach');
    _hubManager.begin();
  }

  @override
  Future<void> execute(Request request) async {
    if (_hubManager.isConnected) {
      _logger.fine('execute ${request.runtimeType}');
      await _hubManager.execute(request)!;
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
    await _startService(config, mode);
  }

  @override
  Future<void> dispose() async {
    _logger.info('dispose');
    await _hubManager.tearDown();

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

  @override
  Future<void> stopService() async {
    _logger.info('stopService');
    await _hostApi.stopService();
  }

  @override
  Future<void> restoreService() async {
    _logger.info('restoreService');
    await _hostApi.connect();
  }

  /// Returns a [SignalingModule] for the push notification isolate.
  ///
  /// Lifecycle for the push notification isolate:
  ///
  /// 1. **Hub already running** (persistent mode, or previous push started it):
  ///    returns a [SignalingHubModule] that routes through the existing
  ///    WebSocket — no new connection is opened.
  ///
  /// 2. **Hub not running** (app was killed, pushBound mode, first push):
  ///    starts the FGS via [_startFgsOnly] (pushBound), then polls
  ///    [IsolateNameServer] until the hub registers and acknowledges the
  ///    subscription. Returns a [SignalingHubModule] once the hub is ready.
  ///    This preserves the 1-WebSocket invariant: push isolate and Activity
  ///    both share the same FGS connection.
  ///
  /// 3. **Emergency fallback**: if the hub does not become available within
  ///    [_kPushHubWaitTimeout], falls back to a direct [SignalingModuleImpl]
  ///    so the incoming call is not silently dropped.
  @override
  Future<SignalingModule> createPushIsolateModule(SignalingServiceConfig config, String consumerId) async {
    // --- fast path: hub already running ---
    final existing = await _tryConnectHub(consumerId);
    if (existing != null) {
      _logger.info('createPushIsolateModule: hub available, reusing existing WebSocket (consumerId=$consumerId)');
      return existing;
    }

    // --- hub not running: start FGS and wait for hub ---
    _logger.info('createPushIsolateModule: no hub active, starting FGS and waiting for hub (consumerId=$consumerId)');
    await _startFgsOnly(config, SignalingServiceMode.pushBound);

    final deadline = DateTime.now().add(_kPushHubWaitTimeout);
    while (DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(_kPushHubPollInterval);
      final module = await _tryConnectHub(consumerId);
      if (module != null) {
        _logger.info('createPushIsolateModule: hub ready after FGS start (consumerId=$consumerId)');
        return module;
      }
    }

    // --- emergency fallback ---
    _logger.warning(
      'createPushIsolateModule: hub not available after ${_kPushHubWaitTimeout.inSeconds}s, '
      'falling back to direct SignalingModuleImpl (consumerId=$consumerId)',
    );
    return SignalingModuleImpl(
      coreUrl: config.coreUrl,
      tenantId: config.tenantId,
      token: config.token,
      trustedCertificates: config.trustedCertificates,
      connectionTimeout: kSignalingClientConnectionTimeout,
      reconnectDelay: kSignalingClientReconnectDelay,
    );
  }

  /// Tries to subscribe to the hub and returns a [SignalingHubModule] if the
  /// hub acknowledges within the ack timeout. Returns null if no hub port is
  /// registered or the ack times out (stale port).
  Future<SignalingModule?> _tryConnectHub(String consumerId) async {
    final client = SignalingHubClient.tryConnect(consumerId);
    if (client == null) return null;
    // awaitAck MUST be called before SignalingHubModule is constructed so the
    // internal Completer is in place before the hub's sub-ack can arrive.
    final ackFuture = client.awaitAck();
    final module = SignalingHubModule(client);
    final ackReceived = await ackFuture;
    if (!ackReceived) {
      _logger.fine('_tryConnectHub: ack timeout for consumerId=$consumerId, disposing stale module');
      await module.dispose();
      return null;
    }
    // Yield to the event loop so the hub's replay events (including
    // SignalingConnected) are delivered to SignalingHubModule._onHubEvent
    // before this method returns. The hub sends replay events immediately
    // after the subscription ack; without this yield module.isConnected
    // can still be false when the caller checks it, causing an unintended
    // connect() call that forwards to the FGS WebSocket.
    await Future<void>.delayed(Duration.zero);
    return module;
  }

  /// Persists credentials and requests a native FGS start without wiring up
  /// [HubConnectionManager]. Used by [createPushIsolateModule] so the push
  /// isolate controls its own hub-discovery loop.
  Future<void> _startFgsOnly(SignalingServiceConfig config, SignalingServiceMode mode) async {
    _logger.fine('_startFgsOnly mode=$mode');
    final dispatcherHandle = PluginUtilities.getCallbackHandle(signalingServiceCallbackDispatcher);
    if (dispatcherHandle == null) {
      throw StateError(
        'Could not obtain callback handle for signalingServiceCallbackDispatcher. '
        'Ensure it is annotated with @pragma(\'vm:entry-point\').',
      );
    }
    await Future.wait([
      _hostApi.initializeServiceCallback(dispatcherHandle.toRawHandle(), 0),
      _hostApi.saveConnectionConfig(config.coreUrl, config.tenantId, config.token),
      _hostApi.saveTrustedCertificates(_encodeTrustedCertificates(config.trustedCertificates)),
    ]);
    await _hostApi.startService(signalingModeToNative(mode));
    _logger.info('_startFgsOnly: FGS start requested mode=$mode');
  }

  // Maximum time to wait for the FGS hub to become available after [_startFgsOnly].
  // Based on observed startup times (~4 s on Xiaomi under load), 10 s provides
  // enough headroom without risking the push-notification processing window.
  static const _kPushHubWaitTimeout = Duration(seconds: 10);

  // Poll interval between hub-discovery attempts while waiting for the FGS to start.
  static const _kPushHubPollInterval = Duration(milliseconds: 200);

  Future<void> _startService(SignalingServiceConfig config, SignalingServiceMode mode) async {
    _logger.fine('_startService mode=$mode');
    final dispatcherHandle = PluginUtilities.getCallbackHandle(signalingServiceCallbackDispatcher);
    if (dispatcherHandle == null) {
      throw StateError(
        'Could not obtain callback handle for signalingServiceCallbackDispatcher. '
        'Ensure it is annotated with @pragma(\'vm:entry-point\').',
      );
    }

    // Persist all credentials concurrently — they write to independent
    // SharedPreferences keys and have no ordering dependency between them.
    // Running them in parallel removes two sequential Binder round-trips
    // (~200–600 ms under memory pressure) before startForegroundService()
    // is called.
    await Future.wait([
      _hostApi.initializeServiceCallback(
        dispatcherHandle.toRawHandle(),
        // onSync handle is not used directly by Kotlin -- the background isolate
        // calls onSignalingServiceSync via PSignalingServiceFlutterApi.setUp.
        // Pass 0 as a placeholder.
        0,
      ),
      _hostApi.saveConnectionConfig(config.coreUrl, config.tenantId, config.token),
      _hostApi.saveTrustedCertificates(_encodeTrustedCertificates(config.trustedCertificates)),
    ]);

    // Start the service only after all credentials are persisted so that
    // synchronizeIsolate() reads correct data on the first attempt.
    await _hostApi.startService(signalingModeToNative(mode));

    // Do NOT clear the hub port here.
    //
    // SignalingHub.start() already removes the stale mapping before registering
    // its own port, so stale ports from crashed sessions are handled at the
    // source. Clearing here causes a different failure: when the foreground
    // service is already running (persistent mode), its background isolate's
    // _started guard prevents _hub.start() from being called again, so the
    // port would never be re-registered after being cleared -- HubConnectionManager
    // would poll forever and the signaling status would be stuck on
    // "connecting". If a stale port does reach the init loop, the 500 ms ack
    // timeout causes a safe retry without blocking the happy path.
    _hubManager.begin();
  }
}

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
