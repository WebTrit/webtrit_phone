package com.webtrit.signaling_service

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager
import android.util.Log
import androidx.annotation.Keep
import androidx.core.app.NotificationCompat
import androidx.core.app.ServiceCompat

/// Foreground service that manages the background Flutter engine for signaling.
///
/// Lifecycle:
///   1. [onStartCommand] calls [FlutterEngineHelper.startOrAttachEngine].
///   2. [FlutterEngineHelper] executes the Dart [callbackDispatcher] asynchronously.
///   3. After [startOrAttachEngine] returns, [isolateFlutterApi] is wired up on the
///      background engine's [BinaryMessenger].
///   4a. NEW engine -- the [isolateFlutterApi] setter fires [synchronizeIsolate]
///       immediately, but the Dart isolate has not registered its handler yet so the
///       first call fails. [synchronizeIsolate] retries with linear backoff (up to
///       [_syncMaxRetries] attempts). In parallel, once the Dart [callbackDispatcher]
///       completes [PSignalingServiceFlutterApi.setUp], it calls
///       [WebtritSignalingServicePlugin.notifyIsolateReady], which triggers a fresh
///       [synchronizeIsolate] call -- whichever path succeeds first delivers the status.
///   4b. RE-ATTACHED engine -- the Dart isolate is already running, so the immediate
///       [synchronizeIsolate] call from the setter succeeds directly.
///   5. [onDestroy] releases the wake lock and destroys the engine.
@Keep
class SignalingForegroundService : Service() {

    private lateinit var flutterEngineHelper: FlutterEngineHelper
    private var notificationTitle: String = "Signaling Service"
    private var notificationDescription: String = "Maintaining connection"

    private var _isolateFlutterApi: PSignalingServiceFlutterApi? = null

    /// Setting this property immediately triggers [synchronizeIsolate].
    /// For a re-attached engine the Dart side is already running, so the call
    /// succeeds. For a new engine the first call fails; [synchronizeIsolate] retries
    /// automatically with linear backoff. [WebtritSignalingServicePlugin.notifyIsolateReady]
    /// also triggers [synchronizeIsolate] once the Dart handler is registered.
    private var isolateFlutterApi: PSignalingServiceFlutterApi?
        get() = _isolateFlutterApi
        set(value) {
            _isolateFlutterApi = value
            if (value != null) {
                Log.d(TAG, "isolateFlutterApi set -- triggering immediate synchronize")
                synchronizeIsolate()
            }
        }

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "SignalingForegroundService onCreate")

        instance = this

        val callbackHandle = StorageDelegate.getCallbackDispatcher(applicationContext)
        flutterEngineHelper = FlutterEngineHelper(applicationContext, callbackHandle, this)

        startForeground()
        isRunning = true
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG, "SignalingForegroundService onStartCommand")
        getLock(applicationContext).acquire(10 * 60 * 1000L)

        flutterEngineHelper.startOrAttachEngine()

        // Wire up the Pigeon FlutterApi on the background engine's messenger so that
        // synchronizeIsolate() can send onSynchronize() to the Dart side.
        //
        // For a NEW engine: executeDartCallback is async -- the Dart callbackDispatcher has
        // not run yet. The setter calls synchronizeIsolate() immediately, which will fail;
        // synchronizeIsolate() retries with linear backoff until success or max retries.
        // In parallel, the Dart isolate calls PSignalingServiceHostApi.notifyIsolateReady()
        // once PSignalingServiceFlutterApi.setUp() completes; WebtritSignalingServicePlugin
        // then calls synchronizeIsolate() again -- whichever succeeds first is fine.
        //
        // For a RE-ATTACHED engine: the Dart side is already running, so the immediate
        // synchronizeIsolate() call from the setter succeeds.
        val engine = flutterEngineHelper.backgroundEngine
        if (engine != null && flutterEngineHelper.isEngineAttached) {
            isolateFlutterApi = PSignalingServiceFlutterApi(engine.dartExecutor.binaryMessenger)
        }

        return if (StorageDelegate.isPushBound(applicationContext)) START_NOT_STICKY else START_STICKY
    }

    override fun onDestroy() {
        Log.d(TAG, "SignalingForegroundService onDestroy")
        instance = null
        wakeLock?.let { if (it.isHeld) it.release() }
        stopForeground(STOP_FOREGROUND_REMOVE)
        _isolateFlutterApi = null
        flutterEngineHelper.detachAndDestroyEngine()
        isRunning = false
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onTaskRemoved(rootIntent: Intent?) {
        Log.d(TAG, "onTaskRemoved")
        if (StorageDelegate.isPushBound(applicationContext)) {
            Log.d(TAG, "pushBound mode -- stopping service on task removal")
            gracefulStop { stopSelf() }
        }
    }

    fun configure(title: String, description: String) {
        notificationTitle = title
        notificationDescription = description
    }

    // ---------------------------------------------------------------------------
    // Internal
    // ---------------------------------------------------------------------------

    private fun startForeground() {
        val channelId = createNotificationChannel()
        val notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle(notificationTitle)
            .setContentText(notificationDescription)
            .setSmallIcon(android.R.drawable.ic_dialog_info)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .build()

        // FOREGROUND_SERVICE_TYPE_REMOTE_MESSAGING is the correct type for this service.
        // It maintains a persistent WebSocket to the WebTrit signaling server and never
        // accesses microphone, camera, or location.
        //
        // phoneCall type is not appropriate here: call management via the Telecom API
        // (audio focus, in-call UI) is handled by webtrit_callkeep in the callkeep_core
        // process. This service is the transport layer below the call.
        //
        // Type is only declared on API 34+ (Android 14 / UPSIDE_DOWN_CAKE); on older
        // versions the OS does not enforce a type so 0 is passed.
        ServiceCompat.startForeground(
            this,
            NOTIFICATION_ID,
            notification,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
                ServiceInfo.FOREGROUND_SERVICE_TYPE_REMOTE_MESSAGING
            else 0,
        )
    }

    private fun createNotificationChannel(): String {
        val channelId = "webtrit_signaling_service"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                channelId,
                "Signaling Service",
                NotificationManager.IMPORTANCE_LOW,
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(channel)
        }
        return channelId
    }

    // ---------------------------------------------------------------------------
    // Graceful stop
    // ---------------------------------------------------------------------------

    /// Sends [PSignalingServiceStatus] with [enabled]=false to the background
    /// isolate so it can disconnect the WebSocket cleanly before the service
    /// is destroyed. [onComplete] is invoked once the isolate ACKs the signal
    /// or after [_gracefulStopTimeoutMs] if no ACK arrives.
    ///
    /// If no isolate API is wired up (service not yet started or already torn
    /// down) [onComplete] is called immediately.
    internal fun gracefulStop(onComplete: () -> Unit) {
        val api = _isolateFlutterApi
        if (api == null) {
            Log.d(TAG, "gracefulStop: no isolate API, stopping immediately")
            onComplete()
            return
        }

        Log.d(TAG, "gracefulStop: signalling isolate to stop")

        var settled = false
        val mainHandler = Handler(Looper.getMainLooper())

        fun settle(reason: String) {
            if (settled) return
            settled = true
            Log.d(TAG, "gracefulStop: $reason")
            onComplete()
        }

        mainHandler.postDelayed(
            { settle("timeout after ${_gracefulStopTimeoutMs}ms -- forcing stop") },
            _gracefulStopTimeoutMs,
        )

        api.onSynchronize(
            PSignalingServiceStatus(
                enabled = false,
                coreUrl = "",
                tenantId = "",
                token = "",
                trustedCertificatesJson = null,
                incomingCallHandlerHandle = 0L,
                moduleFactoryHandle = 0L,
            ),
        ) { result ->
            result.onSuccess { settle("isolate ACKed stop signal") }
            result.onFailure { e ->
                Log.w(TAG, "gracefulStop: stop signal failed: $e")
                settle("isolate stop signal failed")
            }
        }
    }

    // ---------------------------------------------------------------------------
    // Synchronize isolate with retry
    // ---------------------------------------------------------------------------

    /// Sends [PSignalingServiceStatus] to the background Dart isolate via Pigeon.
    ///
    /// The call may fail when the isolate Dart handler has not yet been registered
    /// (new engine race). On failure it reschedules itself with exponential backoff
    /// up to [_syncMaxRetries] attempts so that the isolate eventually receives the
    /// status even if the first few attempts arrive before
    /// [PSignalingServiceFlutterApi.setUp] completes in the Dart side.
    ///
    /// Each retry checks [_isolateFlutterApi] again so the loop stops automatically
    /// when [onDestroy] clears the reference.
    internal fun synchronizeIsolate(retryCount: Int = 0) {
        val api = _isolateFlutterApi ?: return
        val coreUrl = StorageDelegate.getCoreUrl(applicationContext)
        val tenantId = StorageDelegate.getTenantId(applicationContext)
        val token = StorageDelegate.getToken(applicationContext)

        Log.d(TAG, "synchronizeIsolate attempt=${retryCount + 1}/$_syncMaxRetries coreUrl=$coreUrl")

        api.onSynchronize(
            PSignalingServiceStatus(
                enabled = true,
                coreUrl = coreUrl,
                tenantId = tenantId,
                token = token,
                trustedCertificatesJson = StorageDelegate.getTrustedCertificatesJson(applicationContext),
                incomingCallHandlerHandle = StorageDelegate.getIncomingCallHandler(applicationContext),
                moduleFactoryHandle = StorageDelegate.getModuleFactoryHandle(applicationContext),
            ),
        ) { result ->
            result.onSuccess {
                Log.d(TAG, "synchronizeIsolate succeeded on attempt ${retryCount + 1}")
            }
            result.onFailure { e ->
                Log.e(TAG, "synchronizeIsolate attempt ${retryCount + 1} failed: $e")
                if (retryCount < _syncMaxRetries - 1 && _isolateFlutterApi != null) {
                    val delayMs = _syncRetryBaseDelayMs * (retryCount + 1)
                    Log.d(TAG, "synchronizeIsolate scheduling retry ${retryCount + 2} in ${delayMs}ms")
                    Handler(Looper.getMainLooper()).postDelayed({
                        if (_isolateFlutterApi != null) synchronizeIsolate(retryCount + 1)
                    }, delayMs)
                } else {
                    Log.e(TAG, "synchronizeIsolate: all $_syncMaxRetries attempts failed, giving up")
                }
            }
        }
    }

    companion object {
        private const val TAG = "SignalingForegroundService"
        private const val NOTIFICATION_ID = 20001
        private const val WAKE_LOCK_TAG = "com.webtrit.signaling_service:SignalingForegroundService.Lock"

        /// Maximum number of synchronizeIsolate attempts before giving up.
        private const val _syncMaxRetries = 6

        /// Base delay between retries (ms). Actual delay = base * (retryCount + 1).
        /// Attempts fire at ~500ms, ~1000ms, ~1500ms, ~2000ms, ~2500ms.
        private const val _syncRetryBaseDelayMs = 500L

        /// How long [gracefulStop] waits for an isolate ACK before forcing the stop.
        private const val _gracefulStopTimeoutMs = 3000L

        var isRunning = false

        /// The currently running service instance, set in [onCreate] and cleared in [onDestroy].
        /// Used by [WebtritSignalingServicePlugin.notifyIsolateReady] so the plugin can trigger
        /// [synchronizeIsolate] when the background Dart isolate signals it is ready.
        @Volatile
        var instance: SignalingForegroundService? = null

        @Volatile
        private var wakeLock: PowerManager.WakeLock? = null

        @Synchronized
        fun getLock(context: Context): PowerManager.WakeLock =
            wakeLock ?: run {
                val mgr = context.applicationContext.getSystemService(Context.POWER_SERVICE) as PowerManager
                mgr.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, WAKE_LOCK_TAG)
                    .apply { setReferenceCounted(false) }
                    .also { wakeLock = it }
            }

        fun start(context: Context) {
            val intent = Intent(context, SignalingForegroundService::class.java)
            context.startForegroundService(intent)
        }

        fun stop(context: Context) {
            context.stopService(Intent(context, SignalingForegroundService::class.java))
        }
    }
}
