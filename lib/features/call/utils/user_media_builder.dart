import 'package:flutter/foundation.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'audio_constraints_builder.dart';
import 'video_constraints_builder.dart';

abstract class UserMediaBuilder {
  Future<MediaStream> build({required bool video, bool? frontCamera});
}

class DefaultUserMediaBuilder implements UserMediaBuilder {
  const DefaultUserMediaBuilder({this.audioConstraintsBuilder, this.videoConstraintsBuilder});

  final AudioConstraintsBuilder? audioConstraintsBuilder;
  final VideoConstraintsBuilder? videoConstraintsBuilder;

  /// Requests access to the user's media input devices (camera and/or microphone).
  ///
  /// For more information on constraints structure, see:
  /// https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices/getUserMedia
  @override
  Future<MediaStream> build({required bool video, bool? frontCamera}) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': _buildAudioConstraints(),
      'video': video ? _buildVideoConstraintsMap(frontCamera: frontCamera) : false,
    };

    try {
      final localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

      if (!kIsWeb) {
        await Helper.setAppleAudioConfiguration(
          AppleAudioConfiguration(appleAudioMode: video ? AppleAudioMode.videoChat : AppleAudioMode.voiceChat),
        );

        // REMOVED: await Helper.setSpeakerphoneOn(video);
        // Reason: Calling this forcibly overrides the audio route, causing sound
        // to play via speaker even when headphones are connected on iOS.
        // AppleAudioConfiguration handles the default routing correctly.
      }

      return localStream;
    } catch (e) {
      throw UserMediaError(e.toString());
    }
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

class SDPConfigurationError implements Exception {
  final String message;

  SDPConfigurationError(this.message);

  @override
  String toString() => 'SDPConfigurationError: $message';
}
