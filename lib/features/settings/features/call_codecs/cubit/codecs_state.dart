part of 'codecs_cubit.dart';

class CallCodecsState with EquatableMixin {
  CallCodecsState({this.audioCodec, this.videoCodec});
  final AudioCodec? audioCodec;
  final VideoCodec? videoCodec;

  @override
  List<Object?> get props => [audioCodec, videoCodec];

  @override
  bool get stringify => true;

  CallCodecsState copyWithAudioCodec(AudioCodec? audioCodec) {
    return CallCodecsState(audioCodec: audioCodec, videoCodec: videoCodec);
  }

  CallCodecsState copyWithVideoCodec(VideoCodec? videoCodec) {
    return CallCodecsState(audioCodec: audioCodec, videoCodec: videoCodec);
  }
}
