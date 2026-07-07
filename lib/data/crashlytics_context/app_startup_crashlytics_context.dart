import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../app_metadata_provider.dart';
import 'crashlytics_app_context.dart';
import 'media_settings_crashlytics_context.dart';
import 'network_crashlytics_context.dart';

/// Seeds the application-wide Crashlytics context at startup and tracks the
/// remote-config override keys. The heavy sibling of the per-feature
/// contexts: it reads the current values from the repositories once and
/// delegates the feature key vocabularies to the composed contexts, so each
/// key family still has a single defining place.
///
/// Keys owned by a state lifecycle are NOT written here to keep a single
/// writer per key: authorization/themeMode/locale belong to AppBloc, and
/// incomingCallType/media keys are refreshed by their settings cubits.
class AppStartupCrashlyticsContext extends CrashlyticsAppContext {
  AppStartupCrashlyticsContext({
    required this.metadataProvider,
    required this.callkeepVersion,
    required this.incomingCallTypeRepository,
    required this.encodingPresetRepository,
    required this.encodingSettingsRepository,
    required this.audioProcessingSettingsRepository,
    required this.videoCapturingSettingsRepository,
    required this.iceSettingsRepository,
    required this.peerConnectionSettingsRepository,
    super.crashKeysWriter,
  }) : _mediaSettingsContext = MediaSettingsCrashlyticsContext(crashKeysWriter: crashKeysWriter),
       _networkContext = NetworkCrashlyticsContext(crashKeysWriter: crashKeysWriter);

  final AppMetadataProvider metadataProvider;
  final String callkeepVersion;
  final IncomingCallTypeRepository incomingCallTypeRepository;
  final EncodingPresetRepository encodingPresetRepository;
  final EncodingSettingsRepository encodingSettingsRepository;
  final AudioProcessingSettingsRepository audioProcessingSettingsRepository;
  final VideoCapturingSettingsRepository videoCapturingSettingsRepository;
  final IceSettingsRepository iceSettingsRepository;
  final PeerConnectionSettingsRepository peerConnectionSettingsRepository;

  final MediaSettingsCrashlyticsContext _mediaSettingsContext;
  final NetworkCrashlyticsContext _networkContext;

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

    setKeys({...labels, 'callkeepVersion': callkeepVersion});

    _networkContext.logIncomingCallType(incomingCallTypeRepository.getIncomingCallType());
    _mediaSettingsContext.logMediaSettings(
      encodingPreset: encodingPresetRepository.getEncodingPreset(),
      encodingSettings: encodingSettingsRepository.getEncodingSettings(),
      audioProcessingSettings: audioProcessingSettingsRepository.getAudioProcessingSettings(),
      videoCapturingSettings: videoCapturingSettingsRepository.getVideoCapturingSettings(),
      iceSettings: iceSettingsRepository.getIceSettings(),
      peerConnectionSettings: peerConnectionSettingsRepository.getPeerConnectionSettings(
        defaultValue: defaultPeerConnectionSettings,
      ),
    );
  }

  /// Writes the remote-config override flags, keyed by their Remote Config
  /// parameter names so a crash report maps 1:1 to the console. Crashlytics
  /// cannot delete keys, so an absent override is written as the 'unset'
  /// sentinel; otherwise an override removed mid-session would leave its old
  /// value stuck for the rest of the run.
  void logFeatureOverrides(FeatureOverrides overrides) {
    if (overrides == _lastLoggedOverrides) return;
    _lastLoggedOverrides = overrides;

    setKeys({
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
