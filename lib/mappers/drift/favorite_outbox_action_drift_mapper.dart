import 'package:app_database/app_database.dart';

import 'package:webtrit_phone/models/models.dart';

mixin FavoriteOutboxActionDriftMapper {
  FavoriteOutboxAction favoriteOutboxActionFromDrift(FavoriteOutboxEntryData entry) {
    return FavoriteOutboxAction(
      action: FavoriteOutboxActionType.values.byName(entry.action.name),
      number: entry.number,
      sourceType: FavoriteSourceType.values.byName(entry.sourceType.name),
      sourceId: entry.sourceId,
      label: entry.label,
      position: entry.position,
      sendAttempts: entry.sendAttempts,
      timestampUsec: entry.timestampUsec,
    );
  }

  FavoriteOutboxEntryData favoriteOutboxActionToDrift(FavoriteOutboxAction action) {
    return FavoriteOutboxEntryData(
      action: FavoriteOutboxActionData.values.byName(action.action.name),
      number: action.number,
      sourceType: FavoriteSourceTypeData.values.byName(action.sourceType.name),
      sourceId: action.sourceId,
      label: action.label,
      position: action.position,
      sendAttempts: action.sendAttempts,
      timestampUsec: action.timestampUsec ?? DateTime.now().microsecondsSinceEpoch,
    );
  }
}
