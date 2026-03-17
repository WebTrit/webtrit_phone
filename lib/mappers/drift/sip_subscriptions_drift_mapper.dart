import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/models.dart';

mixin SipSubscriptionsDriftMapper {
  SipSubscription sipSubscriptionFromDrift(SipSubscriptionData data) {
    return SipSubscription(
      type: SipSubscriptionType.values.byName(data.type.name),
      number: data.number,
      contactUserId: data.contactUserId,
      subscribedAt: DateTime.fromMicrosecondsSinceEpoch(data.subscribedAtUsec),
    );
  }

  SipSubscriptionData sipSubscriptionToDrift(SipSubscription item) {
    return SipSubscriptionData(
      type: SipSubscriptionTypeData.values.byName(item.type.name),
      number: item.number,
      contactUserId: item.contactUserId,
      subscribedAtUsec: item.subscribedAt.microsecondsSinceEpoch,
    );
  }
}
