package com.webtrit.app

import android.app.Application
import com.webtrit.callkeep.BackgroundPushNotificationIsolateBootstrapApi
import com.webtrit.callkeep.PHostBackgroundPushNotificationIsolateBootstrapApi
import com.webtrit.signaling_service.SignalingForegroundService

class WebtritApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        SignalingForegroundService.onFgsEngineReady = { context, messenger ->
            PHostBackgroundPushNotificationIsolateBootstrapApi.setUp(
                messenger,
                BackgroundPushNotificationIsolateBootstrapApi(context),
            )
        }
    }
}
