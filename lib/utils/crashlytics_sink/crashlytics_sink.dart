export '_unsupported.dart' // stub: telemetry is best-effort, never throws
    if (dart.library.js) '_web.dart' // web: firebase_crashlytics has no web impl -> no-ops
    if (dart.library.io) '_io.dart'; // native: forwards to FirebaseCrashlytics
