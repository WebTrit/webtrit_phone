import 'package:webtrit_phone/models/models.dart';

/// Crashlytics custom keys describing the WebRTC media settings, so call
/// crashes can be mapped to the exact media configuration they ran with.
/// Shared by the startup seed and the media-settings screen refresh to keep
/// the key names and value formats in one place.
Map<String, Object?> mediaSettingsCrashKeys({
  required EncodingPreset? encodingPreset,
  required EncodingSettings encodingSettings,
  required AudioProcessingSettings audioProcessingSettings,
  required VideoCapturingSettings videoCapturingSettings,
  required IceSettings iceSettings,
  required PeerConnectionSettings peerConnectionSettings,
}) {
  return {
    'encodingPreset': encodingPreset?.name ?? 'default',
    'encodingSettings': encodingSettings.toString(),
    'audioProcessingSettings': audioProcessingSettings.toString(),
    'videoCapturingSettings': videoCapturingSettings.toString(),
    'iceSettings': iceSettings.toString(),
    'negotiationSettings': peerConnectionSettings.negotiationSettings.toString(),
  };
}
