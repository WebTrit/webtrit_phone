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
// Data classes
// ---------------------------------------------------------------------------
class PSignalingServiceStatus {
  PSignalingServiceStatus({
    required this.enabled,
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.callEventHandlerHandle,
    required this.moduleFactoryHandle,
    this.trustedCertificatesJson,
  });

  final bool enabled;
  final String coreUrl;
  final String tenantId;
  final String token;

  /// JSON-encoded list of trusted certificate entries, each with 'bytes' (List<int>)
  /// and optional 'password' (String). Null when the app uses the default system trust store.
  ///
  /// Persisted via [PSignalingServiceHostApi.saveTrustedCertificates] so that
  /// the background isolate can reconstruct [TrustedCertificates] without access
  /// to the main-isolate DI context.
  final String? trustedCertificatesJson;

  /// Raw handle for the app-side call-event callback.
  ///
  /// Obtained via [PluginUtilities.getCallbackHandle] in the main isolate and
  /// persisted via [PSignalingServiceHostApi.saveCallEventHandler].
  /// 0 means no handler is registered.
  final int callEventHandlerHandle;

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

  /// Persist JSON-encoded trusted certificates for the background isolate.
  ///
  /// Pass null to clear (revert to system trust store). Call before [startService]
  /// so the isolate receives the correct TLS configuration on first sync.
  void saveTrustedCertificates(String? certificatesJson);

  /// Persist the raw callback handle for the app-side call-event handler.
  ///
  /// The handle is obtained via [PluginUtilities.getCallbackHandle] on a
  /// top-level function annotated with [@pragma('vm:entry-point')].
  /// Pass 0 to unregister.
  void saveCallEventHandler(int callbackHandle);

  /// Persist the raw callback handle for the app-side [SignalingModuleFactory].
  ///
  /// The handle is obtained via [PluginUtilities.getCallbackHandle] on a
  /// top-level function annotated with [@pragma('vm:entry-point')].
  void saveModuleFactory(int callbackHandle);

  /// Set the foreground service notification text.
  void configureService(String notificationTitle, String notificationDescription);

  /// Start the foreground service (idempotent).
  void startService();

  /// Stop the foreground service.
  void stopService();

  /// Called from the background Dart isolate after [PSignalingServiceFlutterApi.setUp]
  /// completes, signalling that the isolate is ready to receive [onSynchronize] calls.
  ///
  /// Kotlin responds by calling [SignalingForegroundService.synchronizeIsolate] so
  /// the service delivers the current status to the freshly-initialised isolate.
  void notifyIsolateReady();

  /// Restores the persistent foreground service if it was killed by the OS.
  ///
  /// No-op when the service is already running, credentials are missing
  /// (post-logout), or the callback dispatcher is not registered.
  void connect();

  /// Stops the foreground service immediately without a graceful WebSocket
  /// disconnect, simulating an abrupt OS kill.
  ///
  /// Credentials in SharedPreferences are preserved so that WorkManager and
  /// START_STICKY can restart the service automatically — the same recovery
  /// path that fires after a real OS kill.
  ///
  /// Intended for debug/QA use only to verify service-restart behaviour.
  void simulateKill();
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
