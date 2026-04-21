package com.webtrit.signaling_service

import android.content.Context
import android.util.Log
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.view.FlutterCallbackInformation

class FlutterEngineHelper(
    private val context: Context,
    private val callbackHandle: Long,
    private val service: android.app.Service,
) {
    var backgroundEngine: FlutterEngine? = null
        private set

    var isEngineAttached: Boolean = false
        private set

    /// True when [initializeFlutterEngine] was called but the stored callback handle
    /// resolved to null — the handle is stale (e.g. after an APK update).
    /// The caller should stop the service and clear the stored handle so the main app
    /// can write a fresh handle before restarting.
    var hasInvalidHandle: Boolean = false
        private set

    /// Attaches an existing engine to the service if one already exists.
    ///
    /// Returns true if an engine was already present (attached or re-attached),
    /// false if no engine exists yet and [initializeFlutterEngine] must be called.
    fun attachExistingIfNeeded(): Boolean {
        return when {
            backgroundEngine == null -> false
            !isEngineAttached -> {
                Log.d(TAG, "Reattaching existing FlutterEngine")
                attachEngine()
                true
            }
            else -> {
                Log.d(TAG, "FlutterEngine already initialized and attached")
                true
            }
        }
    }

    internal fun initializeFlutterEngine() {
        try {
            val flutterLoader = FlutterInjector.instance().flutterLoader()
            if (!flutterLoader.initialized()) {
                flutterLoader.startInitialization(context.applicationContext)
            }
            flutterLoader.ensureInitializationComplete(context.applicationContext, null)

            // Resolve the callback handle BEFORE creating the engine so we never leave
            // a FlutterEngine with no Dart entry point. A null result means the handle
            // in SharedPreferences is from a previous APK build (stale after an update).
            // Inspired by Drift's pattern: validate config before spawning the worker.
            val callbackInformation = FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
            if (callbackInformation == null) {
                Log.e(TAG, "Invalid callback handle $callbackHandle — skipping engine creation")
                hasInvalidHandle = true
                return
            }

            hasInvalidHandle = false
            Log.d(TAG, "makeEngine: handle=$callbackHandle " +
                "library=${callbackInformation.callbackLibraryPath} " +
                "function=${callbackInformation.callbackName}")

            // Use FlutterEngineGroup so the background isolate shares the process-wide Dart
            // VM rather than attempting to spawn an independent root isolate via
            // executeDartCallback. On some Samsung Android 13 devices, executeDartCallback
            // silently fails to start the Dart isolate when the main FlutterEngine is already
            // running in the same process (multi-engine conflict at the Dart VM level).
            // FlutterEngineGroup.createAndRunEngine uses FlutterJNI.spawn() for all but the
            // first engine, which creates a proper child isolate that reliably starts alongside
            // the main engine's isolate.
            // Options.setAutomaticallyRegisterPlugins(false) keeps audio/hardware plugins from
            // blocking the Dart VM on Android 16+ REMOTE_MESSAGING services.
            val dartEntrypoint = DartEntrypoint(
                flutterLoader.findAppBundlePath(),
                callbackInformation.callbackLibraryPath,
                callbackInformation.callbackName,
            )
            val options = FlutterEngineGroup.Options(context.applicationContext)
                .setDartEntrypoint(dartEntrypoint)
                .setAutomaticallyRegisterPlugins(false)
            backgroundEngine = getOrCreateEngineGroup(context)
                .createAndRunEngine(options)
                .also { engine ->
                    engine.serviceControlSurface.attachToService(service, null, true)
                    isEngineAttached = true
                    Log.d(TAG, "FlutterEngine initialized and attached successfully")
                }
        } catch (e: Exception) {
            Log.e(TAG, "Failed to initialize FlutterEngine", e)
        }
    }

    private fun attachEngine() {
        backgroundEngine?.serviceControlSurface?.attachToService(service, null, true)
        isEngineAttached = true
        Log.d(TAG, "FlutterEngine reattached successfully")
    }

    fun detachAndDestroyEngine() {
        backgroundEngine?.serviceControlSurface?.detachFromService()
        backgroundEngine?.destroy()
        backgroundEngine = null
        isEngineAttached = false
        Log.d(TAG, "FlutterEngine detached and destroyed")
    }

    companion object {
        private const val TAG = "FlutterEngineHelper"

        @Volatile
        private var engineGroup: FlutterEngineGroup? = null

        // Double-checked locking: engineGroup is written once and only read afterwards,
        // so the volatile + synchronized pair is safe without a full lock on every read.
        private fun getOrCreateEngineGroup(context: Context): FlutterEngineGroup =
            engineGroup ?: synchronized(this) {
                engineGroup ?: FlutterEngineGroup(context.applicationContext).also { engineGroup = it }
            }
    }
}
