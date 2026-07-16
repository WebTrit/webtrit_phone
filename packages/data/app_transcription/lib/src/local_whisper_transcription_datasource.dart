export 'local_whisper_transcription_datasource_stub.dart' // stub implementation for platforms without FFI (web)
    if (dart.library.io) 'local_whisper_transcription_datasource_io.dart'; // native implementation
