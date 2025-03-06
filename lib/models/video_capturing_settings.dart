import 'package:equatable/equatable.dart';

class VideoCapturingSettings extends Equatable {
  const VideoCapturingSettings({this.resolution, this.framerate});

  final Resolution? resolution;
  final Framerate? framerate;

  factory VideoCapturingSettings.blank() => const VideoCapturingSettings();

  VideoCapturingSettings copyWithResolution(Resolution? resolution) {
    return VideoCapturingSettings(
      resolution: resolution,
      framerate: framerate,
    );
  }

  VideoCapturingSettings copyWithFramerate(Framerate? framerate) {
    return VideoCapturingSettings(
      resolution: resolution,
      framerate: framerate,
    );
  }

  @override
  List<Object?> get props => [resolution, framerate];

  @override
  String toString() {
    return 'VideoCapturingSettings{resolution: $resolution, framerate: $framerate}';
  }
}

enum Resolution { p360, p480, p720, p1080 }

enum Framerate { f25, f30, f50, f60 }

extension ReadableStringResolution on Resolution {
  String get str {
    switch (this) {
      case Resolution.p360:
        return '360';
      case Resolution.p480:
        return '480';
      case Resolution.p720:
        return '720';
      case Resolution.p1080:
        return '1080';
    }
  }
}

extension ReadableStringFramerate on Framerate {
  String get str {
    switch (this) {
      case Framerate.f25:
        return '25';
      case Framerate.f30:
        return '30';
      case Framerate.f50:
        return '50';
      case Framerate.f60:
        return '60';
    }
  }
}
