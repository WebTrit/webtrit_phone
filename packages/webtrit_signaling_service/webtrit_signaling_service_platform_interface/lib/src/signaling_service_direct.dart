import 'dart:async';

import 'package:flutter/foundation.dart' show protected;
import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'models/signaling_module.dart';
import 'models/signaling_module_event.dart';
import 'models/signaling_module_factory.dart';
import 'models/signaling_service_config.dart';
import 'models/signaling_service_mode.dart';
import 'signaling_event_buffer.dart';
import 'signaling_request_queue.dart';
import 'signaling_service_platform.dart';

final _logger = Logger('WebtritSignalingServiceDirect');

/// Shared base implementation of [SignalingServicePlatform] for direct
/// WebSocket mode.
///
/// Manages the [SignalingModule] lifecycle entirely in the calling isolate —
/// no Foreground Service, no background isolate. Used as-is on iOS and as
/// the pushBound delegate on Android.
///
/// Subclasses may override [onBeforeStart] and [onConnected] to inject
/// platform-specific behaviour (e.g. Android push-isolate handoff via
/// [IsolateNameServer]) without duplicating the core connection logic.
class WebtritSignalingServiceDirect extends SignalingServicePlatform {
  WebtritSignalingServiceDirect();

  SignalingModuleFactory? _factory;
  SignalingModule? _module;
  StreamSubscription<SignalingModuleEvent>? _moduleSub;
  StreamController<SignalingModuleEvent> _eventsController = StreamController<SignalingModuleEvent>.broadcast();

  final _eventBuffer = SignalingEventBuffer();

  /// Set to true by [stopService] and [dispose]; reset to false at the start
  /// of [start]. Guards against concurrent teardown racing with a new start
  /// during the async gaps of [_tearDownModule] and [onBeforeStart].
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
  Future<void> setModuleFactory(SignalingModuleFactory factory) async {
    _factory = factory;
  }

  @override
  Future<void> start(
    SignalingServiceConfig config, {
    SignalingServiceMode mode = SignalingServiceMode.persistent,
  }) async {
    _isStopped = false;

    final factory = _factory;
    if (factory == null) {
      throw StateError('No SignalingModuleFactory registered — call setModuleFactory() before start()');
    }

    if (_eventsController.isClosed) {
      _eventsController = StreamController<SignalingModuleEvent>.broadcast();
    }

    await _tearDownModule();
    if (_isStopped) {
      _logger.fine('start: aborted — stopped during _tearDownModule');
      return;
    }

    await onBeforeStart(config);
    if (_isStopped) {
      _logger.fine('start: aborted — stopped during onBeforeStart');
      return;
    }

    final module = factory(config);
    _moduleSub = module.events.listen(
      (event) {
        if (!_eventsController.isClosed) {
          _eventBuffer.onEvent(event);
          _eventsController.add(event);
        }
        if (event is SignalingConnected) onConnected();
      },
      onError: (Object e, StackTrace st) {
        if (!_eventsController.isClosed) _eventsController.addError(e, st);
      },
    );
    _module = module;
    module.connect();
  }

  @override
  Future<void> execute(Request request) async {
    final module = _module;
    if (module == null || !module.isConnected) {
      throw NotConnectedException('SignalingServiceDirect: not connected');
    }
    await module.execute(request)!;
  }

  @override
  Future<void> updateMode(SignalingServiceMode mode) async {}

  @override
  Future<void> setIncomingCallHandler(Function callback) async {}

  @override
  Future<void> stopService() async {
    _isStopped = true;
    await _tearDownModule();
  }

  @override
  Future<void> dispose() async {
    _isStopped = true;
    await _tearDownModule();
    _eventBuffer.clear();
    await _eventsController.close();
    // Resurrect so events.listen() works before the next start().
    _eventsController = StreamController<SignalingModuleEvent>.broadcast();
  }

  // ---------------------------------------------------------------------------
  // Hooks for subclasses
  // ---------------------------------------------------------------------------

  /// Called inside [start] after the previous module is torn down and before
  /// the new module is created. Override to perform platform-specific setup
  /// (e.g. registering an [IsolateNameServer] port on Android).
  @protected
  Future<void> onBeforeStart(SignalingServiceConfig config) async {}

  /// Called when the module emits [SignalingConnected]. Override to send
  /// platform-specific signals (e.g. push-isolate handoff on Android).
  @protected
  void onConnected() {}

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  Future<void> _tearDownModule() async {
    await _moduleSub?.cancel();
    _moduleSub = null;
    await _module?.dispose();
    _module = null;
  }
}
