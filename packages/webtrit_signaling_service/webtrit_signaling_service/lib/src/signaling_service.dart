import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

export 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart'
    show
        SignalingModuleEvent,
        SignalingModuleFactory,
        SignalingModule,
        SignalingModuleImpl,
        SignalingClientFactory,
        SignalingConnecting,
        SignalingConnected,
        SignalingConnectionFailed,
        SignalingDisconnecting,
        SignalingDisconnected,
        SignalingHandshakeReceived,
        SignalingProtocolEvent,
        SignalingServiceConfig,
        SignalingServiceMode,
        SignalingEventBuffer,
        createSignalingModule;

/// Public entry point for the signaling service plugin.
///
/// Platform implementations (Android / iOS) are registered automatically via
/// Flutter's plugin registry. Callers depend only on this class -- never on
/// platform-specific packages.
///
/// Usage:
/// ```dart
/// final service = WebtritSignalingService();
/// await service.start(SignalingServiceConfig(
///   coreUrl: coreUrl,
///   tenantId: tenantId,
///   token: token,
/// ));
/// service.events.listen((event) { ... });
/// ```
class WebtritSignalingService {
  /// Broadcast stream of all signaling events.
  Stream<SignalingModuleEvent> get events => SignalingServicePlatform.instance.events;

  /// Configures and starts the signaling service.
  ///
  /// [mode] controls the service lifecycle -- see [SignalingServiceMode].
  Future<void> start(SignalingServiceConfig config, {SignalingServiceMode mode = SignalingServiceMode.persistent}) =>
      SignalingServicePlatform.instance.start(config, mode: mode);

  /// Connects to an already-running service hub without starting a new service.
  ///
  /// Call this from the main isolate when the Activity opens after a push
  /// has already started the service in [SignalingServiceMode.pushBound].
  Future<void> attach() => SignalingServicePlatform.instance.attach();

  /// Sends [request] via the active connection.
  Future<void> execute(Request request) => SignalingServicePlatform.instance.execute(request);

  /// Updates the service lifecycle mode without restarting the connection.
  Future<void> updateMode(SignalingServiceMode mode) => SignalingServicePlatform.instance.updateMode(mode);

  /// Registers the app-side incoming call callback for background handling.
  ///
  /// [callback] must be a top-level function annotated with
  /// [@pragma('vm:entry-point')]. Call this before [start] so the handle is
  /// persisted before the foreground service starts its background isolate.
  ///
  /// On iOS this is a no-op.
  Future<void> setIncomingCallHandler(Function callback) =>
      SignalingServicePlatform.instance.setIncomingCallHandler(callback);

  /// Registers the factory used to create [SignalingModule] instances.
  ///
  /// On Android [factory] must be a top-level function annotated with
  /// [@pragma('vm:entry-point')] so [PluginUtilities] can serialize its handle
  /// for the foreground-service background isolate.
  /// Must be called before [start].
  Future<void> setModuleFactory(SignalingModuleFactory factory) =>
      SignalingServicePlatform.instance.setModuleFactory(factory);

  /// Stops the service and releases all resources.
  Future<void> dispose() => SignalingServicePlatform.instance.dispose();
}
