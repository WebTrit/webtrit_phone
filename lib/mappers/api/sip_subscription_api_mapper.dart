import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin SipSubscriptionApiMapper {
  SipSubscription sipSubscriptionFromApi(api.SipSubscriptionItem item) {
    return SipSubscription(
      type: SipSubscriptionType.values.byName(item.type.name),
      number: item.number,
      contactUserId: item.contactUserId,
      subscribedAt: item.subscribedAt.toLocal(),
    );
  }

  api.SipSubscriptionBatchAction sipSubscriptionBatchActionFromModel(SipSubscriptionOutboxAction action) {
    return api.SipSubscriptionBatchAction(
      action: api.SipSubscriptionBatchActionType.values.byName(action.action.name),
      type: api.SipSubscriptionType.values.byName(action.type.name),
      number: action.number,
      contactUserId: action.contactUserId ?? '',
      subscribedAt: action.timestampUsec == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(action.timestampUsec!).toUtc(),
    );
  }
}
