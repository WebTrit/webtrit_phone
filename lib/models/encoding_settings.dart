import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/enableble.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

/// TODO:
/// global audio bitrate is commented out temporarily
/// because of flutter webrtc issue
/// when set lower bitrate than g722 pcma pcmu supports it throws exception on set answer sdp
/// for now only opus level bitrate will be used, and ilbc as second priority for traffic reduction
/// uncomment this when issue is fixed
///
///
///

// REMB TWCC disabling Note:
//
// TWCC Disabled because of broken auto-bitrate in current architecture, app > [RTP/SAVPF] > janus > [RTP/AVP] > pbx > [RTP/AVP] > janus > [RTP/SAVPF] > app
// when it enabled app exchange twcc info with janus only (and only his call leg) + janus intercepts and removes it from streams to sip side
// so it lead us to next situation:
//    when user have network degradation he knows it via twcc and adjust's outgoing stream quality but he can't tell about it to remote party so incoming stream just stucks.
// Solution:
//    disable twcc to ignore 'fake' and 'unidirection' data from janus, so webrtc use regular rtcp data (RTP/AVP) that comes from remote party to estimate bandwidth
//    yes its slower(no, 5-10secs to react) then modern extensions but its real and works across SIP (RTP/AVP)
//    + its slows/ups down quality based on end to end perfomance (device 2, pbx, rtpproxy) not only network bandwith
//
// REMB not supported completely by janus, so clean some space

enum SdpExtmapType {
  twcc,
  absSendTime,
  playoutDelay,
  videoContentType,
  videoTiming,
  colorSpace,
  audioLevel,
  tOffset,
  videoOrientation,
  rtpStreamId,
  repairedRtpStreamId;

  String get uri => switch (this) {
    SdpExtmapType.twcc => 'http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01',
    SdpExtmapType.absSendTime => 'http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time',
    SdpExtmapType.playoutDelay => 'http://www.webrtc.org/experiments/rtp-hdrext/playout-delay',
    SdpExtmapType.videoContentType => 'http://www.webrtc.org/experiments/rtp-hdrext/video-content-type',
    SdpExtmapType.videoTiming => 'http://www.webrtc.org/experiments/rtp-hdrext/video-timing',
    SdpExtmapType.colorSpace => 'http://www.webrtc.org/experiments/rtp-hdrext/color-space',
    SdpExtmapType.audioLevel => 'urn:ietf:params:rtp-hdrext:ssrc-audio-level',
    SdpExtmapType.tOffset => 'urn:ietf:params:rtp-hdrext:toffset',
    SdpExtmapType.videoOrientation => 'urn:3gpp:video-orientation',
    SdpExtmapType.rtpStreamId => 'urn:ietf:params:rtp-hdrext:sdes:rtp-stream-id',
    SdpExtmapType.repairedRtpStreamId => 'urn:ietf:params:rtp-hdrext:sdes:repaired-rtp-stream-id',
  };
}

enum EncodingPreset { eco, balance, quality, bypass, custom }

class EncodingSettings extends Equatable {
  EncodingSettings({
    this.audioBitrate,
    this.videoBitrate,
    this.ptime,
    this.maxptime,
    this.opusSamplingRate,
    this.opusBitrate,
    this.opusStereo,
    this.opusDtx,
    this.audioProfiles,
    this.videoProfiles,
    this.removeStaticAudioRtpMaps = false,
    this.remapTE8payloadTo101 = false,
    this.removeREMBFeedback = false,
    this.removeTWCCFeedback = false,
    this.removeExtmaps = const [],
  });

  factory EncodingSettings.blank() => EncodingSettings();

  factory EncodingSettings.defaultWithOverrides({
    int? audioBitrate,
    int? videoBitrate,
    int? ptime,
    int? maxptime,
    int? opusSamplingRate,
    int? opusBitrate,
    bool? opusStereo,
    bool? opusDtx,
    bool? removeREMBFeedback,
    bool? removeTWCCFeedback,
    List<SdpExtmapType>? removeExtmaps,
  }) {
    return EncodingSettings(
      // audioBitrate: audioBitrate ?? 64,
      videoBitrate: videoBitrate ?? 1024,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate ?? 48000,
      opusBitrate: opusBitrate ?? 64,
      opusStereo: opusStereo ?? false,
      opusDtx: opusDtx ?? true,
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
      removeREMBFeedback: removeREMBFeedback ?? true, // see twcc remb disable note
      removeTWCCFeedback: removeTWCCFeedback ?? true, // see twcc remb disable note
      removeExtmaps: removeExtmaps ?? defaultExtmapsRemoveList,
    );
  }

  factory EncodingSettings.eco() {
    return EncodingSettings(
      // audioBitrate: 48,
      videoBitrate: 256,
      opusSamplingRate: 16000,
      opusBitrate: 8,
      opusStereo: false,
      opusDtx: true,
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
      removeREMBFeedback: true, // see twcc remb disable note
      removeTWCCFeedback: true, // see twcc remb disable note
      removeExtmaps: defaultExtmapsRemoveList,
    );
  }

  factory EncodingSettings.balance() {
    return EncodingSettings(
      // audioBitrate: 56,
      videoBitrate: 1024,
      opusSamplingRate: 48000,
      opusBitrate: 64,
      opusStereo: false,
      opusDtx: true,
      removeREMBFeedback: true, // see twcc remb disable note
      removeTWCCFeedback: true, // see twcc remb disable note
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
      removeExtmaps: defaultExtmapsRemoveList,
    );
  }

  factory EncodingSettings.quality() {
    return EncodingSettings(
      // audioBitrate: 64,
      videoBitrate: 2048,
      opusSamplingRate: 48000,
      opusBitrate: 128,
      opusStereo: false,
      opusDtx: false,
      removeREMBFeedback: true, // see twcc remb disable note
      removeTWCCFeedback: true, // see twcc remb disable note
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
      removeExtmaps: defaultExtmapsRemoveList,
    );
  }

  /// Set the bitrate for audio stream.
  /// In range `8-256kbps` for audio.
  /// `null` means not set and use automatic mode.
  final int? audioBitrate;
  static List<int> audioBitrateOptions = [8, 16, 32, 48, 56, 64, 128, 256];

  /// Set the bitrate for video stream.
  /// In range `32-4000kbps` for video.
  /// `null` means not set and use automatic mode.
  final int? videoBitrate;
  static List<int> videoBitrateOptions = [32, 128, 256, 512, 1024, 2048, 4000];

  /// Sets the desired packetization-time for the audio codec.
  /// [ptime] is in milliseconds, range `10-120ms`
  /// Attects the packet size for transporting layer used to avoud MTU fitting issues.
  /// `null` means not set and use automatic mode.
  final int? ptime;
  static List<int> ptimeOptions = [10, 20, 40, 60, 120];

  /// Sets the maximum packetization-time for the audio codec.
  /// [maxptime] is in milliseconds, range `10-120ms`
  /// Attects the packet size for transporting layer used to avoud MTU fitting issues.
  /// Should be greater or equal to [ptime] if set.
  /// `null` means not set and use automatic mode.
  final int? maxptime;

  /// Set opus specific bandwidth parameter.
  /// [opusSamplingRate] limit maximum bandwidth in hz, range `8000-48000`.
  /// `null` means not set and use automatic mode.
  final int? opusSamplingRate;
  static List<int> opusSamplingRateOptions = [8000, 12000, 16000, 24000, 48000];

  /// Set opus specific bitrate limit parameter.
  /// [opusBitrate] limit maximum bitrate in kbps, range `8-256`.
  /// `null` means not set and use automatic mode.
  final int? opusBitrate;
  static List<int> opusBitrateOptions = [8, 16, 32, 64, 128, 256, 500];

  /// Set opus specific stereo parameter.
  /// [opusStereo] stereo support on/off.
  /// `null` means not set and use automatic mode.
  final bool? opusStereo;

  /// Set opus specific DTX parameter.
  /// [opusDtx] DTX support on/off.
  /// `null` means not set and use automatic mode.
  final bool? opusDtx;

  /// Removes static audio RTP maps from the SDP.
  /// Used to reduce the SDP size and avoid MTU issues with some endpoints.
  final bool removeStaticAudioRtpMaps;

  /// Remaps telephone-event 8k payload code to 101.
  /// Used to avoid issues with some endpoints that expect telephone-event to be on payload type 101.
  final bool remapTE8payloadTo101;

  /// Removes all `goog-remb` RTCP feedback entries from every media section.
  final bool removeREMBFeedback;

  /// Removes all `transport-cc` RTCP feedback entries and the transport-wide-cc extmap
  /// from every media section.
  final bool removeTWCCFeedback;

  /// List of extmap types to remove from SDP. Empty list means no extmaps are removed.
  final List<SdpExtmapType> removeExtmaps;

  /// Ordered list of audio codec profiles to be used.
  /// Used to prioritize the codec profiles based on the order or enable/disable them.
  /// `null` means not set and use automatic mode.
  final List<Enableble<RTPCodecProfile>>? audioProfiles;
  static List<Enableble<RTPCodecProfile>> defaultAudioProfilesOrder = [
    (option: RTPCodecProfile.opus, enabled: true),
    (option: RTPCodecProfile.ilbc, enabled: true),
    (option: RTPCodecProfile.g722, enabled: true),
    (option: RTPCodecProfile.pcmu, enabled: true),
    (option: RTPCodecProfile.pcma, enabled: true),
    (option: RTPCodecProfile.comfortNoise_8k, enabled: true),
    (option: RTPCodecProfile.comfortNoise_16k, enabled: true),
    (option: RTPCodecProfile.comfortNoise_32k, enabled: true),
    // moving TE8 on top fixes compatibility issues with Zoiper
    // that shufflles pt 110 to 8k rate on re-invite to video
    (option: RTPCodecProfile.telephoneEvent_8k, enabled: true),
    (option: RTPCodecProfile.telephoneEvent_16k, enabled: true),
    (option: RTPCodecProfile.telephoneEvent_48k, enabled: true),
    (option: RTPCodecProfile.redundancy_audio, enabled: true),
  ];

  /// Ordered list of video codec profiles to be used.
  /// Used to prioritize the codec profiles based on the order or enable/disable them.
  /// `null` means not set and use automatic mode.
  final List<Enableble<RTPCodecProfile>>? videoProfiles;
  static List<Enableble<RTPCodecProfile>> defaultVideoProfilesOrder = [
    (option: RTPCodecProfile.av1, enabled: true),
    (option: RTPCodecProfile.vp9, enabled: true),
    (option: RTPCodecProfile.vp8, enabled: true),

    /// h264 downed 30 apr 2026 due to:
    ///  - android/ios incompatibility (android support only h264_42e01f even some exynos dont, ios support h264_42e034 and h264_640c34)
    ///  - android app crashes in some cases like upgrade to video race
    (option: RTPCodecProfile.h264_42e01f, enabled: true),
    (option: RTPCodecProfile.h264_42e034, enabled: true),
    (option: RTPCodecProfile.h264_640c34, enabled: true),

    /// lowest because some android devices anounces as supported but crashes on init encoder
    (option: RTPCodecProfile.h265, enabled: true),

    /// misc
    (option: RTPCodecProfile.redundancy_video, enabled: true),
  ];

  /// List of disabled by default extensions
  static List<SdpExtmapType> defaultExtmapsRemoveList = [
    // We not use VAD now, so lets drop it
    SdpExtmapType.audioLevel,
    // Simulcast not supported, lets drop it
    SdpExtmapType.rtpStreamId,
    SdpExtmapType.repairedRtpStreamId,
    // Screencast not supported, lets drop it
    SdpExtmapType.videoContentType,
    // No usecase for HDR in sip
    SdpExtmapType.colorSpace,
    // see twcc remb disable note
    SdpExtmapType.twcc,
  ];

  /// For tracking the model schema changes on serializing.
  static int schemaVersion = 2;

  EncodingSettings _copyWith({
    Object? audioBitrate = _absent,
    Object? videoBitrate = _absent,
    Object? ptime = _absent,
    Object? maxptime = _absent,
    Object? opusSamplingRate = _absent,
    Object? opusBitrate = _absent,
    Object? opusStereo = _absent,
    Object? opusDtx = _absent,
    Object? audioProfiles = _absent,
    Object? videoProfiles = _absent,
    bool? removeStaticAudioRtpMaps,
    bool? remapTE8payloadTo101,
    bool? removeREMBFeedback,
    bool? removeTWCCFeedback,
    List<SdpExtmapType>? removeExtmaps,
  }) {
    return EncodingSettings(
      audioBitrate: audioBitrate == _absent ? this.audioBitrate : audioBitrate as int?,
      videoBitrate: videoBitrate == _absent ? this.videoBitrate : videoBitrate as int?,
      ptime: ptime == _absent ? this.ptime : ptime as int?,
      maxptime: maxptime == _absent ? this.maxptime : maxptime as int?,
      opusSamplingRate: opusSamplingRate == _absent ? this.opusSamplingRate : opusSamplingRate as int?,
      opusBitrate: opusBitrate == _absent ? this.opusBitrate : opusBitrate as int?,
      opusStereo: opusStereo == _absent ? this.opusStereo : opusStereo as bool?,
      opusDtx: opusDtx == _absent ? this.opusDtx : opusDtx as bool?,
      audioProfiles: audioProfiles == _absent ? this.audioProfiles : audioProfiles as List<Enableble<RTPCodecProfile>>?,
      videoProfiles: videoProfiles == _absent ? this.videoProfiles : videoProfiles as List<Enableble<RTPCodecProfile>>?,
      removeStaticAudioRtpMaps: removeStaticAudioRtpMaps ?? this.removeStaticAudioRtpMaps,
      remapTE8payloadTo101: remapTE8payloadTo101 ?? this.remapTE8payloadTo101,
      removeREMBFeedback: removeREMBFeedback ?? this.removeREMBFeedback,
      removeTWCCFeedback: removeTWCCFeedback ?? this.removeTWCCFeedback,
      removeExtmaps: removeExtmaps ?? this.removeExtmaps,
    );
  }

  static const _absent = Object();

  EncodingSettings copyWithAudioBitrate(int? audioBitrate) => _copyWith(audioBitrate: audioBitrate);

  EncodingSettings copyWithVideoBitrate(int? videoBitrate) => _copyWith(videoBitrate: videoBitrate);

  EncodingSettings copyWithPtime(int? ptime) => _copyWith(ptime: ptime);

  EncodingSettings copyWithMaxptime(int? maxptime) => _copyWith(maxptime: maxptime);

  EncodingSettings copyWithOpusSamplingRate(int? opusSamplingRate) => _copyWith(opusSamplingRate: opusSamplingRate);

  EncodingSettings copyWithOpusBitrate(int? opusBitrate) => _copyWith(opusBitrate: opusBitrate);

  EncodingSettings copyWithOpusStereo(bool? opusStereo) => _copyWith(opusStereo: opusStereo);

  EncodingSettings copyWithOpusDtx(bool? opusDtx) => _copyWith(opusDtx: opusDtx);

  EncodingSettings copyWithAudioProfiles(List<Enableble<RTPCodecProfile>>? audioProfiles) =>
      _copyWith(audioProfiles: audioProfiles);

  EncodingSettings copyWithVideoProfiles(List<Enableble<RTPCodecProfile>>? videoProfiles) =>
      _copyWith(videoProfiles: videoProfiles);

  EncodingSettings copyWithRemoveStaticAudioRtpMaps(bool removeStaticAudioRtpMaps) =>
      _copyWith(removeStaticAudioRtpMaps: removeStaticAudioRtpMaps);

  EncodingSettings copyWithRemapTE8payloadTo101(bool remapTE8payloadTo101) =>
      _copyWith(remapTE8payloadTo101: remapTE8payloadTo101);

  EncodingSettings copyWithRemoveREMBFeedback(bool removeREMBFeedback) =>
      _copyWith(removeREMBFeedback: removeREMBFeedback);

  EncodingSettings copyWithRemoveTWCCFeedback(bool removeTWCCFeedback) =>
      _copyWith(removeTWCCFeedback: removeTWCCFeedback);

  EncodingSettings copyWithRemoveExtmaps(List<SdpExtmapType> removeExtmaps) => _copyWith(removeExtmaps: removeExtmaps);

  late final asRecord = (
    audioBitrate,
    videoBitrate,
    ptime,
    maxptime,
    opusSamplingRate,
    opusBitrate,
    opusStereo,
    opusDtx,
    audioProfiles,
    videoProfiles,
    removeStaticAudioRtpMaps,
    remapTE8payloadTo101,
    removeREMBFeedback,
    removeTWCCFeedback,
    removeExtmaps,
  );

  @override
  List<Object?> get props => [
    audioBitrate,
    videoBitrate,
    ptime,
    maxptime,
    opusSamplingRate,
    opusBitrate,
    opusStereo,
    opusDtx,
    audioProfiles,
    videoProfiles,
    removeStaticAudioRtpMaps,
    remapTE8payloadTo101,
    removeREMBFeedback,
    removeTWCCFeedback,
    removeExtmaps,
  ];

  @override
  String toString() {
    return 'EncodingSettings{audioBitrate: $audioBitrate, videoBitrate: $videoBitrate, ptime: $ptime, maxptime: $maxptime, opusSamplingRate: $opusSamplingRate, opusBitrate: $opusBitrate, opusStereo: $opusStereo, opusDtx: $opusDtx, audioProfiles: $audioProfiles, videoProfiles: $videoProfiles, removeStaticAudioRtpMaps: $removeStaticAudioRtpMaps, remapTE8payloadTo101: $remapTE8payloadTo101, removeREMBFeedback: $removeREMBFeedback, removeTWCCFeedback: $removeTWCCFeedback, removeExtmaps: $removeExtmaps}';
  }
}
