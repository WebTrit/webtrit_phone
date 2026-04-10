package com.webtrit.app

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    // Called by Flutter only after its own navigation stack is fully exhausted.
    // Returning true prevents the default finish() call and moves the app to
    // background instead, keeping the Flutter engine (and any active WebRTC
    // call) alive.
    override fun popSystemNavigator(): Boolean {
        moveTaskToBack(true)
        return true
    }
}
