package com.webtrit.signaling_service

import android.content.Context
import android.content.SharedPreferences

/// Thin wrapper over [SharedPreferences] for persisting service configuration.
///
/// Keys mirror what the app writes via Dart before starting the service.
object StorageDelegate {
    private const val PREFS_NAME = "webtrit_signaling_service"
    private const val KEY_CALLBACK_DISPATCHER = "callback_dispatcher"
    private const val KEY_ON_SYNC_HANDLER = "on_sync_handler"
    private const val KEY_CORE_URL = "core_url"
    private const val KEY_TENANT_ID = "tenant_id"
    private const val KEY_TOKEN = "token"
    private const val KEY_MODE = "mode"
    private const val KEY_INCOMING_CALL_HANDLER = "incoming_call_handler"
    private val MODE_PUSH_BOUND = PSignalingServiceMode.PUSH_BOUND.name

    private fun prefs(context: Context): SharedPreferences =
        context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    fun saveCallbackDispatcher(context: Context, handle: Long) =
        prefs(context).edit().putLong(KEY_CALLBACK_DISPATCHER, handle).apply()

    fun getCallbackDispatcher(context: Context): Long =
        prefs(context).getLong(KEY_CALLBACK_DISPATCHER, 0L)

    fun saveOnSyncHandler(context: Context, handle: Long) =
        prefs(context).edit().putLong(KEY_ON_SYNC_HANDLER, handle).apply()

    fun getOnSyncHandler(context: Context): Long =
        prefs(context).getLong(KEY_ON_SYNC_HANDLER, 0L)

    fun saveConnectionConfig(context: Context, coreUrl: String, tenantId: String, token: String) {
        prefs(context).edit()
            .putString(KEY_CORE_URL, coreUrl)
            .putString(KEY_TENANT_ID, tenantId)
            .putString(KEY_TOKEN, token)
            .apply()
    }

    fun getCoreUrl(context: Context): String = prefs(context).getString(KEY_CORE_URL, "") ?: ""
    fun getTenantId(context: Context): String = prefs(context).getString(KEY_TENANT_ID, "") ?: ""
    fun getToken(context: Context): String = prefs(context).getString(KEY_TOKEN, "") ?: ""

    fun saveMode(context: Context, mode: PSignalingServiceMode) =
        prefs(context).edit().putString(KEY_MODE, mode.name).apply()

    fun isPushBound(context: Context): Boolean =
        prefs(context).getString(KEY_MODE, null) == MODE_PUSH_BOUND

    fun saveIncomingCallHandler(context: Context, handle: Long) =
        prefs(context).edit().putLong(KEY_INCOMING_CALL_HANDLER, handle).apply()

    fun getIncomingCallHandler(context: Context): Long =
        prefs(context).getLong(KEY_INCOMING_CALL_HANDLER, 0L)

    /// Removes stored credentials so that a reboot after logout does not
    /// restart the service with stale tokens.
    fun clearConnectionConfig(context: Context) {
        prefs(context).edit()
            .remove(KEY_CORE_URL)
            .remove(KEY_TENANT_ID)
            .remove(KEY_TOKEN)
            .apply()
    }
}
