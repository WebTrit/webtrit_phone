package com.webtrit.device_auto_rotate

import android.content.ContentResolver
import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.Looper
import android.provider.Settings

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class DeviceAutoRotatePlugin : FlutterPlugin, MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler {
    private companion object {
        const val METHOD_CHANNEL_NAME = "device_auto_rotate"
        const val EVENT_CHANNEL_NAME = "device_auto_rotate_stream"
        const val METHOD_IS_AUTO_ROTATE_ENABLED = "isAutoRotateEnabled"
    }

    private lateinit var contentResolver: ContentResolver
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    private var eventSink: EventChannel.EventSink? = null
    private var contentObserver: ContentObserver? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        contentResolver = flutterPluginBinding.applicationContext.contentResolver

        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL_NAME)
        methodChannel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, EVENT_CHANNEL_NAME)
        eventChannel.setStreamHandler(this)

        contentObserver = object : ContentObserver(Handler(Looper.getMainLooper())) {
            override fun onChange(selfChange: Boolean) {
                super.onChange(selfChange)
                sendAutoRotateEvent()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        unregisterObserver()
        contentObserver = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == METHOD_IS_AUTO_ROTATE_ENABLED) {
            result.success(isAutoRotateEnabled())
        } else {
            result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        registerObserver()
        sendAutoRotateEvent()
    }

    override fun onCancel(arguments: Any?) {
        unregisterObserver()
        eventSink = null
    }

    private fun isAutoRotateEnabled(): Boolean {
        return try {
            Settings.System.getInt(
                contentResolver, Settings.System.ACCELEROMETER_ROTATION, 0
            ) == 1
        } catch (e: Exception) {
            // Default to true in case of access errors
            true
        }
    }

    private fun sendAutoRotateEvent() {
        eventSink?.success(isAutoRotateEnabled())
    }

    private fun registerObserver() {
        try {
            contentObserver?.let { observer ->
                val settingUri: Uri =
                    Settings.System.getUriFor(Settings.System.ACCELEROMETER_ROTATION)
                contentResolver.registerContentObserver(settingUri, false, observer)
            }
        } catch (e: Exception) {
            // Ignore registration errors
        }
    }

    private fun unregisterObserver() {
        try {
            contentObserver?.let { observer ->
                contentResolver.unregisterContentObserver(observer)
            }
        } catch (e: Exception) {
            // Ignore if already unregistered
        }
    }
}
