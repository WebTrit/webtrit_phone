// ignore_for_file: constant_identifier_names

enum RTPCodecProfile {
  opus(RTPCodecKind.audio, RTPCodec.opus, 48000, channels: 2),
  g722(RTPCodecKind.audio, RTPCodec.g722, 8000),
  ilbc(RTPCodecKind.audio, RTPCodec.ilbc, 8000),
  pcmu(RTPCodecKind.audio, RTPCodec.pcmu, 8000),
  pcma(RTPCodecKind.audio, RTPCodec.pcma, 8000),
  comfortNoise_32k(RTPCodecKind.audio, RTPCodec.cn, 32000),
  comfortNoise_16k(RTPCodecKind.audio, RTPCodec.cn, 16000),
  comfortNoise_8k(RTPCodecKind.audio, RTPCodec.cn, 8000),
  telephoneEvent_48k(RTPCodecKind.audio, RTPCodec.telephoneEvent, 48000),
  telephoneEvent_16k(RTPCodecKind.audio, RTPCodec.telephoneEvent, 16000),
  telephoneEvent_8k(RTPCodecKind.audio, RTPCodec.telephoneEvent, 8000),
  redundancy_audio(RTPCodecKind.audio, RTPCodec.red, 48000, channels: 2),

  h264_42e01f(RTPCodecKind.video, RTPCodec.h264, 90000, levelId: '42e01f'),
  h264_42e034(RTPCodecKind.video, RTPCodec.h264, 90000, levelId: '42e034'),
  h264_640c34(RTPCodecKind.video, RTPCodec.h264, 90000, levelId: '640c34'),
  h265(RTPCodecKind.video, RTPCodec.h265, 90000),
  vp8(RTPCodecKind.video, RTPCodec.vp8, 90000),
  vp9(RTPCodecKind.video, RTPCodec.vp9, 90000),
  av1(RTPCodecKind.video, RTPCodec.av1, 90000),
  redundancy_video(RTPCodecKind.video, RTPCodec.red, 90000);

  const RTPCodecProfile(this.kind, this.codec, this.rate, {this.channels, this.levelId});

  final RTPCodecKind kind;
  final RTPCodec codec;
  final int rate;
  final int? channels;
  final String? levelId;
}

enum RTPCodec {
  opus('opus'),
  g722('G722'),
  ilbc('ILBC'),
  pcmu('PCMU'),
  pcma('PCMA'),
  telephoneEvent('telephone-event'),
  h264('H264'),
  h265('H265'),
  vp8('VP8'),
  vp9('VP9'),
  av1('AV1'),
  cn('CN'),
  red('red');

  const RTPCodec(this.sdpKey);

  final String sdpKey;
}

enum RTPCodecKind { audio, video }
