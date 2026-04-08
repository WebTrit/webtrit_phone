package com.webtrit.signaling_service

import android.content.Context
import android.util.Log
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
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

            backgroundEngine = FlutterEngine(context.applicationContext).also { engine ->
                val callbackInformation = FlutterCallbackInformation.lookupCallbackInformation(callbackHandle)
                if (callbackInformation != null) {
                    val dartCallback = DartCallback(
                        context.assets,
                        flutterLoader.findAppBundlePath(),
                        callbackInformation,
                    )
                    engine.dartExecutor.executeDartCallback(dartCallback)
                    engine.serviceControlSurface.attachToService(service, null, true)
                    isEngineAttached = true
                    Log.d(TAG, "FlutterEngine initialized and attached successfully")
                } else {
                    Log.e(TAG, "Invalid callback handle: $callbackHandle")
                }
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
