// ignore_for_file: constant_identifier_names

@Deprecated('Use RTPCodecProfile instead')
enum AudioCodec {
  opus,
  g722,
  ilbc,
  pcmu,
  pcma,
  red,
  cn,
  telephone_event_8k,
  telephone_event_48k,
}

@Deprecated('Use RTPCodecProfile instead')
enum VideoCodec {
  h264_42e01f,
  h264_42e034,
  h264_640c34,
  h265,
  vp8,
  vp9,
  av1,
  red,
}
