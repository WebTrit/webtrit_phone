package com.webtrit.app

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    // Move the app to background instead of destroying the Activity when
    // the user presses Back on the root screen. This prevents the Flutter
    // engine (and any active WebRTC call) from being torn down on back press.
    @Suppress("DEPRECATION")
    override fun onBackPressed() {
        moveTaskToBack(true)
    }
}
