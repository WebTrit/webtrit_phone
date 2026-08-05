import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Restarts the native AVAudioEngine ADM (initAndStartRecording + startPlayout).
///
/// Native (io) implementation: forwards to the flutter_webrtc fork's
/// [AppleNativeAudioManagement.restartAudio]. A web no-op variant is selected
/// via conditional import - the symbol does not exist in the web build of the
/// fork, so it must not be referenced statically when compiling for web.
Future<void> nativeRestartAudio() => AppleNativeAudioManagement.restartAudio();
