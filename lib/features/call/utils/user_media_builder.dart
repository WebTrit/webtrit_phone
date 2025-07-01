import 'package:flutter/foundation.dart';

import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'audio_constraints_builder.dart';
import 'video_constraints_builder.dart';

abstract class UserMediaBuilder {
  Future<MediaStream> build({
    required bool video,
    bool? frontCamera,
  });
}

class DefaultUserMediaBuilder implements UserMediaBuilder {
  const DefaultUserMediaBuilder({
    this.audioConstraintsBuilder,
    this.videoConstraintsBuilder,
  });

  final AudioConstraintsBuilder? audioConstraintsBuilder;
  final VideoConstraintsBuilder? videoConstraintsBuilder;

  @override
  Future<MediaStream> build({
    required bool video,
    bool? frontCamera,
  }) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': {
        'mandatory': audioConstraintsBuilder?.build() ?? {},
      },
      'video': video
          ? {
              'mandatory': videoConstraintsBuilder?.build() ?? {},
              if (frontCamera != null) 'facingMode': frontCamera ? 'user' : 'environment',
              'optional': [],
            }
          : false,
    };

    try {
      final localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

      if (!kIsWeb) {
        await Helper.setAppleAudioConfiguration(
          AppleAudioConfiguration(
            appleAudioMode: video ? AppleAudioMode.videoChat : AppleAudioMode.voiceChat,
          ),
        );
        await Helper.setSpeakerphoneOn(video);
      }

      return localStream;
    } catch (e) {
      throw UserMediaError(e.toString());
    }
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
