// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sip_subscriptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SipSubscriptionsListResponse _$SipSubscriptionsListResponseFromJson(
  Map<String, dynamic> json,
) => SipSubscriptionsListResponse(
  subscriptions: (json['subscriptions'] as List<dynamic>)
      .map((e) => SipSubscriptionItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SipSubscriptionsListResponseToJson(
  SipSubscriptionsListResponse instance,
) => <String, dynamic>{
  'subscriptions': instance.subscriptions.map((e) => e.toJson()).toList(),
};

SipSubscriptionItem _$SipSubscriptionItemFromJson(Map<String, dynamic> json) =>
    SipSubscriptionItem(
      type: $enumDecode(_$SipSubscriptionTypeEnumMap, json['type']),
      number: json['number'] as String,
      contactUserId: json['contact_user_id'] as String,
      subscribedAt: DateTime.parse(json['subscribed_at'] as String),
    );

Map<String, dynamic> _$SipSubscriptionItemToJson(
  SipSubscriptionItem instance,
) => <String, dynamic>{
  'type': _$SipSubscriptionTypeEnumMap[instance.type]!,
  'number': instance.number,
  'contact_user_id': instance.contactUserId,
  'subscribed_at': instance.subscribedAt.toIso8601String(),
};

const _$SipSubscriptionTypeEnumMap = {
  SipSubscriptionType.presence: 'presence',
  SipSubscriptionType.blf: 'blf',
};

SipSubscriptionBatchAction _$SipSubscriptionBatchActionFromJson(
  Map<String, dynamic> json,
) => SipSubscriptionBatchAction(
  action: $enumDecode(_$SipSubscriptionBatchActionTypeEnumMap, json['action']),
  type: $enumDecode(_$SipSubscriptionTypeEnumMap, json['type']),
  number: json['number'] as String,
  contactUserId: json['contact_user_id'] as String,
  subscribedAt: json['subscribed_at'] == null
      ? null
      : DateTime.parse(json['subscribed_at'] as String),
);

Map<String, dynamic> _$SipSubscriptionBatchActionToJson(
  SipSubscriptionBatchAction instance,
) => <String, dynamic>{
  'action': _$SipSubscriptionBatchActionTypeEnumMap[instance.action]!,
  'type': _$SipSubscriptionTypeEnumMap[instance.type]!,
  'number': instance.number,
  'contact_user_id': instance.contactUserId,
  'subscribed_at': instance.subscribedAt?.toIso8601String(),
};

const _$SipSubscriptionBatchActionTypeEnumMap = {
  SipSubscriptionBatchActionType.upsert: 'upsert',
  SipSubscriptionBatchActionType.delete: 'delete',
};

SipSubscriptionBatchSyncResponse _$SipSubscriptionBatchSyncResponseFromJson(
  Map<String, dynamic> json,
) => SipSubscriptionBatchSyncResponse(
  subscriptions: (json['subscriptions'] as List<dynamic>)
      .map((e) => SipSubscriptionItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  conflicts: (json['conflicts'] as List<dynamic>)
      .map(
        (e) => SipSubscriptionBatchConflict.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$SipSubscriptionBatchSyncResponseToJson(
  SipSubscriptionBatchSyncResponse instance,
) => <String, dynamic>{
  'subscriptions': instance.subscriptions.map((e) => e.toJson()).toList(),
  'conflicts': instance.conflicts.map((e) => e.toJson()).toList(),
};

SipSubscriptionBatchConflict _$SipSubscriptionBatchConflictFromJson(
  Map<String, dynamic> json,
) => SipSubscriptionBatchConflict(
  action: $enumDecode(_$SipSubscriptionBatchActionTypeEnumMap, json['action']),
  type: $enumDecode(_$SipSubscriptionTypeEnumMap, json['type']),
  number: json['number'] as String,
  contactUserId: json['contact_user_id'] as String?,
  reason: $enumDecode(
    _$SipSubscriptionBatchConflictReasonEnumMap,
    json['reason'],
  ),
);

Map<String, dynamic> _$SipSubscriptionBatchConflictToJson(
  SipSubscriptionBatchConflict instance,
) => <String, dynamic>{
  'action': _$SipSubscriptionBatchActionTypeEnumMap[instance.action]!,
  'type': _$SipSubscriptionTypeEnumMap[instance.type]!,
  'number': instance.number,
  'contact_user_id': instance.contactUserId,
  'reason': _$SipSubscriptionBatchConflictReasonEnumMap[instance.reason]!,
};

const _$SipSubscriptionBatchConflictReasonEnumMap = {
  SipSubscriptionBatchConflictReason.notFound: 'not_found',
};
