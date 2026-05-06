import 'dart:async';
import 'dart:convert';

import 'dart:ui' show PluginUtilities;
import 'package:flutter/foundation.dart' show VoidCallback, visibleForTesting;
import 'package:flutter/services.dart' show BinaryMessenger;
import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'fgs/isolate/entry_point.dart' show signalingServiceCallbackDispatcher;
import 'messages.g.dart';
import 'mode_mapping.dart';
import 'fgs/hub_connection_manager.dart';
import 'direct/signaling_service_android_direct.dart';

final _logger = Logger('WebtritSignalingServiceAndroid');

/// Android implementation of [SignalingServicePlatform].
///
/// **pushBound mode:**
/// Delegates entirely to [WebtritSignalingServiceAndroidDirect] — the WebSocket
/// runs directly in the calling isolate, identical to iOS. Events are forwarded
/// from the delegate into this class's [_eventsController] so external consumers
/// see a single stable stream regardless of mode.
///
/// **persistent mode:**
/// The WebSocket runs inside an Android Foreground Service (background isolate
/// + [SignalingHub]). Push and main isolates connect to the hub via
/// [IsolateNameServer] — they never open their own WebSocket.
///
/// Mode details:
/// - **pushBound** -- service dies when the user closes the app; FCM push starts
///   a fresh instance for the next call.
/// - **persistent** -- service survives app closure; restarted after device reboot.
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

  /// Delegate for pushBound direct WebSocket mode.
  final _directService = WebtritSignalingServiceAndroidDirect();

  /// Active subscription forwarding events from [_directService] into
  /// [_eventsController]. Non-null only while in pushBound mode.
  StreamSubscription<SignalingModuleEvent>? _directServiceSub;

  SignalingServiceConfig? _currentConfig;

  /// Last mode explicitly set via [start] or [updateMode].
  ///
  /// When [start] is called for reconnection with the initial mode (e.g.
  /// [SignalingServiceMode.pushBound]), this field preserves the most recently
  /// chosen mode instead of reverting to a stale parameter.
  SignalingServiceMode? _currentMode;

  /// Set to true by [stopService] and [dispose] to prevent [_onHubServiceDead]
  /// from restarting the foreground service after an intentional stop.
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
    _currentMode ??= mode;
    final effectiveMode = _currentMode!;

    _logger.info('start effectiveMode=$effectiveMode tenantId=${config.tenantId}');

    if (_eventsController.isClosed) {
      _eventsController = StreamController<SignalingModuleEvent>.broadcast();
    }

    await _startService(config, effectiveMode);
  }

  @override
  Future<void> execute(Request request) async {
    if (_currentMode == SignalingServiceMode.pushBound) {
      return _directService.execute(request);
    }
    if (_hubManager.isConnected) {
      _logger.fine('execute ${request.runtimeType}');
      await _hubManager.execute(request)!;
      return;
    }
    _logger.warning('execute called but not connected (${request.runtimeType})');
    throw NotConnectedException('SignalingServiceAndroid: not connected');
  }

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

    if (mode == SignalingServiceMode.pushBound) {
      // FGS hub may be running from a previous persistent mode — tear it
      // down before opening the direct WebSocket to avoid two simultaneous
      // connections for the same account.
      await _hubManager.tearDown();
      await _hostApi.stopService();
    } else {
      // Switching away from pushBound — stop the direct delegate.
      await _directServiceSub?.cancel();
      _directServiceSub = null;
      await _directService.stopService();
    }

    await _startService(config, mode);
  }

  @override
  Future<void> dispose() async {
    _isStopped = true;
    _logger.info('dispose');
    await _hubManager.tearDown();
    await _directServiceSub?.cancel();
    _directServiceSub = null;
    await _directService.dispose();

    // NOTE: stopService() is intentionally NOT called here.
    // The Android service lifecycle is managed by the Kotlin side:
    //   - pushBound: onTaskRemoved -> stopSelf()
    //   - persistent: service keeps running until the next explicit stop
    _currentMode = null;
    _eventBuffer.clear();
    // NOTE: _eventsController is intentionally NOT closed here.
    // Closing it would deliver onDone to any active subscriber (e.g. CallBloc),
    // silently ending their subscription. The next start() call creates a fresh
    // controller only if this one is closed.
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
    // Dart-side storage for pushBound direct mode.
    await _directService.setModuleFactory(factory);

    // Kotlin-side storage for FGS background isolate (persistent mode).
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
      await _directServiceSub?.cancel();
      _directServiceSub = null;
      await _directService.stopService();
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

  @override
  void setHandoffCallback(VoidCallback callback) {
    _logger.info('setHandoffCallback: registered');
    _directService.setHandoffCallback(callback);
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

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
      _logger.fine('_startService mode=pushBound — delegating to direct service');

      // Cancel any existing forwarding subscription before starting the new
      // session to avoid stale event forwarding and duplicate subscriptions.
      await _directServiceSub?.cancel();
      _directServiceSub = null;

      // Start the direct service first so SignalingConnecting is emitted and
      // buffered before we subscribe — this clears any stale events from a
      // previous session and guarantees the replay on subscribe is fresh.
      await _directService.start(config, mode: mode);

      // Subscribe after start() so the replay contains only [SignalingConnecting]
      // (and any events already emitted synchronously during connect()).
      _directServiceSub = _directService.events.listen(
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

    await Future.wait([
      _hostApi.initializeServiceCallback(dispatcherHandle.toRawHandle(), 0),
      _hostApi.saveConnectionConfig(config.coreUrl, config.tenantId, config.token),
      _hostApi.saveTrustedCertificates(_encodeTrustedCertificates(config.trustedCertificates)),
    ]);

    if (_isStopped) {
      _logger.warning('_startService: aborted — service stopped during credential save');
      return;
    }

    await _hostApi.startService(signalingModeToNative(mode));

    _hubManager.begin();
  }
}

String? _encodeTrustedCertificates(TrustedCertificates certs) {
  if (!certs.hasAvailableCertificates) return null;
  return jsonEncode(
    certs.certificates
        .map((c) => <String, dynamic>{'bytes': c.bytes, if (c.password != null) 'password': c.password})
        .toList(),
  );
}
