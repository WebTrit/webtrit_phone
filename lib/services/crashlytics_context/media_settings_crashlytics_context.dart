import 'package:webtrit_phone/models/models.dart';

import 'crashlytics_app_context.dart';

/// Crashlytics keys describing the WebRTC media settings, so call crashes
/// can be mapped to the exact media configuration they ran with.
class MediaSettingsCrashlyticsContext extends CrashlyticsAppContext {
  const MediaSettingsCrashlyticsContext({super.crashKeysWriter});

  void logMediaSettings({
    required EncodingPreset? encodingPreset,
    required EncodingSettings encodingSettings,
    required AudioProcessingSettings audioProcessingSettings,
    required VideoCapturingSettings videoCapturingSettings,
    required IceSettings iceSettings,
    required PeerConnectionSettings peerConnectionSettings,
  }) {
    setKeys({
      'encodingPreset': encodingPreset?.name ?? 'default',
      'encodingSettings': encodingSettings.toString(),
      'audioProcessingSettings': audioProcessingSettings.toString(),
      'videoCapturingSettings': videoCapturingSettings.toString(),
      'iceSettings': iceSettings.toString(),
      'negotiationSettings': peerConnectionSettings.negotiationSettings.toString(),
    });
  }
}
