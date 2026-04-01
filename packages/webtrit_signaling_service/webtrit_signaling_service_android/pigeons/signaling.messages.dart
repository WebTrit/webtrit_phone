// Run code generation from the android package root:
//   dart run pigeon --input pigeons/signaling.messages.dart
//
// Output files configured below via @ConfigurePigeon.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/webtrit/signaling_service/Messages.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.webtrit.signaling_service'),
  ),
)
// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------
/// Mirrors [SignalingServiceMode] from the platform_interface package.
enum PSignalingServiceMode { persistent, pushBound }

// ---------------------------------------------------------------------------
// Data classes
// ---------------------------------------------------------------------------
class PSignalingServiceStatus {
  PSignalingServiceStatus({
    required this.enabled,
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.incomingCallHandlerHandle,
    required this.moduleFactoryHandle,
  });

  final bool enabled;
  final String coreUrl;
  final String tenantId;
  final String token;

  /// Raw handle for the app-side incoming call callback.
  ///
  /// Obtained via [PluginUtilities.getCallbackHandle] in the main isolate and
  /// persisted via [PSignalingServiceHostApi.saveIncomingCallHandler].
  /// 0 means no handler is registered.
  final int incomingCallHandlerHandle;

  /// Raw handle for the app-side [SignalingModuleFactory] callback.
  ///
  /// Obtained via [PluginUtilities.getCallbackHandle] and persisted via
  /// [PSignalingServiceHostApi.saveModuleFactory]. 0 means no factory registered.
  final int moduleFactoryHandle;
}

// ---------------------------------------------------------------------------
// Host API -- Dart -> Kotlin (lifecycle commands)
// ---------------------------------------------------------------------------

@HostApi()
abstract class PSignalingServiceHostApi {
  /// Register the Dart callback dispatcher handle and the onSync entry point handle.
  /// Must be called before [startService].
  void initializeServiceCallback(int callbackDispatcher, int onSync);

  /// Persist connection credentials so the foreground service can deliver them
  /// to the background isolate via [PSignalingServiceFlutterApi.onSynchronize].
  /// Must be called before [startService].
  void saveConnectionConfig(String coreUrl, String tenantId, String token);

  /// Persist the raw callback handle for the app-side incoming call handler.
  ///
  /// The handle is obtained via [PluginUtilities.getCallbackHandle] on a
  /// top-level function annotated with [@pragma('vm:entry-point')].
  /// Pass 0 to unregister.
  void saveIncomingCallHandler(int callbackHandle);

  /// Persist the raw callback handle for the app-side [SignalingModuleFactory].
  ///
  /// The handle is obtained via [PluginUtilities.getCallbackHandle] on a
  /// top-level function annotated with [@pragma('vm:entry-point')].
  void saveModuleFactory(int callbackHandle);

  /// Set the foreground service notification text.
  void configureService(String notificationTitle, String notificationDescription);

  /// Start the foreground service (idempotent).
  ///
  /// [mode] controls whether the service stops when the app Activity is closed
  /// ([PSignalingServiceMode.pushBound]) or runs indefinitely
  /// ([PSignalingServiceMode.persistent]).
  void startService(PSignalingServiceMode mode);

  /// Stop the foreground service.
  void stopService();

  /// Called from the background Dart isolate after [PSignalingServiceFlutterApi.setUp]
  /// completes, signalling that the isolate is ready to receive [onSynchronize] calls.
  ///
  /// Kotlin responds by calling [SignalingForegroundService.synchronizeIsolate] so
  /// the service delivers the current status to the freshly-initialised isolate.
  void notifyIsolateReady();
}

// ---------------------------------------------------------------------------
// Flutter API -- Kotlin -> Dart (background isolate callbacks)
// ---------------------------------------------------------------------------

@FlutterApi()
abstract class PSignalingServiceFlutterApi {
  /// Called by Kotlin when the Flutter engine is ready and the current
  /// service status should be replayed to the freshly-started isolate.
  void onSynchronize(PSignalingServiceStatus status);
}
