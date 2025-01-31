import 'dart:convert';

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
      opusBandwidthLimit: map['opusBandwidthLimit'] as int?,
      opusStereo: map['opusStereo'] as bool?,
      audioProfiles: (map['audioProfiles'] as List<dynamic>?)?.map((p) => profileParamFromMap(p)).toList(),
      videoProfiles: (map['videoProfiles'] as List<dynamic>?)?.map((p) => profileParamFromMap(p)).toList(),
    );
  }

  Map<String, dynamic> encodingSettingsToMap(EncodingSettings settings) {
    return {
      'audioBitrate': settings.audioBitrate,
      'videoBitrate': settings.videoBitrate,
      'ptime': settings.ptime,
      'maxptime': settings.maxptime,
      'opusBandwidthLimit': settings.opusBandwidthLimit,
      'opusStereo': settings.opusStereo,
      'audioProfiles': settings.audioProfiles?.map((e) => profileParamToMap(e)).toList(),
      'videoProfiles': settings.videoProfiles?.map((e) => profileParamToMap(e)).toList(),
    };
  }

  ProfileParam profileParamFromMap(Map<String, dynamic> map) {
    return (profile: RTPCodecProfile.values.byName(map['profile']), enabled: map['enabled']);
  }

  Map<String, dynamic> profileParamToMap(ProfileParam param) {
    return {'profile': param.profile.name, 'enabled': param.enabled};
  }
}
