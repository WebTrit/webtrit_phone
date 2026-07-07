import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/services/services.dart';

import 'call_pull_video_strategy.dart';

class FeatureOverrides extends Equatable {
  const FeatureOverrides({
    this.isVideoCallEnabled,
    this.isSystemNotificationsEnabled,
    this.hybridPresenceSupport,
    this.isVoicemailEnabled,
    this.isCallHistoryEnabled,
    this.callPullVideoStrategy,
    this.monitorCheckInterval,
    this.logLevel,
    this.remoteLoggingEnabled,
    this.isLogAnonymizationEnabled,
  });

  final bool? isVideoCallEnabled;
  final bool? isSystemNotificationsEnabled;
  final bool? hybridPresenceSupport;
  final bool? isVoicemailEnabled;
  final bool? isCallHistoryEnabled;

  /// Forces a Call Pull video strategy at runtime; when null the configurator/app
  /// default applies. See `SupportedFeature.callPull` / [CallPullVideoStrategy].
  final CallPullVideoStrategy? callPullVideoStrategy;
  final Duration? monitorCheckInterval;
  final Level? logLevel;
  final bool? remoteLoggingEnabled;
  final bool? isLogAnonymizationEnabled;

  @override
  List<Object?> get props => [
    isVideoCallEnabled,
    isSystemNotificationsEnabled,
    hybridPresenceSupport,
    isVoicemailEnabled,
    isCallHistoryEnabled,
    callPullVideoStrategy,
    monitorCheckInterval,
    logLevel,
    remoteLoggingEnabled,
    isLogAnonymizationEnabled,
  ];
}

abstract final class FeatureOverridesFactory {
  static const videoCallEnabledKey = 'feature_video_call_enabled';
  static const systemNotificationsEnabledKey = 'feature_system_notifications_enabled';
  static const hybridPresenceEnabledKey = 'feature_hybrid_presence_enabled';
  static const voicemailEnabledKey = 'feature_voicemail_enabled';
  static const callHistoryEnabledKey = 'feature_call_history_enabled';
  static const callPullVideoStrategyKey = 'feature_call_pull_video_strategy';
  static const monitorCheckIntervalKey = 'feature_monitor_check_interval_sec';
  static const logLevelKey = 'feature_log_level';
  static const remoteLoggingEnabledKey = 'firebaseRemoteLogging';
  static const logAnonymizationEnabledKey = 'feature_log_anonymization_enabled';

  static FeatureOverrides create(RemoteConfigSnapshot snapshot) {
    final monitorIntervalSec = int.tryParse(snapshot.getString(monitorCheckIntervalKey) ?? '');
    Duration? monitorCheckInterval;
    if (monitorIntervalSec != null) {
      monitorCheckInterval = Duration(seconds: monitorIntervalSec);
    }

    final logLevelName = snapshot.getString(logLevelKey);
    final logLevel = logLevelName != null ? Level.LEVELS.where((l) => l.name == logLevelName).firstOrNull : null;

    final callPullVideoStrategy = CallPullVideoStrategy.tryParse(snapshot.getString(callPullVideoStrategyKey));

    return FeatureOverrides(
      isVideoCallEnabled: snapshot.getBool(videoCallEnabledKey),
      isSystemNotificationsEnabled: snapshot.getBool(systemNotificationsEnabledKey),
      hybridPresenceSupport: snapshot.getBool(hybridPresenceEnabledKey),
      isVoicemailEnabled: snapshot.getBool(voicemailEnabledKey),
      isCallHistoryEnabled: snapshot.getBool(callHistoryEnabledKey),
      callPullVideoStrategy: callPullVideoStrategy,
      monitorCheckInterval: monitorCheckInterval,
      logLevel: logLevel,
      remoteLoggingEnabled: snapshot.getBool(remoteLoggingEnabledKey),
      isLogAnonymizationEnabled: snapshot.getBool(logAnonymizationEnabledKey),
    );
  }
}
