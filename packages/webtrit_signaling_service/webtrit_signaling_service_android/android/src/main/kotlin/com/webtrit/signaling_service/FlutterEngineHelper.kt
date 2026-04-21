package com.webtrit.signaling_service

import android.content.Context
import android.util.Log
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.plugin.platform.PlatformViewsController
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

            val dartEntrypoint = DartEntrypoint(
                flutterLoader.findAppBundlePath(),
                callbackInformation.callbackLibraryPath,
                callbackInformation.callbackName,
            )

            // If the main engine is running, spawn a child isolate from it.
            //
            // FlutterEngineGroup.createAndRunEngine uses FlutterJNI.spawn() only for
            // non-first engines. For the first engine it falls back to
            // executeDartEntrypoint, which calls Dart_LookupLibrary("package:...") on a
            // fresh isolate group — this lookup fails in AOT mode because package URIs are
            // not registered in a newly created group. Spawn from the main engine bypasses
            // that lookup: it creates a sibling isolate in the existing Dart VM where the
            // library table is already populated.
            //
            // When no main engine is present (e.g. push-notification cold start), the
            // FlutterEngineGroup fallback is safe: there is no existing root isolate so
            // executeDartEntrypoint can create one without conflict.
            //
            // FlutterEngine.spawn() is package-private; reflection is used to reach it
            // from outside io.flutter.embedding.engine.
            val mainEngine = WebtritSignalingServicePlugin.mainFlutterEngine
            backgroundEngine = if (mainEngine != null && mainEngine.dartExecutor.isExecutingDart) {
                Log.d(TAG, "Spawning background engine from main engine (sibling isolate)")
                spawnFromEngine(mainEngine, dartEntrypoint)
            } else {
                Log.d(TAG, "No active main engine — creating via FlutterEngineGroup (root isolate)")
                getOrCreateEngineGroup(context).createAndRunEngine(
                    FlutterEngineGroup.Options(context.applicationContext)
                        .setDartEntrypoint(dartEntrypoint)
                        .setAutomaticallyRegisterPlugins(false)
                )
            }.also { engine ->
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

    private fun spawnFromEngine(parent: FlutterEngine, entrypoint: DartEntrypoint): FlutterEngine {
        val spawnMethod = FlutterEngine::class.java.getDeclaredMethod(
            "spawn",
            Context::class.java,
            DartEntrypoint::class.java,
            String::class.java,
            List::class.java,
            PlatformViewsController::class.java,
            Boolean::class.javaPrimitiveType,
            Boolean::class.javaPrimitiveType,
        )
        spawnMethod.isAccessible = true
        return spawnMethod.invoke(
            parent,
            context,
            entrypoint,
            null,                        // initialRoute
            null,                        // dartEntrypointArgs
            PlatformViewsController(),   // must be non-null — FlutterEngine constructor dereferences it
            false,                       // automaticallyRegisterPlugins
            false,                       // waitForRestorationData
        ) as FlutterEngine
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
