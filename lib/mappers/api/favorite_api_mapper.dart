import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin FavoriteApiMapper {
  Favorite favoriteFromApi(api.FavoriteItem item) {
    return Favorite(
      number: item.number,
      sourceType: FavoriteSourceType.values.byName(item.sourceType.name),
      sourceId: item.sourceId,
      label: item.label,
      position: item.position,
    );
  }

  api.FavoriteBatchAction favoriteBatchActionFromModel(FavoriteOutboxAction action) {
    return api.FavoriteBatchAction(
      action: api.FavoriteBatchActionType.values.byName(action.action.name),
      number: action.number,
      sourceType: api.FavoriteSourceType.values.byName(action.sourceType.name),
      sourceId: action.sourceId,
      label: action.label,
      position: action.position,
    );
  }
}
