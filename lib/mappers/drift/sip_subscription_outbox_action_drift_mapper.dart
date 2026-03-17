import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/models.dart';

mixin SipSubscriptionOutboxActionDriftMapper {
  SipSubscriptionOutboxAction sipSubscriptionOutboxActionFromDrift(SipSubscriptionOutboxEntryData entry) {
    return SipSubscriptionOutboxAction(
      action: SipSubscriptionOutboxActionType.values.byName(entry.action.name),
      type: SipSubscriptionType.values.byName(entry.type.name),
      number: entry.number,
      contactUserId: entry.contactUserId,
      sendAttempts: entry.sendAttempts,
      timestampUsec: entry.timestampUsec,
    );
  }

  SipSubscriptionOutboxEntryData sipSubscriptionOutboxActionToDrift(SipSubscriptionOutboxAction action) {
    return SipSubscriptionOutboxEntryData(
      action: SipSubscriptionOutboxActionData.values.byName(action.action.name),
      type: SipSubscriptionTypeData.values.byName(action.type.name),
      number: action.number,
      contactUserId: action.contactUserId,
      sendAttempts: action.sendAttempts,
      timestampUsec: action.timestampUsec ?? DateTime.now().microsecondsSinceEpoch,
    );
  }
}
