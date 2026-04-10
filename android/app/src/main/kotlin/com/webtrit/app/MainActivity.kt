package com.webtrit.app

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    /**
     * Overrides the default back-press behavior when Flutter's navigation stack is fully exhausted.
     *
     * By default, [FlutterActivity] calls [finish] at this point, which destroys the Activity and
     * tears down the Flutter engine — including any active WebRTC peer connections. This causes
     * in-progress calls to drop immediately.
     *
     * This override intentionally minimizes the app for **all** cases (not only during active calls).
     * This is the standard VoIP app pattern: the app maintains background signaling connections and
     * must stay alive to receive incoming calls, so "exit via Back" is replaced with "move to
     * background". Users can still fully close the app through the recent-apps screen.
     *
     * Falls back to [super.popSystemNavigator] if [moveTaskToBack] reports that the task could not
     * be moved (e.g. the activity is not part of a root task), preserving correct behavior in that
     * edge case.
     */
    override fun popSystemNavigator(): Boolean {
        return if (moveTaskToBack(true)) true else super.popSystemNavigator()
    }
}
