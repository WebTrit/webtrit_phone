import 'package:flutter/foundation.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'audio_constraints_builder.dart';
import 'video_constraints_builder.dart';

abstract class UserMediaBuilder {
  Future<MediaStream> build({required bool video, bool? frontCamera, bool allowAudioFallback = false});
}

class DefaultUserMediaBuilder implements UserMediaBuilder {
  const DefaultUserMediaBuilder({
    this.audioConstraintsBuilder,
    this.videoConstraintsBuilder,
    this.isCameraPermissionGranted,
    this.getUserMedia,
  });

  final AudioConstraintsBuilder? audioConstraintsBuilder;
  final VideoConstraintsBuilder? videoConstraintsBuilder;

  /// Optional callback to check whether camera permission is granted.
  ///
  /// When [null], video availability is assumed to be [true] — the platform
  /// itself (OS / browser) will handle the permission prompt.
  final Future<bool> Function()? isCameraPermissionGranted;

  /// Injectable override for [navigator.mediaDevices.getUserMedia].
  ///
  /// Defaults to the real platform API when [null].
  /// Intended for use in tests only.
  @visibleForTesting
  final Future<MediaStream> Function(Map<String, dynamic>)? getUserMedia;

  /// Requests access to the user's media input devices (camera and/or microphone).
  ///
  /// When [allowAudioFallback] is [true] and [video] is [true], the camera
  /// permission is checked first via [isCameraPermissionGranted]. If denied,
  /// the stream is acquired without video rather than throwing.
  ///
  /// When [allowAudioFallback] is [false] (default), any failure to acquire
  /// media throws [UserMediaError], preserving the original behaviour for
  /// callers that handle the error explicitly (e.g. camera-enable action).
  ///
  /// For more information on constraints structure, see:
  /// https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia
  @override
  Future<MediaStream> build({required bool video, bool? frontCamera, bool allowAudioFallback = false}) async {
    final resolvedVideo = video && (!allowAudioFallback || await _isCameraAvailable());

    final Map<String, dynamic> mediaConstraints = {
      'audio': _buildAudioConstraints(),
      'video': resolvedVideo ? _buildVideoConstraintsMap(frontCamera: frontCamera) : false,
    };

    try {
      final localStream = await (getUserMedia ?? navigator.mediaDevices.getUserMedia)(mediaConstraints);

      if (!kIsWeb) {
        await Helper.setAppleAudioConfiguration(
          AppleAudioConfiguration(appleAudioMode: resolvedVideo ? AppleAudioMode.videoChat : AppleAudioMode.voiceChat),
        );
      }

      return localStream;
    } catch (e) {
      throw UserMediaError(e.toString());
    }
  }

  Future<bool> _isCameraAvailable() async {
    if (kIsWeb || isCameraPermissionGranted == null) return true;
    return isCameraPermissionGranted!();
  }

  /// Constructs the map structure for audio constraints.
  Map<String, dynamic> _buildAudioConstraints() {
    return {'mandatory': audioConstraintsBuilder?.build() ?? <String, String>{}};
  }

  /// Constructs the video constraints map.
  ///
  /// This method is only called when video is enabled.
  /// Returns a strictly typed [Map<String, dynamic>].
  Map<String, dynamic> _buildVideoConstraintsMap({bool? frontCamera}) {
    return <String, dynamic>{
      'mandatory': videoConstraintsBuilder?.build() ?? <String, String>{},
      if (frontCamera != null) 'facingMode': frontCamera ? 'user' : 'environment',
      'optional': <dynamic>[],
    };
  }
}

class UserMediaError implements Exception {
  final String message;

  UserMediaError(this.message);

  @override
  String toString() => 'UserMediaError: $message';
}
