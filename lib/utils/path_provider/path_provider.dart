export '_unsupported.dart' // stub implementation with UnsupportedError throw
    if (dart.library.js) '_web.dart' // web implementation
    if (dart.library.io) '_native.dart'; // native implementation
