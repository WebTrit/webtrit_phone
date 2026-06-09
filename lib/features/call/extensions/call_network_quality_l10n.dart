import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension CallNetworkQualityL10n on CallNetworkQuality {
  /// Short label shown beside the meter at [CallNetworkQualitySeverity.severe].
  /// Distinguishes your (uplink) vs the remote (downlink) stream and audio vs
  /// video. Lower severities are icon-only and do not use this.
  String severeLabel(BuildContext context) {
    switch ((uplink, media)) {
      case (true, CallMediaKind.audio):
        return context.l10n.callNetworkQuality_yourAudioWeak;
      case (true, CallMediaKind.video):
        return context.l10n.callNetworkQuality_yourVideoWeak;
      case (false, CallMediaKind.audio):
        return context.l10n.callNetworkQuality_theirAudioWeak;
      case (false, CallMediaKind.video):
        return context.l10n.callNetworkQuality_theirVideoWeak;
    }
  }
}
