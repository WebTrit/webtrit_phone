import 'dart:async';

import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

/// Adapts [WebtritSignalingService] to [SignalingModuleInterface] so that
/// [CallBloc] can use the signaling service without knowing the underlying
/// transport (foreground service on Android, direct on iOS).
///
/// Lifecycle:
///   - [connect] -- starts the service via [WebtritSignalingService.start].
///     Fire-and-forget; events arrive via [events] once the connection is established.
///     Re-subscribes the internal status listener to the fresh event stream after
///     each [start] call, so [isConnected] remains accurate across reconnects.
///   - [disconnect] -- no-op; the service manages its own connection lifecycle.
///     Use [dispose] to fully stop the service.
///   - [execute] -- delegates directly to [WebtritSignalingService.execute].
///     Throws [StateError] when the underlying module is not connected.
///   - [dispose] -- stops the service and releases all resources.
class SignalingServiceModuleAdapter implements SignalingModuleInterface {
  SignalingServiceModuleAdapter({
    required WebtritSignalingService service,
    required SignalingServiceConfig config,
    SignalingServiceMode mode = SignalingServiceMode.persistent,
  }) : _service = service,
       _config = config,
       _mode = mode;

  final WebtritSignalingService _service;
  final SignalingServiceConfig _config;
  final SignalingServiceMode _mode;

  bool _isConnected = false;
  StreamSubscription<SignalingModuleEvent>? _statusSub;

  @override
  Stream<SignalingModuleEvent> get events => _service.events;

  @override
  bool get isConnected => _isConnected;

  @override
  void connect() {
    _statusSub?.cancel();
    _statusSub = _service.events.listen((event) {
      switch (event) {
        case SignalingConnected():
          _isConnected = true;
        case SignalingDisconnected():
        case SignalingConnectionFailed():
          _isConnected = false;
        default:
          break;
      }
    });
    _service.start(_config, mode: _mode).ignore();
  }

  /// No-op -- intentional. In persistent mode the service runs inside an Android
  /// foreground service and is designed to stay connected while the app is
  /// backgrounded. [CallBloc] calls [disconnect] when it goes to the background
  /// with no active calls; honouring that would defeat the purpose of the
  /// persistent service (the server would lose the connection and fall back to
  /// FCM push for the next call). If push-bound mode is used instead, the
  /// service stops on its own via [onTaskRemoved] -- no explicit disconnect needed.
  @override
  Future<void> disconnect() async {}

  @override
  Future<void>? execute(Request request) => _service.execute(request);

  @override
  Future<void> dispose() async {
    await _statusSub?.cancel();
    _statusSub = null;
    _isConnected = false;
    await _service.dispose();
  }
}
