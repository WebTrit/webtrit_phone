import 'package:equatable/equatable.dart';
import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/audio_processing_settings/audio_processing_settings_repository.dart';

// TODO(Serdun): Maybe better to use Freezed for avoid a lot of copyWith methods.
class MediaSettingsState with EquatableMixin {
  MediaSettingsState({
    required this.encodingSettings,
    required this.encodingPreset,
    required this.audioProcessingSettings,
    required this.videoCapturingSettings,
    required this.iceSettings,
    required this.pearConnectionSettings,
  });

  final EncodingSettings encodingSettings;
  final EncodingPreset? encodingPreset;
  final AudioProcessingSettings audioProcessingSettings;
  final VideoCapturingSettings videoCapturingSettings;

  // TODO: Move [iceSettings] to [PeerConnectionSettings] since it relates to WebRTC session-level configuration,
  // such as ICE servers, transport policy, and connection establishment behavior.
  final IceSettings iceSettings;
  final PeerConnectionSettings pearConnectionSettings;

  factory MediaSettingsState.fromPrefs(AppPreferences prefs, PeerConnectionSettings defaultPeerConnectionSettings, AudioProcessingSettingsRepository audioProcessingSettingsRepository) {
    return MediaSettingsState(
      encodingSettings: prefs.getEncodingSettings(),
      encodingPreset: prefs.getEncodingPreset(),
      audioProcessingSettings: audioProcessingSettingsRepository.getAudioProcessingSettings(),
      videoCapturingSettings: prefs.getVideoCapturingSettings(),
      iceSettings: prefs.getIceSettings(),
      pearConnectionSettings: prefs.getPeerConnectionSettings(defaultValue: defaultPeerConnectionSettings),
    );
  }

  MediaSettingsState copyWithEncodingPresets(EncodingPreset? preset) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: preset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: iceSettings,
      pearConnectionSettings: pearConnectionSettings,
    );
  }

  MediaSettingsState copyWithEncodingSettings(EncodingSettings settings) {
    return MediaSettingsState(
      encodingSettings: settings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: iceSettings,
      pearConnectionSettings: pearConnectionSettings,
    );
  }

  MediaSettingsState copyWithAudioProcessingSettings(AudioProcessingSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: settings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: iceSettings,
      pearConnectionSettings: pearConnectionSettings,
    );
  }

  MediaSettingsState copyWithVideoCapturingSettings(VideoCapturingSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: settings,
      iceSettings: iceSettings,
      pearConnectionSettings: pearConnectionSettings,
    );
  }

  MediaSettingsState copyWithIceSettings(IceSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: settings,
      pearConnectionSettings: pearConnectionSettings,
    );
  }

  MediaSettingsState copyWithPeerConnectionSettings(PeerConnectionSettings settings) {
    return MediaSettingsState(
      encodingSettings: encodingSettings,
      encodingPreset: encodingPreset,
      audioProcessingSettings: audioProcessingSettings,
      videoCapturingSettings: videoCapturingSettings,
      iceSettings: iceSettings,
      pearConnectionSettings: settings,
    );
  }

  @override
  List<Object?> get props => [
    encodingSettings,
    encodingPreset,
    audioProcessingSettings,
    videoCapturingSettings,
    iceSettings,
    pearConnectionSettings,
  ];

  @override
  String toString() {
    return 'MediaSettingsState - '
        'encodingPreset: $encodingPreset,'
        'encodingSettings: $encodingSettings},'
        'audioProcessingSettings: $audioProcessingSettings,'
        'videoCapturingSettings: $videoCapturingSettings,'
        'iceSettings: $iceSettings,'
        'pearConnectionSettings: $pearConnectionSettings';
  }
}
