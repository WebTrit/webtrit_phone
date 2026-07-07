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
  /// The session-scoped labels (authorization/tenantId/coreUrl) are dropped:
  /// AppBloc owns those keys and keeps them truthful across login/logout.
  void logStartup({required PeerConnectionSettings defaultPeerConnectionSettings}) {
    final labels = Map<String, Object?>.from(metadataProvider.logLabels)
      ..remove('authorization')
      ..remove('tenantId')
      ..remove('coreUrl');

    setKeys({...labels, 'callkeepVersion': callkeepVersion});
    logUserSettings(defaultPeerConnectionSettings: defaultPeerConnectionSettings);
  }

  /// Re-reads the user settings from the repositories and writes their keys,
  /// delegating to the composed feature contexts. Besides startup, call this
  /// after the logout cleanup resets the settings repositories - the cubits
  /// that own these keys only live while their settings screens are open, so
  /// nothing else would refresh the keys for the next session.
  void logUserSettings({required PeerConnectionSettings defaultPeerConnectionSettings}) {
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
      FeatureOverridesFactory.videoCallEnabledKey: overrides.isVideoCallEnabled ?? 'unset',
      FeatureOverridesFactory.systemNotificationsEnabledKey: overrides.isSystemNotificationsEnabled ?? 'unset',
      FeatureOverridesFactory.hybridPresenceEnabledKey: overrides.hybridPresenceSupport ?? 'unset',
      FeatureOverridesFactory.voicemailEnabledKey: overrides.isVoicemailEnabled ?? 'unset',
      FeatureOverridesFactory.callHistoryEnabledKey: overrides.isCallHistoryEnabled ?? 'unset',
      FeatureOverridesFactory.callPullVideoStrategyKey: overrides.callPullVideoStrategy?.name ?? 'unset',
      FeatureOverridesFactory.monitorCheckIntervalKey: overrides.monitorCheckInterval?.inSeconds ?? 'unset',
      FeatureOverridesFactory.logLevelKey: overrides.logLevel?.name ?? 'unset',
      FeatureOverridesFactory.remoteLoggingEnabledKey: overrides.remoteLoggingEnabled ?? 'unset',
      FeatureOverridesFactory.logAnonymizationEnabledKey: overrides.isLogAnonymizationEnabled ?? 'unset',
    });
  }
}
