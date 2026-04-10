import 'package:equatable/equatable.dart';

class EncodingConfig extends Equatable {
  const EncodingConfig({
    required this.bypassConfig,
    required this.configurationAllowed,
    required this.defaultPresetOverride,
  });

  final bool bypassConfig;
  final bool configurationAllowed;
  final DefaultPresetOverride defaultPresetOverride;

  @override
  List<Object?> get props => [bypassConfig, configurationAllowed, defaultPresetOverride];
}

class DefaultPresetOverride extends Equatable {
  const DefaultPresetOverride({
    required this.audioBitrate,
    required this.videoBitrate,
    required this.ptime,
    required this.maxptime,
    required this.opusSamplingRate,
    required this.opusBitrate,
    required this.opusStereo,
    required this.opusDtx,
    required this.removeExtmaps,
    required this.removeStaticAudioRtpMaps,
    required this.remapTE8payloadTo101,
  });

  final int? audioBitrate;
  final int? videoBitrate;
  final int? ptime;
  final int? maxptime;
  final int? opusSamplingRate;
  final int? opusBitrate;
  final bool? opusStereo;
  final bool? opusDtx;
  final bool? removeExtmaps;
  final bool? removeStaticAudioRtpMaps;
  final bool? remapTE8payloadTo101;

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
    removeExtmaps,
    removeStaticAudioRtpMaps,
    remapTE8payloadTo101,
  ];
}
