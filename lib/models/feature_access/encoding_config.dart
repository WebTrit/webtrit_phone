class EncodingConfig {
  const EncodingConfig({
    required this.bypassConfig,
    required this.configurationAllowed,
    required this.defaultPresetOverride,
  });

  final bool bypassConfig;
  final bool configurationAllowed;
  final DefaultPresetOverride defaultPresetOverride;
}

class DefaultPresetOverride {
  const DefaultPresetOverride({
    required this.audioBitrate,
    required this.videoBitrate,
    required this.ptime,
    required this.maxptime,
    required this.opusSamplingRate,
    required this.opusBitrate,
    required this.opusStereo,
    required this.opusDtx,
  });

  final int? audioBitrate;
  final int? videoBitrate;
  final int? ptime;
  final int? maxptime;
  final int? opusSamplingRate;
  final int? opusBitrate;
  final bool? opusStereo;
  final bool? opusDtx;
}
