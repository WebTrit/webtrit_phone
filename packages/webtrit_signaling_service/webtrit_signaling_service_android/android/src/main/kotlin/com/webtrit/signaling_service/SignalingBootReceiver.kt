package com.webtrit.signaling_service

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.annotation.Keep

/// Restarts [SignalingForegroundService] after device reboot or app update,
/// but only if the service was previously enabled.
@Keep
class SignalingBootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val action = intent.action
        Log.d(TAG, "SignalingBootReceiver onReceive: $action")

        if (action != Intent.ACTION_BOOT_COMPLETED &&
            action != Intent.ACTION_LOCKED_BOOT_COMPLETED &&
            action != "android.intent.action.MY_PACKAGE_REPLACED"
        ) return

        if (StorageDelegate.isPushBound(context)) {
            Log.d(TAG, "pushBound mode -- skipping restart on boot")
            return
        }
        if (StorageDelegate.getCallbackDispatcher(context) == 0L) {
            Log.d(TAG, "callback dispatcher not set -- app never launched, skipping restart on boot")
            return
        }
        if (StorageDelegate.getCoreUrl(context).isEmpty()) {
            Log.d(TAG, "connection credentials not set -- skipping restart on boot to avoid repeated failures")
            return
        }
        SignalingForegroundService.start(context)
    }

    companion object {
        private const val TAG = "SignalingBootReceiver"
    }
}
