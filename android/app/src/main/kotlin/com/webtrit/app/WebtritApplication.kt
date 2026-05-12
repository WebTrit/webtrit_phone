package com.webtrit.app

import android.app.Application
import com.webtrit.callkeep.BackgroundPushNotificationIsolateBootstrapApi
import com.webtrit.callkeep.PHostBackgroundPushNotificationIsolateBootstrapApi
import com.webtrit.callkeep.PHostBackgroundPushNotificationIsolateApi
import com.webtrit.callkeep.models.CallMetadata
import com.webtrit.callkeep.services.core.CallkeepCore
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
            // TODO: move this block into webtrit_callkeep_android — expose a single
            //  WebtritCallkeepPlugin.setUpFgsEngine(context, messenger) entry point so
            //  the app does not need to know about internal Pigeon channels or CallkeepCore.
            // Register the full isolate API on the FGS engine so that releaseCall() /
            // endCall() triggered from onSignalingBackgroundCallEvent reach a handler
            // instead of timing out. Mirrors the CallLifecycleHandler path used in
            // push-bound mode: Dart calls releaseCall() → Kotlin terminates the Telecom
            // connection via CallkeepCore, which stops the ringtone and cleans up state.
            PHostBackgroundPushNotificationIsolateApi.setUp(
                messenger,
                object : PHostBackgroundPushNotificationIsolateApi {
                    override fun releaseCall(callId: String, callback: (Result<Unit>) -> Unit) {
                        CallkeepCore.instance.startDeclineCall(CallMetadata(callId = callId))
                        callback(Result.success(Unit))
                    }

                    override fun endCall(callId: String, callback: (Result<Unit>) -> Unit) {
                        CallkeepCore.instance.startDeclineCall(CallMetadata(callId = callId))
                        callback(Result.success(Unit))
                    }

                    override fun endAllCalls(callback: (Result<Unit>) -> Unit) {
                        CallkeepCore.instance.sendTearDownConnections()
                        callback(Result.success(Unit))
                    }

                    override fun handoffCall(callId: String, callback: (Result<Unit>) -> Unit) {
                        // FGS owns the WebSocket in persistent mode; handoff is not applicable.
                        callback(Result.success(Unit))
                    }
                },
            )
        }
    }
}
