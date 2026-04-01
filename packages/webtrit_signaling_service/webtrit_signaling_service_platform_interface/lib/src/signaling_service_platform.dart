import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'models/signaling_module_event.dart';
import 'models/signaling_module_factory.dart';
import 'models/signaling_service_config.dart';
import 'models/signaling_service_mode.dart';

/// Platform interface for [WebtritSignalingService].
///
/// Platform implementations must extend this class rather than implement it.
abstract class SignalingServicePlatform extends PlatformInterface {
  SignalingServicePlatform() : super(token: _token);

  static final Object _token = Object();

  static SignalingServicePlatform? _instance;

  static SignalingServicePlatform get instance {
    final inst = _instance;
    if (inst == null) throw StateError('SignalingServicePlatform not initialized');
    return inst;
  }

  static set instance(SignalingServicePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Broadcast stream of all signaling events.
  Stream<SignalingModuleEvent> get events;

  /// Configures and starts the signaling service with the given [config].
  ///
  /// [mode] controls the service lifecycle (Android only -- ignored on iOS):
  /// - [SignalingServiceMode.persistent] -- foreground service survives app
  ///   closure and device reboot (default). On iOS the connection always runs
  ///   in the main isolate and is not persistent.
  /// - [SignalingServiceMode.pushBound] -- service stops when the app Activity
  ///   is closed, allowing the next push to start a fresh instance.
  Future<void> start(SignalingServiceConfig config, {SignalingServiceMode mode = SignalingServiceMode.persistent});

  /// Connects to an already-running service hub without starting a new service.
  ///
  /// Call this from the main isolate when the Activity opens after a push
  /// notification has already started the service in [SignalingServiceMode.pushBound].
  /// Events from the existing connection are delivered immediately via [events].
  Future<void> attach();

  /// Sends [request] to the server via the active connection.
  Future<void> execute(Request request);

  /// Updates the service lifecycle mode without restarting the connection.
  ///
  /// On Android this persists the new [mode] and updates [onTaskRemoved] behavior.
  /// On iOS this is a no-op.
  Future<void> updateMode(SignalingServiceMode mode);

  /// Registers the app-side incoming call callback for background handling.
  ///
  /// [callback] must be a top-level function annotated with
  /// [@pragma('vm:entry-point')]. It receives an [IncomingCallEvent] and is
  /// responsible for triggering callkeep when an incoming call arrives while
  /// the app is closed.
  ///
  /// On Android the raw callback handle is persisted via [PluginUtilities] so
  /// the foreground-service isolate can invoke it without the main isolate being
  /// alive. On iOS this is a no-op.
  Future<void> setIncomingCallHandler(Function callback);

  /// Registers the factory used to create [SignalingModuleInterface] instances.
  ///
  /// On Android [factory] must be a top-level function annotated with
  /// [@pragma('vm:entry-point')] so [PluginUtilities] can serialize its handle
  /// for the foreground-service background isolate.
  /// Must be called before [start].
  Future<void> setModuleFactory(SignalingModuleFactory factory);

  /// Stops the service and releases all resources.
  Future<void> dispose();
}
