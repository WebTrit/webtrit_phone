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
/// ## Module rotation
///
/// Each [start] call unconditionally disposes the previous [SignalingModule]
/// and creates a fresh one via the registered factory — even when the config
/// has not changed. The design trades a small per-reconnect overhead for a
/// simpler invariant: no stale session state can carry over between starts,
/// and no config-equality check is needed at the call site.
///
/// Reuse is not possible regardless: [SignalingModuleImpl] binds connection
/// credentials (`token`, `tenantId`, `coreUrl`) as `final` fields, and
/// [SignalingModule.dispose] closes the internal [StreamController]
/// permanently, so a disposed instance can neither accept new credentials
/// nor emit further events.
///
/// The rotation introduces two async suspension points inside [start] —
/// [_tearDownModule] and [onBeforeStart] — where a second concurrent [start]
/// call can slip through the [_isStopped] guard and create a duplicate
/// WebSocket connection (zombie race). See [_isStopped] for what it covers
/// and where it falls short.
///
/// Subclasses may override [onBeforeStart] and [onConnected] to inject
/// platform-specific behaviour (e.g. Android push-isolate handoff via
/// [IsolateNameServer]) without duplicating the core connection logic.
class WebtritSignalingServiceDirect extends SignalingServicePlatform {
  WebtritSignalingServiceDirect();

  SignalingModuleFactory? _factory;
  SignalingModule? _module;
  StreamSubscription<SignalingModuleEvent>? _moduleSub;

  // Fans out SignalingModuleEvents to all subscribers (WebtritSignalingService, CallBloc, etc.).
  // Intentionally not closed in dispose() -- closing it would deliver onDone to active subscribers,
  // silently ending their subscriptions and breaking logout+re-login in the same process.
  final StreamController<SignalingModuleEvent> _eventsController = StreamController<SignalingModuleEvent>.broadcast();

  final _eventBuffer = SignalingEventBuffer();

  /// Set to true by [stopService] and [dispose]; reset to false at the start
  /// of [start]. Guards against a [dispose]/[stopService] call racing with an
  /// in-progress [start] at the [_tearDownModule] and [onBeforeStart]
  /// suspension points.
  ///
  /// Does NOT protect against two concurrent [start] calls: both reset this
  /// flag to `false`, so neither can detect the other's presence.
  bool _isStopped = false;

  /// Identity token for the active [start] invocation.
  ///
  /// A fresh [Object] is assigned at the beginning of each [start] call.
  /// After every suspension point the in-progress call compares its captured
  /// token against the current value: a mismatch means a newer [start] has
  /// been issued and this invocation must abort without creating a module,
  /// preventing two concurrent [module.connect] calls from reaching the server.
  Object? _startToken;

  @override
  Stream<SignalingModuleEvent> get events {
    return Stream.multi((sink) {
      if (_eventsController.isClosed) {
        _logger.severe(
          'events: _eventsController is closed — new subscriber will receive onDone immediately; '
          'signaling events will never reach this subscriber',
        );
      }
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
    // ignore: avoid_unused_parameters
    SignalingServiceMode mode = SignalingServiceMode.pushBound,
  }) async {
    _isStopped = false;
    final myToken = _startToken = Object();

    final factory = _factory;
    if (factory == null) {
      throw StateError('No SignalingModuleFactory registered — call setModuleFactory() before start()');
    }

    await _tearDownModule();
    if (_isStopped) {
      _logger.fine('start: aborted — stopped during _tearDownModule');
      return;
    }
    if (!identical(_startToken, myToken)) {
      _logger.fine('start: aborted — superseded during _tearDownModule');
      return;
    }

    await onBeforeStart(config);
    if (_isStopped) {
      _logger.fine('start: aborted — stopped during onBeforeStart');
      return;
    }
    if (!identical(_startToken, myToken)) {
      _logger.fine('start: aborted — superseded during onBeforeStart');
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
  // ignore: avoid_unused_parameters
  Future<void> updateMode(SignalingServiceMode mode) async {}

  @override
  // ignore: avoid_unused_parameters
  Future<void> setCallEventHandler(Function callback) async {}

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
    // NOTE: _eventsController is intentionally NOT closed here.
    // Closing it would deliver onDone to any active subscriber (e.g. WebtritSignalingService),
    // silently ending their subscription and breaking logout+re-login in the same process.
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
