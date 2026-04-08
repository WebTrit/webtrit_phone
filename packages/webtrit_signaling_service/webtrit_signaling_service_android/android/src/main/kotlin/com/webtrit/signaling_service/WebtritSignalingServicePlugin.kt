package com.webtrit.signaling_service

import android.content.Context
import android.util.Log
import androidx.annotation.Keep
import io.flutter.embedding.engine.plugins.FlutterPlugin

// NOTE: PSignalingServiceHostApi and PSignalingServiceFlutterApi are generated
// by running:  dart run pigeon --input pigeons/signaling.messages.dart
// Until Pigeon is run, these classes do not exist and this file will not compile.

/// Flutter plugin entry point for the webtrit_signaling_service package.
///
/// Registers the Pigeon [PSignalingServiceHostApi] so Dart can call lifecycle
/// methods (initializeServiceCallback, configureService, startService, stopService).
///
/// Also sets up [PSignalingServiceFlutterApi] on the background engine so
/// [SignalingForegroundService] can call back into the Dart isolate via
/// [onSynchronize] after the engine is ready.
@Keep
class WebtritSignalingServicePlugin : FlutterPlugin, PSignalingServiceHostApi {

    private lateinit var context: Context
    private var notificationTitle: String = "Signaling Service"
    private var notificationDescription: String = "Maintaining connection"

    // ---------------------------------------------------------------------------
    // FlutterPlugin
    // ---------------------------------------------------------------------------

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        PSignalingServiceHostApi.setUp(binding.binaryMessenger, this)
        Log.d(TAG, "WebtritSignalingServicePlugin attached")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        PSignalingServiceHostApi.setUp(binding.binaryMessenger, null)
        Log.d(TAG, "WebtritSignalingServicePlugin detached")
    }

    // ---------------------------------------------------------------------------
    // PSignalingServiceHostApi
    // ---------------------------------------------------------------------------

    override fun initializeServiceCallback(callbackDispatcher: Long, onSync: Long) {
        Log.d(TAG, "initializeServiceCallback dispatcher=$callbackDispatcher onSync=$onSync")
        StorageDelegate.saveCallbackDispatcher(context, callbackDispatcher)
        StorageDelegate.saveOnSyncHandler(context, onSync)
    }

    override fun saveConnectionConfig(coreUrl: String, tenantId: String, token: String) {
        Log.d(TAG, "saveConnectionConfig coreUrl=$coreUrl tenantId=$tenantId")
        StorageDelegate.saveConnectionConfig(context, coreUrl, tenantId, token)
    }

    override fun saveIncomingCallHandler(callbackHandle: Long) {
        Log.d(TAG, "saveIncomingCallHandler handle=$callbackHandle")
        StorageDelegate.saveIncomingCallHandler(context, callbackHandle)
    }

    override fun saveModuleFactory(callbackHandle: Long) {
        Log.d(TAG, "saveModuleFactory handle=$callbackHandle")
        StorageDelegate.saveModuleFactoryHandle(context, callbackHandle)
    }

    override fun saveTrustedCertificates(certificatesJson: String?) {
        Log.d(TAG, "saveTrustedCertificates json=${if (certificatesJson != null) "${certificatesJson.length} chars" else "null"}")
        StorageDelegate.saveTrustedCertificatesJson(context, certificatesJson)
    }

    override fun configureService(notificationTitle: String, notificationDescription: String) {
        Log.d(TAG, "configureService title=$notificationTitle")
        this.notificationTitle = notificationTitle
        this.notificationDescription = notificationDescription
    }

    override fun startService(mode: PSignalingServiceMode) {
        Log.d(TAG, "startService mode=$mode")
        StorageDelegate.saveMode(context, mode)
        SignalingForegroundService.start(context)
    }

    override fun stopService() {
        Log.d(TAG, "stopService")
        StorageDelegate.clearConnectionConfig(context)
        val service = SignalingForegroundService.instance
        if (service != null) {
            service.gracefulStop { SignalingForegroundService.stop(context) }
        } else {
            SignalingForegroundService.stop(context)
        }
    }

    override fun notifyIsolateReady() {
        Log.d(TAG, "notifyIsolateReady -- background isolate ready, triggering synchronize")
        SignalingForegroundService.instance?.synchronizeIsolate()
    }

    companion object {
        private const val TAG = "WebtritSignalingServicePlugin"
    }
}
