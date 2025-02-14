import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/models/enableble.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

enum EncodingPreset { eco, balance, quality, fullFlex, custom }

class EncodingSettings extends Equatable {
  const EncodingSettings({
    this.audioBitrate,
    this.videoBitrate,
    this.ptime,
    this.maxptime,
    this.opusBandwidthLimit,
    this.opusStereo,
    this.opusDtx,
    this.audioProfiles,
    this.videoProfiles,
  });

  factory EncodingSettings.blank() => const EncodingSettings();

  factory EncodingSettings.defaultWithOverrides({
    int? audioBitrate,
    int? videoBitrate,
    int? ptime,
    int? maxptime,
    int? opusBandwidthLimit,
    bool? opusStereo,
    bool? opusDtx,
  }) {
    return EncodingSettings(
      audioBitrate: audioBitrate ?? 24,
      videoBitrate: videoBitrate ?? 512,
      ptime: ptime ?? 20,
      maxptime: maxptime ?? 80,
      opusBandwidthLimit: opusBandwidthLimit ?? 16000,
      opusStereo: opusStereo ?? false,
      opusDtx: opusDtx ?? true,
    );
  }

  factory EncodingSettings.eco() {
    return const EncodingSettings(
      audioBitrate: 6,
      videoBitrate: 128,
      ptime: 20,
      maxptime: 80,
      opusBandwidthLimit: 8000,
      opusStereo: false,
      opusDtx: true,
    );
  }

  factory EncodingSettings.balance() {
    return const EncodingSettings(
      audioBitrate: 24,
      videoBitrate: 512,
      ptime: 20,
      maxptime: 80,
      opusBandwidthLimit: 16000,
      opusStereo: false,
      opusDtx: true,
    );
  }

  factory EncodingSettings.quality() {
    return const EncodingSettings(
      audioBitrate: 48,
      videoBitrate: 1024,
      ptime: 20,
      maxptime: 80,
      opusBandwidthLimit: 32000,
      opusStereo: false,
      opusDtx: true,
    );
  }

  factory EncodingSettings.fullFlex() {
    return const EncodingSettings(
      audioBitrate: 256,
      videoBitrate: 4096,
      ptime: 40,
      maxptime: 120,
      opusBandwidthLimit: 48000,
      opusStereo: true,
      opusDtx: false,
    );
  }

  /// Set the bitrate for audio stream.
  /// In range `8-256kbps` for audio.
  /// `null` means not set and use automatic mode.
  final int? audioBitrate;
  static List<int> audioBitrateOptions = UnmodifiableListView([8, 16, 32, 64, 128, 256]);

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
  /// [opusBandwidthLimit] limit maximum bandwidth in hz, range `8000-48000`.
  /// `null` means not set and use automatic mode.
  final int? opusBandwidthLimit;
  static List<int> opusBandwidthLimitOptions = [8000, 12000, 16000, 24000, 48000];

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
    (option: RTPCodecProfile.redAudio, enabled: true),
    (option: RTPCodecProfile.g722, enabled: true),
    (option: RTPCodecProfile.ilbc, enabled: true),
    (option: RTPCodecProfile.pcmu, enabled: true),
    (option: RTPCodecProfile.pcma, enabled: true),
    (option: RTPCodecProfile.cn, enabled: true),
    (option: RTPCodecProfile.telephoneEvent8, enabled: true),
    (option: RTPCodecProfile.telephoneEvent48, enabled: true),
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
    (option: RTPCodecProfile.redVideo, enabled: true),
  ];

  /// For tracking the model schema changes on serializing.
  static int schemaVersion = 1;

  EncodingSettings copyWithAudioBitrate(int? audioBitrate) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusBandwidthLimit: opusBandwidthLimit,
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
      opusBandwidthLimit: opusBandwidthLimit,
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
      opusBandwidthLimit: opusBandwidthLimit,
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
      opusBandwidthLimit: opusBandwidthLimit,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  EncodingSettings copyWithOpusBandwidthLimit(int? opusBandwidthLimit) {
    return EncodingSettings(
      audioBitrate: audioBitrate,
      videoBitrate: videoBitrate,
      ptime: ptime,
      maxptime: maxptime,
      opusBandwidthLimit: opusBandwidthLimit,
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
      opusBandwidthLimit: opusBandwidthLimit,
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
      opusBandwidthLimit: opusBandwidthLimit,
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
      opusBandwidthLimit: opusBandwidthLimit,
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
      opusBandwidthLimit: opusBandwidthLimit,
      opusStereo: opusStereo,
      opusDtx: opusDtx,
      audioProfiles: audioProfiles,
      videoProfiles: videoProfiles,
    );
  }

  @override
  List<Object?> get props => [
        audioBitrate,
        videoBitrate,
        ptime,
        maxptime,
        opusBandwidthLimit,
        opusStereo,
        opusDtx,
        audioProfiles,
        videoProfiles,
      ];

  @override
  String toString() {
    return 'EncodingSettings{audioBitrate: $audioBitrate, videoBitrate: $videoBitrate, ptime: $ptime, maxptime: $maxptime, opusBandwidthLimit: $opusBandwidthLimit, opusStereo: $opusStereo, opusDtx: $opusDtx, audioProfiles: $audioProfiles, videoProfiles: $videoProfiles}';
  }
}
