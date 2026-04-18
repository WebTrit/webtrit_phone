package com.webtrit.signaling_service

import android.content.Context
import android.util.Log
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.dart.DartExecutor.DartCallback
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

    fun startOrAttachEngine() {
        when {
            backgroundEngine == null -> {
                Log.d(TAG, "Initializing new FlutterEngine")
                initializeFlutterEngine()
            }
            !isEngineAttached -> {
                Log.d(TAG, "Reattaching existing FlutterEngine")
                attachEngine()
            }
            else -> Log.d(TAG, "FlutterEngine already initialized and attached")
        }
    }

    private fun initializeFlutterEngine() {
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
            // automaticallyRegisterPlugins=false: prevents GeneratedPluginRegistrant from
            // registering all app plugins (AudioSessionPlugin, FlutterWebRTCPlugin, etc.)
            // on this background FGS engine. On Android 16 REMOTE_MESSAGING services,
            // audio/hardware init in onAttachedToEngine blocks the Dart VM from running
            // the background entry point. Only the two Pigeon channels set up manually
            // in onStartCommand are needed here.
            // FlutterJNI() is passed explicitly — the parameter is @NonNull in the Flutter
            // Java API; relying on null handling would bypass the annotation contract.
            backgroundEngine = FlutterEngine(context.applicationContext, null, FlutterJNI(), null, false).also { engine ->
                val dartCallback = DartCallback(
                    context.assets,
                    flutterLoader.findAppBundlePath(),
                    callbackInformation,
                )
                engine.dartExecutor.executeDartCallback(dartCallback)
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
    }
}
