import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'dart:ui' show IsolateNameServer, PluginUtilities;
import 'package:flutter/foundation.dart' show VoidCallback, visibleForTesting;
import 'package:flutter/services.dart' show BinaryMessenger;
import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'constants.dart';
import 'hub_connection_manager.dart';
import 'isolate/entry_point.dart' show signalingServiceCallbackDispatcher;
import 'messages.g.dart';
import 'mode_mapping.dart';

final _logger = Logger('WebtritSignalingServiceAndroid');

/// Android implementation of [SignalingServicePlatform].
///
/// **FGS mode (persistent only):**
/// The WebSocket runs inside an Android Foreground Service (background isolate
/// + [SignalingHub]). Push and main isolates connect to the hub via
/// [IsolateNameServer] — they never open their own WebSocket.
///
/// **pushBound (direct mode):**
/// Skips the FGS entirely. The WebSocket runs directly in the calling isolate,
/// identical to the iOS implementation.
///
/// Mode details:
/// - **pushBound** -- service dies when the user closes the app; FCM push starts
///   a fresh instance for the next call.
/// - **persistent** -- service survives app closure; restarted after device reboot.
///
/// Lifecycle:
///   1. [start] -- initialises the foreground service (FGS path) or direct
///      WebSocket (direct path) and begins hub/module init.
///   2. [attach] -- attaches to an already-running FGS hub (FGS path only).
///      No-op in direct mode.
///   3. [updateMode] -- switches lifecycle mode. Tears down the direct module
///      when switching away from direct pushBound.
///   4. [dispose] -- tears down all Dart-side resources.
class WebtritSignalingServiceAndroid extends SignalingServicePlatform {
  WebtritSignalingServiceAndroid._({BinaryMessenger? binaryMessenger})
    : _hostApi = PSignalingServiceHostApi(binaryMessenger: binaryMessenger);

  @visibleForTesting
  WebtritSignalingServiceAndroid.forTesting({BinaryMessenger? binaryMessenger})
    : _hostApi = PSignalingServiceHostApi(binaryMessenger: binaryMessenger);

  @visibleForTesting
  void initStateForTesting({required SignalingServiceConfig config, required SignalingServiceMode mode}) {
    _currentConfig = config;
    _currentMode = mode;
  }

  @visibleForTesting
  Future<void> triggerOnServiceDeadForTesting() => _onHubServiceDead();

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
    onServiceDead: () => unawaited(_onHubServiceDead()),
  );

  /// Last config passed to [start] -- reused when switching modes via [updateMode].
  SignalingServiceConfig? _currentConfig;

  /// Last mode explicitly set via [start] or [updateMode].
  ///
  /// When [start] is called for reconnection with the initial mode (e.g.
  /// [SignalingServiceMode.pushBound]), this field ensures the most recently
  /// chosen mode is used instead of reverting to the stale parameter.
  SignalingServiceMode? _currentMode;

  /// Factory stored for the direct-mode WebSocket path.
  /// Set in [setModuleFactory]; used in [_startDirect] for pushBound mode.
  SignalingModuleFactory? _factory;

  /// Active module for the direct-mode WebSocket path (non-null only in
  /// pushBound mode after [start] has been called).
  SignalingModule? _directModule;
  StreamSubscription<SignalingModuleEvent>? _directModuleSub;

  /// Callback set by the push isolate via [setHandoffCallback]. Its presence
  /// also signals to [_startDirect] that this instance runs in the push isolate,
  /// causing it to register [kPushHandoffPortName] in [IsolateNameServer].
  VoidCallback? _handoffCallback;

  /// [ReceivePort] registered under [kPushHandoffPortName] by the push isolate.
  /// Receives a null signal from the Activity when its WebSocket connects.
  ReceivePort? _handoffPort;

  /// Set to `true` by [stopService] and [dispose] to prevent [_onHubServiceDead]
  /// from restarting the foreground service after an intentional stop.
  ///
  /// Without this guard, stopping the FGS during logout causes the hub to lose
  /// its port in [IsolateNameServer], which triggers [_onHubServiceDead]. That
  /// callback calls [_startService] directly — bypassing [WebtritSignalingService]
  /// and its own [_isDisposed] check — and starts a new FGS. If the logout
  /// teardown then calls [stopService] on the new FGS before it reaches
  /// [startForeground], the OS throws [ForegroundServiceDidNotStartInTimeException].
  ///
  /// Reset to `false` in [start] so the service can be restarted after a new
  /// login session.
  bool _isStopped = false;

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
    _isStopped = false;
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
    if (_currentMode == SignalingServiceMode.pushBound) {
      _logger.info('attach: direct mode — no-op (no FGS hub to attach to)');
      return;
    }
    _hubManager.begin();
  }

  @override
  Future<void> execute(Request request) async {
    final directModule = _directModule;
    if (directModule != null) {
      if (directModule.isConnected) {
        _logger.fine('execute (direct) ${request.runtimeType}');
        final future = directModule.execute(request);
        if (future != null) await future;
        return;
      }
      _logger.warning('execute called but direct module not connected (${request.runtimeType})');
      throw NotConnectedException('SignalingServiceAndroid: not connected (direct mode)');
    }
    if (_hubManager.isConnected) {
      _logger.fine('execute ${request.runtimeType}');
      await _hubManager.execute(request)!;
      return;
    }
    _logger.warning('execute called but not connected (${request.runtimeType})');
    throw NotConnectedException('SignalingServiceAndroid: not connected');
  }

  /// Switches the service lifecycle mode.
  ///
  /// For FGS modes, updates the Kotlin-side lifecycle behaviour by restarting
  /// the foreground service with the new mode. The WebSocket in the background
  /// isolate is preserved. For transitions away from direct pushBound, tears
  /// down the direct module before starting the FGS. For transitions INTO direct
  /// pushBound (e.g. persistent → pushBound), tears down the hub manager and
  /// stops the FGS before starting the direct WebSocket to avoid running two
  /// simultaneous connections.
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
    if (_directModule != null) {
      await _tearDownDirectModule();
    }
    if (mode == SignalingServiceMode.pushBound) {
      // FGS hub may be running from a previous persistent mode — tear it
      // down before opening the direct WebSocket to avoid two simultaneous
      // connections for the same account.
      await _hubManager.tearDown();
      await _hostApi.stopService();
    }
    await _startService(config, mode);
  }

  @override
  Future<void> dispose() async {
    _isStopped = true;
    _logger.info('dispose');
    await _hubManager.tearDown();
    await _tearDownDirectModule();

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
    _factory = factory;
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
    _isStopped = true;
    _logger.info('stopService');
    if (_currentMode == SignalingServiceMode.pushBound) {
      await _tearDownDirectModule();
      return;
    }
    await _hostApi.stopService();
  }

  @override
  Future<void> restoreService() async {
    _logger.info('restoreService');
    await _hostApi.connect();
  }

  @override
  Future<void> simulateKill() async {
    _logger.info('simulateKill');
    await _hostApi.simulateKill();
  }

  Future<void> _onHubServiceDead() async {
    if (_isStopped) {
      _logger.info('_onHubServiceDead: service intentionally stopped, skipping restart');
      return;
    }
    final config = _currentConfig;
    final mode = _currentMode;
    if (config == null || mode == null) {
      _logger.warning('_onHubServiceDead: no config/mode available, cannot restart');
      return;
    }
    if (mode == SignalingServiceMode.pushBound) {
      _logger.info('_onHubServiceDead: pushBound mode — FCM push will trigger restart');
      return;
    }
    _logger.warning('_onHubServiceDead: hub service dead, restarting');
    try {
      await _startService(config, mode);
    } catch (e, st) {
      _logger.severe('_onHubServiceDead: failed to restart service', e, st);
    }
  }

  Future<void> _startService(SignalingServiceConfig config, SignalingServiceMode mode) async {
    if (mode == SignalingServiceMode.pushBound) {
      await _startDirect(config);
      return;
    }

    _logger.fine('_startService mode=$mode (FGS)');
    if (_isStopped) {
      _logger.warning('_startService: aborted — service already stopped');
      return;
    }
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

    // Guard: stopService() or dispose() may have been called while the
    // credential saves above were in flight (the await yields the event loop,
    // allowing concurrent teardown to set _isStopped). Abort before calling
    // startForegroundService() to avoid ForegroundServiceDidNotStartInTimeException —
    // the crash that fires when the service is stopped before it calls startForeground().
    if (_isStopped) {
      _logger.warning('_startService: aborted — service stopped during credential save');
      return;
    }

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

  /// Starts a direct WebSocket in the current isolate without an FGS.
  /// Used for [SignalingServiceMode.pushBound].
  ///
  /// **Push isolate** (detected by [_handoffCallback] being set): registers a
  /// [ReceivePort] under [kPushHandoffPortName] in [IsolateNameServer] and
  /// listens for a null signal from the Activity. On receipt, calls
  /// [_handoffCallback] so app code can complete the push lifecycle early.
  ///
  /// **Activity** (no [_handoffCallback]): on [SignalingConnected], looks up
  /// [kPushHandoffPortName] and sends null to notify the push isolate.
  Future<void> _startDirect(SignalingServiceConfig config) async {
    _logger.info('_startDirect: starting direct WebSocket (no FGS)');
    if (_isStopped) {
      _logger.warning('_startDirect: aborted — service already stopped');
      return;
    }
    final factory = _factory;
    if (factory == null) {
      throw StateError(
        'No SignalingModuleFactory registered — call setModuleFactory() before start().',
      );
    }
    await _tearDownDirectModule();

    final isPushIsolate = _handoffCallback != null;
    if (isPushIsolate) {
      _handoffPort = ReceivePort('push_handoff');
      IsolateNameServer.registerPortWithName(_handoffPort!.sendPort, kPushHandoffPortName);
      _handoffPort!.listen((_) {
        _logger.info('_startDirect: handoff signal received from Activity');
        _handoffCallback?.call();
      });
      _logger.info('_startDirect: push isolate — handoff port registered');
    }

    final module = factory(config);
    _directModuleSub = module.events.listen(
      (event) {
        _eventBuffer.onEvent(event);
        if (!_eventsController.isClosed) _eventsController.add(event);
        if (!isPushIsolate && event is SignalingConnected) {
          final port = IsolateNameServer.lookupPortByName(kPushHandoffPortName);
          if (port != null) {
            _logger.info('_startDirect: Activity connected — sending handoff signal to push isolate');
            port.send(null);
          }
        }
      },
      onError: (Object e, StackTrace st) {
        if (!_eventsController.isClosed) _eventsController.addError(e, st);
      },
    );
    _directModule = module;
    module.connect();
  }

  Future<void> _tearDownDirectModule() async {
    await _directModuleSub?.cancel();
    _directModuleSub = null;
    await _directModule?.dispose();
    _directModule = null;
    if (_handoffPort != null) {
      IsolateNameServer.removePortNameMapping(kPushHandoffPortName);
      _handoffPort!.close();
      _handoffPort = null;
    }
  }

  @override
  void setHandoffCallback(VoidCallback callback) {
    _logger.info('setHandoffCallback: registered');
    _handoffCallback = callback;
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
