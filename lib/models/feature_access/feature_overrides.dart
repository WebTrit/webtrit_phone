import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/services/services.dart';

class FeatureOverrides extends Equatable {
  const FeatureOverrides({
    this.isVideoCallEnabled,
    this.isSystemNotificationsEnabled,
    this.isSipPresenceEnabled,
    this.isVoicemailEnabled,
  });

  final bool? isVideoCallEnabled;
  final bool? isSystemNotificationsEnabled;
  final bool? isSipPresenceEnabled;
  final bool? isVoicemailEnabled;

  @override
  List<Object?> get props => [
    isVideoCallEnabled,
    isSystemNotificationsEnabled,
    isSipPresenceEnabled,
    isVoicemailEnabled,
  ];
}

abstract final class FeatureOverridesFactory {
  static const _kVideoCallEnabledKey = 'feature_video_call_enabled';
  static const _kSystemNotificationsEnabledKey = 'feature_system_notifications_enabled';
  static const _kSipPresenceEnabledKey = 'feature_sip_presence_enabled';
  static const _kVoicemailEnabledKey = 'feature_voicemail_enabled';

  static FeatureOverrides create(RemoteConfigSnapshot snapshot) {
    return FeatureOverrides(
      isVideoCallEnabled: snapshot.getBool(_kVideoCallEnabledKey),
      isSystemNotificationsEnabled: snapshot.getBool(_kSystemNotificationsEnabledKey),
      isSipPresenceEnabled: snapshot.getBool(_kSipPresenceEnabledKey),
      isVoicemailEnabled: snapshot.getBool(_kVoicemailEnabledKey),
    );
  }
}
