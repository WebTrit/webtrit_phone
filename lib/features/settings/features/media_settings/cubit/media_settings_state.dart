import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/audio_processing_settings.dart';
import 'package:webtrit_phone/models/encoding_settings.dart';
import 'package:webtrit_phone/models/ice_settings.dart';
import 'package:webtrit_phone/models/video_capturing_settings.dart';

class MediaSettingsState with EquatableMixin {
  MediaSettingsState({
    required this.encodingSettings,
    required this.encodingPreset,
    required this.audioProcessingSettings,
    required this.videoCapturingSettings,
    required this.iceSettings,
  });

  final EncodingSettings encodingSettings;
  final EncodingPreset? encodingPreset;
  final AudioProcessingSettings audioProcessingSettings;
  final VideoCapturingSettings videoCapturingSettings;
  final IceSettings iceSettings;

  factory MediaSettingsState.fromPrefs(AppPreferences prefs) {
    return MediaSettingsState(
      encodingSettings: prefs.getEncodingSettings(),
      encodingPreset: prefs.getEncodingPreset(),
      audioProcessingSettings: prefs.getAudioProcessingSettings(),
      videoCapturingSettings: prefs.getVideoCapturingSettings(),
      iceSettings: prefs.getIceSettings(),
    );
  }

  MediaSettingsState copyWithEncodingPresets(EncodingPreset? preset) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: preset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: iceSettings,
    );
  }

  MediaSettingsState copyWithEncodingSettings(EncodingSettings settings) {
    return MediaSettingsState(
      encodingSettings: settings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: iceSettings,
    );
  }

  MediaSettingsState copyWithAudioProcessingSettings(AudioProcessingSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: settings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: iceSettings,
    );
  }

  MediaSettingsState copyWithVideoCapturingSettings(VideoCapturingSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: settings,
      iceSettings: iceSettings,
    );
  }

  MediaSettingsState copyWithIceSettings(IceSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: settings,
    );
  }

  @override
  List<Object?> get props => [
        encodingSettings,
        encodingPreset,
        audioProcessingSettings,
        videoCapturingSettings,
        iceSettings,
      ];

  @override
  String toString() {
    return 'MediaSettingsState - '
        'encodingPreset: $encodingPreset,'
        'encodingSettings: $encodingSettings},'
        'audioProcessingSettings: $audioProcessingSettings,'
        'videoCapturingSettings: $videoCapturingSettings';
  }
}
