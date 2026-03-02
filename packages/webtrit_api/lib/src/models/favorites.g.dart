// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesListResponse _$FavoritesListResponseFromJson(
  Map<String, dynamic> json,
) => FavoritesListResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => FavoriteItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FavoritesListResponseToJson(
  FavoritesListResponse instance,
) => <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};

FavoriteItem _$FavoriteItemFromJson(Map<String, dynamic> json) => FavoriteItem(
  number: json['number'] as String,
  sourceType: $enumDecode(_$FavoriteSourceTypeEnumMap, json['source_type']),
  sourceId: json['source_id'] as String,
  label: json['label'] as String,
  position: (json['position'] as num).toInt(),
);

Map<String, dynamic> _$FavoriteItemToJson(FavoriteItem instance) =>
    <String, dynamic>{
      'number': instance.number,
      'source_type': _$FavoriteSourceTypeEnumMap[instance.sourceType]!,
      'source_id': instance.sourceId,
      'label': instance.label,
      'position': instance.position,
    };

const _$FavoriteSourceTypeEnumMap = {
  FavoriteSourceType.pbx: 'pbx',
  FavoriteSourceType.device: 'device',
};

FavoriteBatchAction _$FavoriteBatchActionFromJson(Map<String, dynamic> json) =>
    FavoriteBatchAction(
      action: $enumDecode(_$FavoriteBatchActionTypeEnumMap, json['action']),
      number: json['number'] as String,
      sourceType: $enumDecode(_$FavoriteSourceTypeEnumMap, json['source_type']),
      sourceId: json['source_id'] as String?,
      label: json['label'] as String?,
      position: (json['position'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavoriteBatchActionToJson(
  FavoriteBatchAction instance,
) => <String, dynamic>{
  'action': _$FavoriteBatchActionTypeEnumMap[instance.action]!,
  'number': instance.number,
  'source_type': _$FavoriteSourceTypeEnumMap[instance.sourceType]!,
  'source_id': instance.sourceId,
  'label': instance.label,
  'position': instance.position,
};

const _$FavoriteBatchActionTypeEnumMap = {
  FavoriteBatchActionType.upsert: 'upsert',
  FavoriteBatchActionType.delete: 'delete',
};

FavoriteBatchConflict _$FavoriteBatchConflictFromJson(
  Map<String, dynamic> json,
) => FavoriteBatchConflict(
  action: $enumDecode(_$FavoriteBatchActionTypeEnumMap, json['action']),
  number: json['number'] as String,
  sourceType: $enumDecode(_$FavoriteSourceTypeEnumMap, json['source_type']),
  sourceId: json['source_id'] as String,
  reason: $enumDecode(_$FavoriteBatchConflictReasonEnumMap, json['reason']),
);

Map<String, dynamic> _$FavoriteBatchConflictToJson(
  FavoriteBatchConflict instance,
) => <String, dynamic>{
  'action': _$FavoriteBatchActionTypeEnumMap[instance.action]!,
  'number': instance.number,
  'source_type': _$FavoriteSourceTypeEnumMap[instance.sourceType]!,
  'source_id': instance.sourceId,
  'reason': _$FavoriteBatchConflictReasonEnumMap[instance.reason]!,
};

const _$FavoriteBatchConflictReasonEnumMap = {
  FavoriteBatchConflictReason.limitReached: 'limit_reached',
  FavoriteBatchConflictReason.notFound: 'not_found',
  FavoriteBatchConflictReason.labelRequired: 'label_required',
};

FavoriteBatchSyncResponse _$FavoriteBatchSyncResponseFromJson(
  Map<String, dynamic> json,
) => FavoriteBatchSyncResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => FavoriteItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  conflicts: (json['conflicts'] as List<dynamic>)
      .map((e) => FavoriteBatchConflict.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FavoriteBatchSyncResponseToJson(
  FavoriteBatchSyncResponse instance,
) => <String, dynamic>{
  'items': instance.items.map((e) => e.toJson()).toList(),
  'conflicts': instance.conflicts.map((e) => e.toJson()).toList(),
};
