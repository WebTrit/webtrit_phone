import 'package:freezed_annotation/freezed_annotation.dart';

part 'sip_subscriptions.freezed.dart';
part 'sip_subscriptions.g.dart';

enum SipSubscriptionType { presence, blf }

@freezed
class SipSubscriptionsGetResult with _$SipSubscriptionsGetResult {
  const SipSubscriptionsGetResult({required this.notModified, required this.etag, this.data});

  @override
  final bool notModified;

  @override
  final String etag;

  @override
  final SipSubscriptionsListResponse? data;
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SipSubscriptionsListResponse with _$SipSubscriptionsListResponse {
  const SipSubscriptionsListResponse({required this.subscriptions});

  @override
  final List<SipSubscriptionItem> subscriptions;

  factory SipSubscriptionsListResponse.fromJson(Map<String, Object?> json) =>
      _$SipSubscriptionsListResponseFromJson(json);

  Map<String, Object?> toJson() => _$SipSubscriptionsListResponseToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SipSubscriptionItem with _$SipSubscriptionItem {
  const SipSubscriptionItem({
    required this.type,
    required this.number,
    required this.contactUserId,
    required this.subscribedAt,
  });

  @override
  final SipSubscriptionType type;

  @override
  final String number;

  @override
  final String contactUserId;

  @override
  final DateTime subscribedAt;

  factory SipSubscriptionItem.fromJson(Map<String, Object?> json) => _$SipSubscriptionItemFromJson(json);

  Map<String, Object?> toJson() => _$SipSubscriptionItemToJson(this);
}

enum SipSubscriptionBatchActionType { upsert, delete }

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SipSubscriptionBatchAction with _$SipSubscriptionBatchAction {
  const SipSubscriptionBatchAction({
    required this.action,
    required this.type,
    required this.number,
    required this.contactUserId,
    this.subscribedAt,
  });

  @override
  final SipSubscriptionBatchActionType action;

  @override
  final SipSubscriptionType type;

  @override
  final String number;

  @override
  final String contactUserId;

  @override
  final DateTime? subscribedAt;

  factory SipSubscriptionBatchAction.fromJson(Map<String, Object?> json) => _$SipSubscriptionBatchActionFromJson(json);

  Map<String, Object?> toJson() => _$SipSubscriptionBatchActionToJson(this);
}

@freezed
class SipSubscriptionBatchSyncResult with _$SipSubscriptionBatchSyncResult {
  const SipSubscriptionBatchSyncResult({required this.data, required this.etag});

  @override
  final SipSubscriptionBatchSyncResponse data;

  @override
  final String etag;
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SipSubscriptionBatchSyncResponse with _$SipSubscriptionBatchSyncResponse {
  const SipSubscriptionBatchSyncResponse({required this.subscriptions, required this.conflicts});

  @override
  final List<SipSubscriptionItem> subscriptions;

  @override
  final List<SipSubscriptionBatchConflict> conflicts;

  factory SipSubscriptionBatchSyncResponse.fromJson(Map<String, Object?> json) =>
      _$SipSubscriptionBatchSyncResponseFromJson(json);

  Map<String, Object?> toJson() => _$SipSubscriptionBatchSyncResponseToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SipSubscriptionBatchConflict with _$SipSubscriptionBatchConflict {
  const SipSubscriptionBatchConflict({
    required this.action,
    required this.type,
    required this.number,
    required this.contactUserId,
    required this.reason,
  });

  @override
  final SipSubscriptionBatchActionType action;

  @override
  final SipSubscriptionType type;

  @override
  final String number;

  @override
  final String? contactUserId;

  @override
  final SipSubscriptionBatchConflictReason reason;

  factory SipSubscriptionBatchConflict.fromJson(Map<String, Object?> json) =>
      _$SipSubscriptionBatchConflictFromJson(json);

  Map<String, Object?> toJson() => _$SipSubscriptionBatchConflictToJson(this);
}

enum SipSubscriptionBatchConflictReason {
  @JsonValue('not_found')
  notFound,
}
