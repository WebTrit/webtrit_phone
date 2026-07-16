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
  static const _kVideoCallEnabledKey = 'feature_video_call_enabled';
  static const _kSystemNotificationsEnabledKey = 'feature_system_notifications_enabled';
  static const _kHybridPresenceEnabledKey = 'feature_hybrid_presence_enabled';
  static const _kVoicemailEnabledKey = 'feature_voicemail_enabled';
  static const _kCallHistoryEnabledKey = 'feature_call_history_enabled';
  static const _kCallPullVideoStrategyKey = 'feature_call_pull_video_strategy';
  static const _kMonitorCheckIntervalKey = 'feature_monitor_check_interval_sec';
  static const _kLogLevelKey = 'feature_log_level';
  static const _kRemoteLoggingEnabledKey = 'firebaseRemoteLogging';
  static const _kLogAnonymizationEnabledKey = 'feature_log_anonymization_enabled';

  static FeatureOverrides create(RemoteConfigSnapshot snapshot) {
    final monitorIntervalSec = int.tryParse(snapshot.getString(_kMonitorCheckIntervalKey) ?? '');
    Duration? monitorCheckInterval;
    if (monitorIntervalSec != null) {
      monitorCheckInterval = Duration(seconds: monitorIntervalSec);
    }

    final logLevelName = snapshot.getString(_kLogLevelKey);
    final logLevel = logLevelName != null ? Level.LEVELS.where((l) => l.name == logLevelName).firstOrNull : null;

    final callPullVideoStrategy = CallPullVideoStrategy.tryParse(snapshot.getString(_kCallPullVideoStrategyKey));

    return FeatureOverrides(
      isVideoCallEnabled: snapshot.getBool(_kVideoCallEnabledKey),
      isSystemNotificationsEnabled: snapshot.getBool(_kSystemNotificationsEnabledKey),
      hybridPresenceSupport: snapshot.getBool(_kHybridPresenceEnabledKey),
      isVoicemailEnabled: snapshot.getBool(_kVoicemailEnabledKey),
      isCallHistoryEnabled: snapshot.getBool(_kCallHistoryEnabledKey),
      callPullVideoStrategy: callPullVideoStrategy,
      monitorCheckInterval: monitorCheckInterval,
      logLevel: logLevel,
      remoteLoggingEnabled: snapshot.getBool(_kRemoteLoggingEnabledKey),
      isLogAnonymizationEnabled: snapshot.getBool(_kLogAnonymizationEnabledKey),
    );
  }
}
