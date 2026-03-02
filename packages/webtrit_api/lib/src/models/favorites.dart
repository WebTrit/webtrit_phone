import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites.freezed.dart';
part 'favorites.g.dart';

enum FavoriteSourceType { pbx, device }

@freezed
class FavoritesGetResult with _$FavoritesGetResult {
  const FavoritesGetResult({required this.notModified, required this.etag, this.data});

  @override
  final bool notModified;

  @override
  final String etag;

  @override
  final FavoritesListResponse? data;
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoritesListResponse with _$FavoritesListResponse {
  const FavoritesListResponse({required this.items});

  @override
  final List<FavoriteItem> items;

  factory FavoritesListResponse.fromJson(Map<String, Object?> json) => _$FavoritesListResponseFromJson(json);

  Map<String, Object?> toJson() => _$FavoritesListResponseToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoriteItem with _$FavoriteItem {
  const FavoriteItem({
    required this.number,
    required this.sourceType,
    required this.sourceId,
    required this.label,
    required this.position,
  });

  @override
  final String number;

  @override
  final FavoriteSourceType sourceType;

  @override
  final String sourceId;

  @override
  final String label;

  @override
  final int position;

  factory FavoriteItem.fromJson(Map<String, Object?> json) => _$FavoriteItemFromJson(json);

  Map<String, Object?> toJson() => _$FavoriteItemToJson(this);
}

enum FavoriteBatchActionType { upsert, delete }

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoriteBatchAction with _$FavoriteBatchAction {
  const FavoriteBatchAction({
    required this.action,
    required this.number,
    required this.sourceType,
    required this.sourceId,
    this.label,
    this.position,
  });

  @override
  final FavoriteBatchActionType action;

  @override
  final String number;

  @override
  final FavoriteSourceType sourceType;

  @override
  final String? sourceId;

  @override
  final String? label;

  @override
  final int? position;

  factory FavoriteBatchAction.fromJson(Map<String, Object?> json) => _$FavoriteBatchActionFromJson(json);

  Map<String, Object?> toJson() => _$FavoriteBatchActionToJson(this);
}

@freezed
class FavoriteBatchSyncResult with _$FavoriteBatchSyncResult {
  const FavoriteBatchSyncResult({required this.data, required this.etag});

  @override
  final FavoriteBatchSyncResponse data;

  @override
  final String etag;
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoriteBatchSyncResponse with _$FavoriteBatchSyncResponse {
  const FavoriteBatchSyncResponse({required this.items, required this.conflicts});

  @override
  final List<FavoriteItem> items;

  @override
  final List<FavoriteBatchConflict> conflicts;

  factory FavoriteBatchSyncResponse.fromJson(Map<String, Object?> json) => _$FavoriteBatchSyncResponseFromJson(json);

  Map<String, Object?> toJson() => _$FavoriteBatchSyncResponseToJson(this);
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class FavoriteBatchConflict with _$FavoriteBatchConflict {
  const FavoriteBatchConflict({
    required this.action,
    required this.number,
    required this.sourceType,
    required this.sourceId,
    required this.reason,
  });

  @override
  final FavoriteBatchActionType action;

  @override
  final String number;

  @override
  final FavoriteSourceType sourceType;

  @override
  final String sourceId;

  @override
  final FavoriteBatchConflictReason reason;

  factory FavoriteBatchConflict.fromJson(Map<String, Object?> json) => _$FavoriteBatchConflictFromJson(json);

  Map<String, Object?> toJson() => _$FavoriteBatchConflictToJson(this);
}

enum FavoriteBatchConflictReason {
  @JsonValue('limit_reached')
  limitReached,
  @JsonValue('not_found')
  notFound,
  @JsonValue('label_required')
  labelRequired,
}
