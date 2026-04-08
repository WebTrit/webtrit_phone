import 'dart:async';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

final _logger = Logger('WebtritSignalingServiceIos');

/// iOS implementation of [SignalingServicePlatform].
///
/// On iOS there is no foreground service -- [SignalingModule] runs directly in
/// the main isolate. [start] creates the module via the registered factory and opens the connection.
/// [attach] is a no-op because there is no separate background process.
class WebtritSignalingServiceIos extends SignalingServicePlatform {
  WebtritSignalingServiceIos._();

  @visibleForTesting
  WebtritSignalingServiceIos.forTesting() : this._();

  static WebtritSignalingServiceIos? _instance;

  static void registerWith() {
    _instance ??= WebtritSignalingServiceIos._();
    SignalingServicePlatform.instance = _instance!;
  }

  SignalingModuleFactory? _factory;
  SignalingModule? _module;
  StreamSubscription<SignalingModuleEvent>? _moduleSub;
  StreamController<SignalingModuleEvent> _eventsController = StreamController<SignalingModuleEvent>.broadcast();

  final _eventBuffer = SignalingEventBuffer();

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
    _logger.info('WebtritSignalingServiceIos.setModuleFactory');
    _factory = factory;
  }

  @override
  Future<void> start(
    SignalingServiceConfig config, {
    SignalingServiceMode mode = SignalingServiceMode.persistent,
  }) async {
    _logger.info('WebtritSignalingServiceIos.start mode=$mode');

    final factory = _factory;
    if (factory == null) {
      throw StateError('No SignalingModuleFactory registered -- call setModuleFactory() before start()');
    }

    if (_eventsController.isClosed) {
      _eventsController = StreamController<SignalingModuleEvent>.broadcast();
    }

    await _tearDownModule();

    final module = factory(config);

    _moduleSub = module.events.listen(
      (event) {
        if (!_eventsController.isClosed) {
          _eventBuffer.onEvent(event);
          _eventsController.add(event);
        }
      },
      onError: (Object e, StackTrace st) {
        if (!_eventsController.isClosed) _eventsController.addError(e, st);
      },
    );

    _module = module;
    module.connect();
  }

  /// No-op on iOS -- there is no background service process to attach to.
  ///
  /// On iOS the [SignalingModule] always runs in the main isolate, so no
  /// cross-isolate hub handshake is required.
  @override
  Future<void> attach() async {
    _logger.info('WebtritSignalingServiceIos.attach -- no-op on iOS');
  }

  @override
  Future<void> execute(Request request) async {
    final module = _module;
    if (module == null || !module.isConnected) {
      throw StateError('SignalingModule not ready -- call start() first');
    }
    await module.execute(request)!;
  }

  /// No-op on iOS -- there is no background service process whose lifecycle mode can be changed.
  @override
  Future<void> updateMode(SignalingServiceMode mode) async {
    _logger.info('WebtritSignalingServiceIos.updateMode -- no-op on iOS');
  }

  @override
  Future<void> setIncomingCallHandler(Function callback) async {
    _logger.info('WebtritSignalingServiceIos.setIncomingCallHandler -- no-op on iOS');
  }

  @override
  Future<void> dispose() async {
    _logger.info('WebtritSignalingServiceIos.dispose');
    await _tearDownModule();
    _eventBuffer.clear();
    await _eventsController.close();
    // Resurrect immediately so events.listen() works before the next start().
    _eventsController = StreamController<SignalingModuleEvent>.broadcast();
  }

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
