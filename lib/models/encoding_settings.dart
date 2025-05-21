import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/enableble.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

/// TODO:
/// global audio bitrate is commented out temporarily
/// because of flutter webrtc issue
/// when set lower bitrate than g722 pcma pcmu supports it throws exception on set answer sdp
/// for now only opus level bitrate will be used, and ilbc as second priority for traffic reduction
/// uncomment this when issue is fixed

enum EncodingPreset { bypass, eco, balance, quality, fullFlex, custom }

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
  }) {
    return EncodingSettings(
      // audioBitrate: audioBitrate ?? 56,
      videoBitrate: videoBitrate ?? 512,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate ?? 24000,
      opusBitrate: opusBitrate ?? 16,
      opusStereo: opusStereo ?? false,
      opusDtx: opusDtx ?? true,
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
    );
  }

  factory EncodingSettings.eco() {
    return EncodingSettings(
      // audioBitrate: 48,
      videoBitrate: 128,
      opusSamplingRate: 12000,
      opusBitrate: 8,
      opusStereo: false,
      opusDtx: true,
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
    );
  }

  factory EncodingSettings.balance() {
    return EncodingSettings(
      // audioBitrate: 56,
      videoBitrate: 512,
      opusSamplingRate: 24000,
      opusBitrate: 16,
      opusStereo: false,
      opusDtx: true,
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
    );
  }

  factory EncodingSettings.quality() {
    return EncodingSettings(
      // audioBitrate: 64,
      videoBitrate: 1024,
      opusSamplingRate: 32000,
      opusBitrate: 24,
      opusStereo: false,
      opusDtx: true,
      audioProfiles: defaultAudioProfilesOrder,
      videoProfiles: defaultVideoProfilesOrder,
    );
  }

  factory EncodingSettings.fullFlex() {
    return EncodingSettings(
      // audioBitrate: 128,
      videoBitrate: 4096,
      opusSamplingRate: 48000,
      opusBitrate: 128,
      opusStereo: true,
      opusDtx: false,
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
    (option: RTPCodecProfile.comfortNoise_32k, enabled: true),
    (option: RTPCodecProfile.comfortNoise_16k, enabled: true),
    (option: RTPCodecProfile.comfortNoise_8k, enabled: true),
    (option: RTPCodecProfile.telephoneEvent_48k, enabled: true),
    (option: RTPCodecProfile.telephoneEvent_16k, enabled: true),
    (option: RTPCodecProfile.telephoneEvent_8k, enabled: true),
    (option: RTPCodecProfile.redundancy_audio, enabled: true),
  ];

  /// Ordered list of video codec profiles to be used.
  /// Used to prioritize the codec profiles based on the order or enable/disable them.
  /// `null` means not set and use automatic mode.
  final List<Enableble<RTPCodecProfile>>? videoProfiles;
  static List<Enableble<RTPCodecProfile>> defaultVideoProfilesOrder = [
    (option: RTPCodecProfile.h264_42e01f, enabled: true),
    (option: RTPCodecProfile.h264_42e034, enabled: true),
    (option: RTPCodecProfile.h264_640c34, enabled: true),
    (option: RTPCodecProfile.h265, enabled: true),
    (option: RTPCodecProfile.vp8, enabled: true),
    (option: RTPCodecProfile.vp9, enabled: true),
    (option: RTPCodecProfile.av1, enabled: true),
    (option: RTPCodecProfile.redundancy_video, enabled: true),
  ];

  /// For tracking the model schema changes on serializing.
  static int schemaVersion = 1;

  EncodingSettings copyWithAudioBitrate(int? audioBitrate) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithVideoBitrate(int? videoBitrate) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithPtime(int? ptime) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithMaxptime(int? maxptime) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithOpusSamplingRate(int? opusSamplingRate) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithOpusBitrate(int? opusBitrate) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithOpusStereo(bool? opusStereo) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithOpusDtx(bool? opusDtx) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithAudioProfiles(List<Enableble<RTPCodecProfile>>? audioProfiles) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithVideoProfiles(List<Enableble<RTPCodecProfile>>? videoProfiles) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusSamplingRate: opusSamplingRate,
      opusBitrate: opusBitrate,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

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
      ];

  @override
  String toString() {
    return 'EncodingSettings{audioBitrate: $audioBitrate, videoBitrate: $videoBitrate, ptime: $ptime, maxptime: $maxptime, opusSamplingRate: $opusSamplingRate, opusBitrate: $opusBitrate, opusStereo: $opusStereo, opusDtx: $opusDtx, audioProfiles: $audioProfiles, videoProfiles: $videoProfiles}';
  }
}
