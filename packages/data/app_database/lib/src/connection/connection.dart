export 'unsupported.dart' // stub implementation with UnsupportedError throw
    if (dart.library.js) 'web.dart' // web implementation
    if (dart.library.ffi) 'native.dart'; // native implementation
