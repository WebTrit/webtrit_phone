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
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.ProcessLifecycleOwner
import io.flutter.plugin.common.BinaryMessenger

/// Foreground service that manages the background Flutter engine for signaling.
///
/// Lifecycle:
///   1. [onStartCommand] checks [FlutterEngineHelper.attachExistingIfNeeded].
///      - If an engine already exists it is (re-)attached and Pigeon channels are wired
///        immediately on the calling thread; [onStartCommand] returns normally.
///      - If no engine exists yet, [FlutterEngineHelper.initializeFlutterEngine] is
///        posted to the main-thread [Handler] so [onStartCommand] returns immediately
///        without blocking. The FlutterEngine constructor (≈1-2 s of JNI/AOT work)
///        runs in the next main-thread iteration; Pigeon wiring follows in the same post.
///      If the stored callback handle is stale (APK update), [FlutterEngineHelper.hasInvalidHandle]
///      is set; the service clears the handle and stops so the main app can refresh it.
///   2. [FlutterEngineHelper] executes the Dart [callbackDispatcher] asynchronously.
///   3. Once Pigeon channels are wired on the FGS engine ([wireUpPigeon]):
///      - [FgsHostApiHandler] registers [PSignalingServiceHostApi] so FGS Dart can call
///        [notifyIsolateReady] back into Kotlin (dropped silently without this on Android 16).
///      - [isolateFlutterApi] is set, which arms the [_startupWatchdogTimeoutMs] watchdog and
///        fires an immediate [synchronizeIsolate].
///   4a. NEW engine -- Dart may not have registered its handler yet. [synchronizeIsolate] uses
///       timer-based retries (not callback-driven) so the retry fires even when Flutter silently
///       drops the message. Once the Dart isolate calls [notifyIsolateReady], [FgsHostApiHandler]
///       resets the cycle and a fresh [synchronizeIsolate] succeeds, cancelling the watchdog.
///   4b. RE-ATTACHED engine -- Dart is already running, so the immediate [synchronizeIsolate]
///       succeeds and the watchdog is cancelled right away.
///   5. If no successful sync arrives within [_startupWatchdogTimeoutMs], the watchdog fires
///      [stopSelf]. [onDestroy] re-enqueues a WorkManager restart (if credentials are present),
///      mirroring Drift's isolate.kill() + retry pattern.
///   6. [onDestroy] cancels the watchdog, releases the wake lock, and destroys the engine.
@Keep
class SignalingForegroundService : Service() {

    private lateinit var flutterEngineHelper: FlutterEngineHelper
    private var notificationTitle: String = "Signaling Service"
    private var notificationDescription: String = "Maintaining connection"

    private var _isolateFlutterApi: PSignalingServiceFlutterApi? = null

    /// Guards against posting a second engine-init block if [onStartCommand] is called
    /// again before the already-posted block runs.
    /// Accessed only on the main thread.
    private var _engineInitPending = false

    private var _isForeground = false

    private val _appLifecycleObserver = object : DefaultLifecycleObserver {
        override fun onStart(owner: LifecycleOwner) = suppressNotification()
        override fun onStop(owner: LifecycleOwner) = restoreNotification()
    }

    /// Set to true by the startup watchdog Runnable (after [stopSelf] is called).
    /// Prevents [startStartupWatchdog] from re-arming in the brief window between
    /// [stopSelf] and [onDestroy], and prevents the deferred engine-init post from
    /// calling [wireUpPigeon] on an already-dying service.
    /// Accessed only on the main thread.
    private var _stopPending = false

    /// Tracks whether the current sync cycle has delivered status to the Dart isolate.
    /// Set to true when [synchronizeIsolate] receives a success callback; reset to false
    /// at the start of each new cycle (new engine or [notifyIsolateReady]).
    /// Prevents timer-based retries from firing after delivery is confirmed, and drives
    /// the startup watchdog decision.
    private var _syncSucceeded = false

    /// Shared main-thread handler for both the startup watchdog and sync retries.
    /// Reusing one Handler avoids per-retry allocations and allows all pending callbacks
    /// to be cancelled together on teardown.
    private val _mainHandler = Handler(Looper.getMainLooper())

    /// Pending watchdog runnable — cancelled when sync succeeds or on teardown.
    private var _watchdogRunnable: Runnable? = null

    /// Pending sync-retry runnables — tracked so they can be cancelled when a new sync
    /// cycle starts ([notifyIsolateReady], new [isolateFlutterApi]) or on teardown.
    private val _syncRetryRunnables = mutableListOf<Runnable>()

    /// Setting this property resets the sync cycle, arms the startup watchdog, and fires
    /// an immediate [synchronizeIsolate].
    private var isolateFlutterApi: PSignalingServiceFlutterApi?
        get() = _isolateFlutterApi
        set(value) {
            _isolateFlutterApi = value
            if (value != null) {
                _syncSucceeded = false
                cancelSyncRetries()
                Log.d(TAG, "isolateFlutterApi set -- arming watchdog and triggering synchronize")
                startStartupWatchdog()
                synchronizeIsolate()
            } else {
                cancelSyncRetries()
                cancelStartupWatchdog()
            }
        }

    override fun onCreate() {
        super.onCreate()
        startForeground()
        ProcessLifecycleOwner.get().lifecycle.addObserver(_appLifecycleObserver)
        if (ProcessLifecycleOwner.get().lifecycle.currentState.isAtLeast(Lifecycle.State.STARTED)) {
            suppressNotification()
        }
        Log.d(TAG, "SignalingForegroundService onCreate")
        instance = this
        val callbackHandle = StorageDelegate.getCallbackDispatcher(applicationContext)
        flutterEngineHelper = FlutterEngineHelper(applicationContext, callbackHandle, this)
        isRunning = true
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG, "SignalingForegroundService onStartCommand")

        // Path 4 guard: stopService() arrived in the Pigeon FIFO queue before this
        // service's H.CREATE_SERVICE ran (main thread was overloaded). The plugin
        // deferred the stop because calling context.stopService() at that point would
        // crash — the service had not yet called startForeground(). onCreate() already
        // called startForeground() so we can stop safely now without a crash.
        if (WebtritSignalingServicePlugin.consumeStopRequested()) {
            Log.w(TAG, "onStartCommand: deferred stop detected — stopping after startForeground()")
            gracefulStop { stopSelf() }
            return START_NOT_STICKY
        }

        getLock(applicationContext).acquire(10 * 60 * 1000L)

        // Fast path: engine already exists — attach if needed and wire Pigeon immediately.
        if (flutterEngineHelper.attachExistingIfNeeded()) {
            val alreadyWired = _isolateFlutterApi != null
            wireUpPigeon()
            if (alreadyWired) {
                // Service was already running when startService() was called again.
                // Send a sync so the FGS Dart isolate can reconnect the WebSocket if it
                // dropped while the app was backgrounded (e.g. screen unlock in PUSH_BOUND).
                // The watchdog is not re-armed: the isolate is already initialised.
                //
                // Reset _syncSucceeded so timer-based retries work correctly.
                // After a successful initial sync _syncSucceeded == true, which causes
                // every retry runnable to evaluate !_syncSucceeded == false and return
                // immediately — leaving a single Pigeon message as the only attempt.
                // If that message is dropped (e.g. under memory pressure on MIUI) no
                // reconnect fires. Resetting here restores the full retry cycle.
                _syncSucceeded = false
                cancelSyncRetries()
                synchronizeIsolate()
            }
            return if (StorageDelegate.isPushBound(applicationContext)) START_NOT_STICKY else START_STICKY
        }

        // Slow path: engine must be created. FlutterEngine() requires @UiThread, so it must
        // run on the main thread. Post it to the next main-thread iteration so onStartCommand
        // returns immediately — avoids blocking the calling thread for the full ≈1-2 s of
        // JNI/AOT initialisation (the source of MIUI / One UI start-command timeouts).
        if (_engineInitPending) {
            Log.d(TAG, "onStartCommand: engine init already pending — skipping duplicate")
            return if (StorageDelegate.isPushBound(applicationContext)) START_NOT_STICKY else START_STICKY
        }

        _engineInitPending = true
        Log.d(TAG, "onStartCommand: posting FlutterEngine init to main thread (deferred)")
        _mainHandler.post {
            try {
                flutterEngineHelper.initializeFlutterEngine()
            } finally {
                _engineInitPending = false
            }
            if (!isRunning) {
                Log.w(TAG, "engine init: service already destroyed — cleaning up engine")
                flutterEngineHelper.detachAndDestroyEngine()
                return@post
            }
            // Guard: stale callback handle after APK update.
            // START_STICKY can restart the FGS before the main app runs, so the handle in
            // SharedPreferences may belong to a previous build (lookupCallbackInformation → null).
            // Clear the handle so onDestroy does not loop via WorkManager, then stop.
            // The main app will write a fresh handle via initializeServiceCallback() and restart.
            if (flutterEngineHelper.hasInvalidHandle) {
                Log.w(TAG, "engine init: stale callback handle — clearing and stopping")
                StorageDelegate.saveCallbackDispatcher(applicationContext, 0L)
                stopSelf()
                return@post
            }
            if (flutterEngineHelper.backgroundEngine == null) {
                // Engine creation failed for an unexpected reason (exception during init).
                // Stop without clearing the handle so onDestroy / WorkManager can retry.
                Log.w(TAG, "engine init: engine not created — stopping, onDestroy/WorkManager may retry")
                stopSelf()
                return@post
            }
            wireUpPigeon()
        }

        return if (StorageDelegate.isPushBound(applicationContext)) START_NOT_STICKY else START_STICKY
    }

    /// Registers Pigeon channels on the FGS engine's binary messenger.
    ///
    /// Must be called on the main thread once [FlutterEngineHelper.backgroundEngine] is non-null.
    ///
    /// - [FgsHostApiHandler] registers [PSignalingServiceHostApi] so the FGS Dart isolate can
    ///   call [notifyIsolateReady] back into Kotlin (silently dropped without this on Android 16).
    /// - Setting [isolateFlutterApi] arms the startup watchdog and fires [synchronizeIsolate].
    private fun wireUpPigeon() {
        if (_isolateFlutterApi != null) {
            Log.d(TAG, "wireUpPigeon: already wired — skipping duplicate")
            return
        }
        val engine = flutterEngineHelper.backgroundEngine ?: run {
            Log.w(TAG, "wireUpPigeon: engine is null — skipping")
            return
        }
        Log.d(TAG, "wireUpPigeon: registering Pigeon channels on FGS engine")
        try {
            onFgsEngineReady?.invoke(applicationContext, engine.dartExecutor.binaryMessenger)
        } catch (e: Exception) {
            Log.e(TAG, "wireUpPigeon: onFgsEngineReady hook threw — continuing without it", e)
        }
        PSignalingServiceHostApi.setUp(engine.dartExecutor.binaryMessenger, FgsHostApiHandler())
        isolateFlutterApi = PSignalingServiceFlutterApi(engine.dartExecutor.binaryMessenger)
    }

    override fun onDestroy() {
        ProcessLifecycleOwner.get().lifecycle.removeObserver(_appLifecycleObserver)
        // Enqueue restart before any teardown so the job is queued while the process is still valid.
        // Credentials guard: stopService() calls clearConnectionConfig() before stopping the service,
        // so after explicit logout coreUrl is already empty here and no job is scheduled.
        if (!StorageDelegate.isPushBound(applicationContext) &&
            StorageDelegate.getCoreUrl(applicationContext).isNotEmpty() &&
            StorageDelegate.getTenantId(applicationContext).isNotEmpty() &&
            StorageDelegate.getToken(applicationContext).isNotEmpty() &&
            StorageDelegate.getCallbackDispatcher(applicationContext) != 0L
        ) {
            SignalingRestartWorker.enqueue(applicationContext, delayMillis = 15_000)
        }
        Log.d(TAG, "SignalingForegroundService onDestroy")
        cancelSyncRetries()
        cancelStartupWatchdog()
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
        } else if (StorageDelegate.getCoreUrl(applicationContext).isNotEmpty() &&
                   StorageDelegate.getTenantId(applicationContext).isNotEmpty() &&
                   StorageDelegate.getToken(applicationContext).isNotEmpty() &&
                   StorageDelegate.getCallbackDispatcher(applicationContext) != 0L) {
            // persistent mode -- enqueue a fast restart in case the OS doesn't honour START_STICKY.
            // REPLACE resets any accumulated backoff: task removal is a UI action, not a
            // connection failure, so an immediate retry is appropriate.
            SignalingRestartWorker.enqueue(
                applicationContext,
                delayMillis = 1_000,
                policy = androidx.work.ExistingWorkPolicy.REPLACE,
            )
        }
    }

    fun configure(title: String, description: String) {
        notificationTitle = title
        notificationDescription = description
    }

    internal fun suppressNotification() {
        if (!_isForeground) return
        if (!StorageDelegate.isPushBound(applicationContext)) return
        stopForeground(STOP_FOREGROUND_REMOVE)
        _isForeground = false
        Log.d(TAG, "notification suppressed (app in foreground)")
    }

    internal fun restoreNotification() {
        if (_isForeground) return
        if (!StorageDelegate.isPushBound(applicationContext)) return
        startForeground()
        Log.d(TAG, "notification restored (app going to background)")
    }

    /// Stops the service immediately without signalling the background isolate,
    /// simulating an abrupt OS kill.
    ///
    /// Unlike [gracefulStop], this does not send a disconnect signal to the
    /// Dart isolate first. Credentials in SharedPreferences are preserved so
    /// that [SignalingRestartWorker] and START_STICKY can restart the service —
    /// the same recovery path that fires after a real OS kill.
    fun simulateKill() {
        Log.d(TAG, "simulateKill -- calling stopSelf() without graceful disconnect")
        stopSelf()
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

        // FOREGROUND_SERVICE_TYPE_REMOTE_MESSAGING: this service maintains a persistent
        // WebSocket to the WebTrit signaling server so it can receive call-signaling
        // messages (SDP, ICE candidates, call events) at any time. The remoteMessaging
        // type is the Android-defined category for exactly this use case.
        // Passed to startForeground() on API 34+ only; older versions pass 0 and do
        // not enforce a foreground service type here.
        ServiceCompat.startForeground(
            this,
            NOTIFICATION_ID,
            notification,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
                ServiceInfo.FOREGROUND_SERVICE_TYPE_REMOTE_MESSAGING
            else 0,
        )
        _isForeground = true
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
    // Startup watchdog (mirrors Drift's completer.future.timeout(30s))
    // ---------------------------------------------------------------------------

    private fun startStartupWatchdog() {
        // Idempotent: if a watchdog is already ticking, do not reset it.
        // Resetting on every onStartCommand would prevent the watchdog from ever firing
        // when the Dart isolate fails to start — onServiceDead calls startService every
        // ~15 s, which would continuously push the deadline out.
        // The watchdog is only explicitly cancelled + re-armed in notifyIsolateReady()
        // (isolate confirmed alive → give the fresh sync a full 30 s window) and in
        // the reconnect path (watchdog was cancelled by a prior successful sync, so
        // _watchdogRunnable is null and arming here is correct).
        if (_watchdogRunnable != null || _stopPending) {
            Log.d(TAG, "Startup watchdog already armed or stop pending — not resetting")
            return
        }
        val r = object : Runnable {
            override fun run() {
                _watchdogRunnable = null
                if (!_syncSucceeded) {
                    Log.e(TAG, "Startup watchdog: no successful sync in ${_startupWatchdogTimeoutMs}ms — stopping")
                    _stopPending = true
                    stopSelf()
                }
            }
        }
        _watchdogRunnable = r
        _mainHandler.postDelayed(r, _startupWatchdogTimeoutMs)
        Log.d(TAG, "Startup watchdog armed (${_startupWatchdogTimeoutMs}ms)")
    }

    private fun cancelStartupWatchdog() {
        _watchdogRunnable?.let { _mainHandler.removeCallbacks(it) }
        _watchdogRunnable = null
    }

    private fun cancelSyncRetries() {
        _syncRetryRunnables.forEach { _mainHandler.removeCallbacks(it) }
        _syncRetryRunnables.clear()
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
                mode = PSignalingServiceMode.PERSISTENT,
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
    // FGS HostApi handler (Dart → Kotlin via the FGS engine's messenger)
    // ---------------------------------------------------------------------------

    /// Called by [FgsHostApiHandler] when the FGS Dart isolate confirms its Pigeon
    /// handler is registered and ready to receive [onSynchronize] calls.
    /// Resets [_syncSucceeded], gives the fresh sync cycle a full [_startupWatchdogTimeoutMs]
    /// window by explicitly cancelling and re-arming the watchdog, then triggers
    /// [synchronizeIsolate] — this one succeeds because Dart just completed
    /// [PSignalingServiceFlutterApi.setUp].
    internal fun notifyIsolateReady() {
        if (_syncSucceeded) {
            Log.d(TAG, "notifyIsolateReady: sync already succeeded — ignoring")
            return
        }
        Log.d(TAG, "notifyIsolateReady -- FGS Dart handler ready, triggering synchronize")
        _syncSucceeded = false
        cancelSyncRetries()
        // Explicitly reset the watchdog so the sync triggered below has a full 30 s
        // window regardless of how much time elapsed since engine creation.
        cancelStartupWatchdog()
        startStartupWatchdog()
        synchronizeIsolate()
    }

    /// Minimal [PSignalingServiceHostApi] registered on the FGS engine's binary messenger
    /// so the FGS Dart isolate can call [notifyIsolateReady].
    ///
    /// [WebtritSignalingServicePlugin] registers the same interface on the MAIN engine
    /// (via GeneratedPluginRegistrant), handling all lifecycle calls from the main isolate.
    /// This inner class handles only [notifyIsolateReady], the sole call originating from
    /// the FGS Dart isolate. On Android 16, messages sent to an unregistered channel are
    /// dropped silently — without this handler the FGS Dart → Kotlin path is broken.
    private inner class FgsHostApiHandler : PSignalingServiceHostApi {
        override fun notifyIsolateReady() = this@SignalingForegroundService.notifyIsolateReady()
        override fun initializeServiceCallback(callbackDispatcher: Long, onSync: Long) {}
        override fun saveConnectionConfig(coreUrl: String, tenantId: String, token: String) {}
        override fun saveTrustedCertificates(certificatesJson: String?) {}
        override fun saveIncomingCallHandler(callbackHandle: Long) {}
        override fun saveModuleFactory(callbackHandle: Long) {}
        override fun configureService(notificationTitle: String, notificationDescription: String) {}
        override fun startService(mode: PSignalingServiceMode) {}
        override fun stopService() {}
        override fun connect() {}
        override fun simulateKill() {}
    }

    // ---------------------------------------------------------------------------
    // Synchronize isolate with timer-based retry
    // ---------------------------------------------------------------------------

    /// Sends [PSignalingServiceStatus] to the background Dart isolate via Pigeon.
    ///
    /// Uses timer-based retries rather than callback-driven ones: the next attempt is
    /// scheduled via [Handler.postDelayed] regardless of whether the Pigeon callback
    /// executes. On Android 16, messages sent before Dart registers its handler are
    /// DROPPED silently — the callback lambda never runs, so a callback-driven retry
    /// would never fire. The timer below handles that race.
    ///
    /// Once [_syncSucceeded] is true (callback confirmed delivery), all pending timers
    /// become no-ops and the startup watchdog is cancelled.
    /// [notifyIsolateReady] resets [_syncSucceeded] and starts a fresh cycle when the
    /// Dart isolate signals its handler is ready.
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
                mode = if (StorageDelegate.isPushBound(applicationContext)) PSignalingServiceMode.PUSH_BOUND else PSignalingServiceMode.PERSISTENT,
            ),
        ) { result ->
            result.onSuccess {
                Log.d(TAG, "synchronizeIsolate succeeded on attempt ${retryCount + 1}")
                _syncSucceeded = true
                cancelSyncRetries()
                cancelStartupWatchdog()
            }
            result.onFailure { e ->
                Log.e(TAG, "synchronizeIsolate attempt ${retryCount + 1} failed (callback): $e")
            }
        }

        // Timer-based retry: fires regardless of whether the Pigeon callback ran.
        // Reuses _mainHandler to avoid per-retry allocations; the Runnable is tracked
        // in _syncRetryRunnables so it can be cancelled on teardown or new sync cycle.
        if (retryCount < _syncMaxRetries - 1) {
            val delayMs = _syncRetryBaseDelayMs * (retryCount + 1)
            Log.d(TAG, "synchronizeIsolate scheduling safety retry ${retryCount + 2} in ${delayMs}ms")
            val r = Runnable {
                if (!_syncSucceeded && _isolateFlutterApi != null) synchronizeIsolate(retryCount + 1)
            }
            _syncRetryRunnables += r
            _mainHandler.postDelayed(r, delayMs)
        } else if (!_syncSucceeded) {
            Log.e(TAG, "synchronizeIsolate: all $_syncMaxRetries attempts exhausted")
        }
    }

    companion object {
        private const val TAG = "SignalingForegroundService"
        private const val NOTIFICATION_ID = 20001
        private const val WAKE_LOCK_TAG = "com.webtrit.signaling_service:SignalingForegroundService.Lock"

        /// Maximum number of [synchronizeIsolate] timer-based attempts before giving up.
        private const val _syncMaxRetries = 6

        /// Base delay between retries (ms). Actual delay = base × (retryCount + 1).
        /// Attempts fire at ~500 ms, ~1 000 ms, ~1 500 ms, ~2 000 ms, ~2 500 ms.
        private const val _syncRetryBaseDelayMs = 500L

        /// How long [gracefulStop] waits for an isolate ACK before forcing the stop.
        private const val _gracefulStopTimeoutMs = 3000L

        /// Mirrors Drift's completer.future.timeout(30s): if no successful sync is
        /// received within this window, the service stops so WorkManager can retry.
        private const val _startupWatchdogTimeoutMs = 30_000L

        @Volatile var isRunning = false

        /// The currently running service instance, set in [onCreate] and cleared in [onDestroy].
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

        /// Optional callback invoked on the main thread inside [wireUpPigeon], immediately
        /// before the two built-in Pigeon channels are registered on the FGS engine.
        ///
        /// Use this to register additional Pigeon HOST APIs on the FGS engine without
        /// coupling [SignalingForegroundService] to other plugins.
        ///
        /// Example — registering webtrit_callkeep's bootstrap API (set in Application.onCreate):
        /// ```kotlin
        /// SignalingForegroundService.onFgsEngineReady = { context, messenger ->
        ///     PHostBackgroundPushNotificationIsolateBootstrapApi.setUp(
        ///         messenger, BackgroundPushNotificationIsolateBootstrapApi(context))
        /// }
        /// ```
        @Volatile
        var onFgsEngineReady: ((Context, BinaryMessenger) -> Unit)? = null
    }
}
