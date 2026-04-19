package com.webtrit.app

import android.app.Application
import com.webtrit.callkeep.BackgroundPushNotificationIsolateBootstrapApi
import com.webtrit.callkeep.PHostBackgroundPushNotificationIsolateBootstrapApi
import com.webtrit.signaling_service.SignalingForegroundService

/// App-level initialization that wires together two independent Flutter plugins:
/// [webtrit_signaling_service_android] and [webtrit_callkeep_android].
///
/// ## Why Kotlin, not Dart
///
/// The FGS (Foreground Service) engine is created with [automaticallyRegisterPlugins=false]
/// to prevent audio/WebRTC plugins from doing hardware initialization on a background engine.
/// As a consequence, [WebtritCallkeepPlugin.onAttachedToEngine] is never called for the FGS
/// engine, so [PHostBackgroundPushNotificationIsolateBootstrapApi] — the Pigeon HOST API that
/// the FGS Dart isolate uses to trigger ringing in persistent mode — is not registered on the
/// FGS engine's binary messenger.
///
/// This registration is a native-only operation ([BinaryMessenger] channel setup); it cannot
/// be initiated from Dart. Doing it via a Pigeon round-trip from Dart would introduce a timing
/// risk: the FGS can start (and receive an incoming call) before Dart has had a chance to make
/// that call. [Application.onCreate] runs before any Flutter engine or Service, making it the
/// earliest and safest place for this wiring.
///
/// ## Initialization split between Dart and Kotlin
///
/// | What                              | Where            | When                        |
/// |-----------------------------------|------------------|-----------------------------|
/// | Signaling config (coreUrl, token) | Dart → Pigeon    | User logs in                |
/// | FGS start/stop                    | Dart → Pigeon    | App lifecycle               |
/// | Sync of FGS state to Dart isolate | Kotlin → Pigeon  | FGS engine ready            |
/// | Callkeep channel on FGS engine    | Kotlin (here)    | Before first FGS start      |
/// | Incoming call ring/notification   | FGS Dart → Pigeon| Incoming WebSocket event    |
///
/// The [onFgsEngineReady] callback is the seam between the two libraries at the app level,
/// keeping [webtrit_signaling_service_android] and [webtrit_callkeep_android] decoupled.
class WebtritApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // Register callkeep's background isolate bootstrap API on the FGS engine's messenger.
        // Called inside SignalingForegroundService.wireUpPigeon() when the FGS engine is ready.
        SignalingForegroundService.onFgsEngineReady = { context, messenger ->
            PHostBackgroundPushNotificationIsolateBootstrapApi.setUp(
                messenger,
                BackgroundPushNotificationIsolateBootstrapApi(context),
            )
        }
    }
}
