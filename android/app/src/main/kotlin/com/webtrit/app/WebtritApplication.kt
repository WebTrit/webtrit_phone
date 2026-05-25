package com.webtrit.app

import android.app.Application
import com.webtrit.callkeep.WebtritCallkeep
import com.webtrit.signaling_service.SignalingForegroundService

/// App-level seam that wires together two independent Flutter plugins:
/// [webtrit_signaling_service_android] and [webtrit_callkeep_android].
///
/// The signaling foreground-service engine is created with `automaticallyRegisterPlugins = false`
/// so that audio/WebRTC plugins do not initialize on a background engine. As a consequence
/// callkeep's plugin is never attached to that engine, so callkeep's application context and its
/// background host channels are not set up there.
///
/// [SignalingForegroundService.onFgsEngineReady] fires (on the main thread) once the
/// foreground-service engine's `BinaryMessenger` is ready. We hand that engine to
/// [WebtritCallkeep.attachToEngine], which performs callkeep's engine-scoped setup. The app stays
/// unaware of callkeep's internal Pigeon channels and context handling; the signaling library
/// stays unaware of callkeep entirely.
class WebtritApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        SignalingForegroundService.onFgsEngineReady = WebtritCallkeep::attachToEngine
    }
}
