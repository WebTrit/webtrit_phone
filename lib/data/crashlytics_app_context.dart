import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'app_metadata_provider.dart';

/// Builds and writes the application-context Crashlytics custom keys, so
/// crash reports carry the configuration they happened in. Lives outside the
/// widget tree and takes the write sink as a dependency, so the produced keys
/// are unit-testable without Firebase.
///
/// Keys owned by a state lifecycle are NOT written here to keep a single
/// writer per key: authorization/themeMode/locale belong to AppBloc, and
/// incomingCallType/media keys are refreshed by their settings cubits.
class CrashlyticsAppContext {
  CrashlyticsAppContext({
    required this.metadataProvider,
    required this.callkeepVersion,
    required this.incomingCallTypeRepository,
    required this.encodingPresetRepository,
    required this.encodingSettingsRepository,
    required this.audioProcessingSettingsRepository,
    required this.videoCapturingSettingsRepository,
    required this.iceSettingsRepository,
    required this.peerConnectionSettingsRepository,
    this.writeKeys = CrashlyticsUtils.logAppSettings,
  });

  final AppMetadataProvider metadataProvider;
  final String callkeepVersion;
  final IncomingCallTypeRepository incomingCallTypeRepository;
  final EncodingPresetRepository encodingPresetRepository;
  final EncodingSettingsRepository encodingSettingsRepository;
  final AudioProcessingSettingsRepository audioProcessingSettingsRepository;
  final VideoCapturingSettingsRepository videoCapturingSettingsRepository;
  final IceSettingsRepository iceSettingsRepository;
  final PeerConnectionSettingsRepository peerConnectionSettingsRepository;

  /// Crashlytics write sink; injectable for tests.
  final void Function(Map<String, Object?> settings) writeKeys;

  /// The last overrides written; [logFeatureOverrides] is driven by widget
  /// dependency changes that fire for unrelated reasons too, so unchanged
  /// overrides are not re-written.
  FeatureOverrides? _lastLoggedOverrides;

  /// Seeds the startup context: the app/device metadata labels (the real
  /// app_version - the store build version is 0.0.0 outside release builds),
  /// the callkeep version, and the user settings that shape call behavior.
  /// The 'authorization' label is dropped: AppBloc owns that key and keeps it
  /// truthful across login/logout.
  void logStartup({required PeerConnectionSettings defaultPeerConnectionSettings}) {
    final labels = Map<String, Object?>.from(metadataProvider.logLabels)..remove('authorization');

    writeKeys({
      ...labels,
      'callkeepVersion': callkeepVersion,
      'incomingCallType': incomingCallTypeRepository.getIncomingCallType().name,
      ...mediaSettingsCrashKeys(
        encodingPreset: encodingPresetRepository.getEncodingPreset(),
        encodingSettings: encodingSettingsRepository.getEncodingSettings(),
        audioProcessingSettings: audioProcessingSettingsRepository.getAudioProcessingSettings(),
        videoCapturingSettings: videoCapturingSettingsRepository.getVideoCapturingSettings(),
        iceSettings: iceSettingsRepository.getIceSettings(),
        peerConnectionSettings: peerConnectionSettingsRepository.getPeerConnectionSettings(
          defaultValue: defaultPeerConnectionSettings,
        ),
      ),
    });
  }

  /// Writes the remote-config override flags, keyed by their Remote Config
  /// parameter names so a crash report maps 1:1 to the console. Crashlytics
  /// cannot delete keys, so an absent override is written as the 'unset'
  /// sentinel; otherwise an override removed mid-session would leave its old
  /// value stuck for the rest of the run.
  void logFeatureOverrides(FeatureOverrides overrides) {
    if (overrides == _lastLoggedOverrides) return;
    _lastLoggedOverrides = overrides;

    writeKeys({
      'feature_video_call_enabled': overrides.isVideoCallEnabled ?? 'unset',
      'feature_system_notifications_enabled': overrides.isSystemNotificationsEnabled ?? 'unset',
      'feature_hybrid_presence_enabled': overrides.hybridPresenceSupport ?? 'unset',
      'feature_voicemail_enabled': overrides.isVoicemailEnabled ?? 'unset',
      'feature_call_history_enabled': overrides.isCallHistoryEnabled ?? 'unset',
      'feature_call_pull_video_strategy': overrides.callPullVideoStrategy?.name ?? 'unset',
      'feature_monitor_check_interval_sec': overrides.monitorCheckInterval?.inSeconds ?? 'unset',
      'feature_log_level': overrides.logLevel?.name ?? 'unset',
      'firebaseRemoteLogging': overrides.remoteLoggingEnabled ?? 'unset',
      'feature_log_anonymization_enabled': overrides.isLogAnonymizationEnabled ?? 'unset',
    });
  }
}
