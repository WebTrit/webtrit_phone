import 'package:flutter/widgets.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../models/models.dart';

extension ProcessingStatusL10n on CallProcessingStatus {
  String l10n(BuildContext context) {
    switch (this) {
      case CallProcessingStatus.incomingFromOffer || CallProcessingStatus.incomingFromPush:
        return context.l10n.callProcessingStatus_ringing;
      case CallProcessingStatus.incomingSubmittedAnswer || CallProcessingStatus.incomingPerformingStarted:
        return context.l10n.callProcessingStatus_preparing;
      case CallProcessingStatus.incomingInitializingMedia:
        return context.l10n.callProcessingStatus_init_media;
      case CallProcessingStatus.incomingAnswering:
        return context.l10n.callProcessingStatus_answering;

      case CallProcessingStatus.outgoingCreated || CallProcessingStatus.outgoingCreatedFromRefer:
        return context.l10n.callProcessingStatus_preparing;
      case CallProcessingStatus.outgoingConnectingToSignaling:
        return context.l10n.callProcessingStatus_signaling_connecting;
      case CallProcessingStatus.outgoingInitializingMedia:
        return context.l10n.callProcessingStatus_init_media;
      case CallProcessingStatus.outgoingOfferPreparing:
        return context.l10n.callProcessingStatus_invite;
      case CallProcessingStatus.outgoingOfferSent:
        return context.l10n.callProcessingStatus_routing;
      case CallProcessingStatus.outgoingRinging:
        return context.l10n.callProcessingStatus_ringing;

      case CallProcessingStatus.disconnecting:
        return context.l10n.callProcessingStatus_disconnecting;
      default:
        return '';
    }
  }
}
