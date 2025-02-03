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
      opusBandwidthLimit: map['opusBandwidthLimit'] as int?,
      opusStereo: map['opusStereo'] as bool?,
      opusDtx: map['opusDtx'] as bool?,
      audioProfiles: (map['audioProfiles'] as List<dynamic>?)?.map((p) => profileFromMap(p)).toList(),
      videoProfiles: (map['videoProfiles'] as List<dynamic>?)?.map((p) => profileFromMap(p)).toList(),
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
      'opusDtx': settings.opusDtx,
      'audioProfiles': settings.audioProfiles?.map((e) => profileToMap(e)).toList(),
      'videoProfiles': settings.videoProfiles?.map((e) => profileToMap(e)).toList(),
    };
  }

  Enableble<RTPCodecProfile> profileFromMap(Map<String, dynamic> map) {
    return (option: RTPCodecProfile.values.byName(map['profile']), enabled: map['enabled']);
  }

  Map<String, dynamic> profileToMap(Enableble<RTPCodecProfile> param) {
    return {'profile': param.option.name, 'enabled': param.enabled};
  }
}
