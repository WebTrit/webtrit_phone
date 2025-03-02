import 'dart:convert';

import 'package:webtrit_phone/models/audio_processing_settings.dart';

mixin AudioProcessingSettingsJsonMapper {
  AudioProcessingSettings audioProcessingSettingsFromJson(String json) {
    return audioProcessingSettingsFromMap(jsonDecode(json));
  }

  String audioProcessingSettingsToJson(AudioProcessingSettings settings) {
    return jsonEncode(audioProcessingSettingsToMap(settings));
  }

  AudioProcessingSettings audioProcessingSettingsFromMap(Map<String, dynamic> map) {
    return AudioProcessingSettings(
      bypassVoiceProcessing: map['bypassVoiceProcessing'] as bool?,
      echoCancellation: map['echoCancellation'] as bool?,
      autoGainControl: map['autoGainControl'] as bool?,
      noiseSuppression: map['noiseSuppression'] as bool?,
      highpassFilter: map['highpassFilter'] as bool?,
      audioMirroring: map['audioMirroring'] as bool?,
    );
  }

  Map<String, dynamic> audioProcessingSettingsToMap(AudioProcessingSettings settings) {
    return {
      'bypassVoiceProcessing': settings.bypassVoiceProcessing,
      'echoCancellation': settings.echoCancellation,
      'autoGainControl': settings.autoGainControl,
      'noiseSuppression': settings.noiseSuppression,
      'highpassFilter': settings.highpassFilter,
      'audioMirroring': settings.audioMirroring,
    };
  }
}
