import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/services/services.dart';

class FeatureOverrides extends Equatable {
  const FeatureOverrides({
    this.isVideoCallEnabled,
    this.isSystemNotificationsEnabled,
    this.isSipPresenceEnabled,
    this.isVoicemailEnabled,
    this.monitorCheckInterval,
    this.logLevel,
  });

  final bool? isVideoCallEnabled;
  final bool? isSystemNotificationsEnabled;
  final bool? isSipPresenceEnabled;
  final bool? isVoicemailEnabled;
  final Duration? monitorCheckInterval;
  final Level? logLevel;

  @override
  List<Object?> get props => [
    isVideoCallEnabled,
    isSystemNotificationsEnabled,
    isSipPresenceEnabled,
    isVoicemailEnabled,
    monitorCheckInterval,
    logLevel,
  ];
}

abstract final class FeatureOverridesFactory {
  static const _kVideoCallEnabledKey = 'feature_video_call_enabled';
  static const _kSystemNotificationsEnabledKey = 'feature_system_notifications_enabled';
  static const _kSipPresenceEnabledKey = 'feature_sip_presence_enabled';
  static const _kVoicemailEnabledKey = 'feature_voicemail_enabled';
  static const _kMonitorCheckIntervalKey = 'feature_monitor_check_interval_sec';
  static const kLogLevelKey = 'feature_log_level';

  static FeatureOverrides create(RemoteConfigSnapshot snapshot) {
    final monitorIntervalSec = int.tryParse(snapshot.getString(_kMonitorCheckIntervalKey) ?? '');
    Duration? monitorCheckInterval;
    if (monitorIntervalSec != null) {
      monitorCheckInterval = Duration(seconds: monitorIntervalSec);
    }

    final logLevelName = snapshot.getString(kLogLevelKey);
    final logLevel = logLevelName != null
        ? Level.LEVELS.where((l) => l.name == logLevelName).firstOrNull
        : null;

    return FeatureOverrides(
      isVideoCallEnabled: snapshot.getBool(_kVideoCallEnabledKey),
      isSystemNotificationsEnabled: snapshot.getBool(_kSystemNotificationsEnabledKey),
      isSipPresenceEnabled: snapshot.getBool(_kSipPresenceEnabledKey),
      isVoicemailEnabled: snapshot.getBool(_kVoicemailEnabledKey),
      monitorCheckInterval: monitorCheckInterval,
      logLevel: logLevel,
    );
  }
}

