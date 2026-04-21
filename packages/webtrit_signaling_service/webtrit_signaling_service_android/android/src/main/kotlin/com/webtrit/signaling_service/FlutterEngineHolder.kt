package com.webtrit.signaling_service

import io.flutter.embedding.engine.FlutterEngine

/// Holds a reference to whichever [FlutterEngine] most recently attached
/// [WebtritSignalingServicePlugin]. Used by [FlutterEngineHelper] to spawn
/// the background isolate as a sibling of an already-running Dart VM instead
/// of creating a new root isolate (which fails in AOT when a VM already exists).
///
/// Any engine — main UI engine, push-notification handler engine, or any other —
/// that registers the plugin qualifies. The only requirement at spawn time is
/// that [FlutterEngine.dartExecutor.isExecutingDart] returns true.
internal object FlutterEngineHolder {
    @Volatile
    var runningEngine: FlutterEngine? = null
}
