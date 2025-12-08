import 'dart:convert';

import 'package:webtrit_phone/models/enableble.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/rtp_codec_profile.dart';

mixin EncodingSettingsJsonMapper {
  EncodingSettings encodingSettingsFromJson(String json) {
    return encodingSettingsFromMap(jsonDecode(json));
  }

  String encodingSettingsToJson(EncodingSettings settings) {
    return jsonEncode(encodingSettingsToMap(settings));
  }

  EncodingSettings encodingSettingsFromMap(Map<String, dynamic> map) {
    return EncodingSettings(
      audioBitrate: map['audioBitrate'] as int?,
      videoBitrate: map['videoBitrate'] as int?,
      ptime: map['ptime'] as int?,
      maxptime: map['maxptime'] as int?,
      opusSamplingRate: map['opusSamplingRate'] as int?,
      opusBitrate: map['opusBitrate'] as int?,
      opusStereo: map['opusStereo'] as bool?,
      opusDtx: map['opusDtx'] as bool?,
      audioProfiles: (map['audioProfiles'] as List<dynamic>?)?.map((p) => profileFromMap(p)).toList(),
      videoProfiles: (map['videoProfiles'] as List<dynamic>?)?.map((p) => profileFromMap(p)).toList(),
      removeExtmaps: map['removeExtmaps'] as bool? ?? false,
      removeStaticAudioRtpMaps: map['removeStaticAudioRtpMaps'] as bool? ?? false,
      remapTE8payloadTo101: map['remapTE8payloadTo101'] as bool? ?? false,
    );
  }

  Map<String, dynamic> encodingSettingsToMap(EncodingSettings settings) {
    return {
      'audioBitrate': settings.audioBitrate,
      'videoBitrate': settings.videoBitrate,
      'ptime': settings.ptime,
      'maxptime': settings.maxptime,
      'opusSamplingRate': settings.opusSamplingRate,
      'opusBitrate': settings.opusBitrate,
      'opusStereo': settings.opusStereo,
      'opusDtx': settings.opusDtx,
      'audioProfiles': settings.audioProfiles?.map((e) => profileToMap(e)).toList(),
      'videoProfiles': settings.videoProfiles?.map((e) => profileToMap(e)).toList(),
      'removeExtmaps': settings.removeExtmaps,
      'removeStaticAudioRtpMaps': settings.removeStaticAudioRtpMaps,
      'remapTE8payloadTo101': settings.remapTE8payloadTo101,
    };
  }

  Enableble<RTPCodecProfile> profileFromMap(Map<String, dynamic> map) {
    final profile = map['profile'];
    final enabled = map['enabled'];

    /// migration from 1.7.6
    if (profile == 'cn') return (option: RTPCodecProfile.comfortNoise_8k, enabled: enabled);
    if (profile == 'telephoneEvent8') return (option: RTPCodecProfile.telephoneEvent_8k, enabled: enabled);
    if (profile == 'telephoneEvent48') return (option: RTPCodecProfile.telephoneEvent_48k, enabled: enabled);
    if (profile == 'redAudio') return (option: RTPCodecProfile.redundancy_audio, enabled: enabled);
    if (profile == 'redVideo') return (option: RTPCodecProfile.redundancy_video, enabled: enabled);

    return (option: RTPCodecProfile.values.byName(profile), enabled: enabled);
  }

  Map<String, dynamic> profileToMap(Enableble<RTPCodecProfile> param) {
    return {'profile': param.option.name, 'enabled': param.enabled};
  }
}
