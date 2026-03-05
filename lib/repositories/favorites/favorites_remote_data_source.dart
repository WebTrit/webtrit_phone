import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class FavoritesPullResult {
  const FavoritesPullResult({required this.notModified, required this.etag, required this.items});

  final bool notModified;
  final String etag;
  final List<Favorite> items;
}

class FavoritesBatchSyncResult {
  const FavoritesBatchSyncResult({required this.etag, required this.items});

  final String etag;
  final List<Favorite> items;
}

abstract class FavoritesRemoteDataSource {
  Future<FavoritesPullResult> getFavorites({String? ifNoneMatch});

  Future<FavoritesBatchSyncResult> batchSyncFavorites(List<FavoriteOutboxAction> actions);
}

class FavoritesRemoteDataSourceApiImpl with FavoriteApiMapper implements FavoritesRemoteDataSource {
  FavoritesRemoteDataSourceApiImpl({required api.WebtritApiClient apiClient, required String apiToken})
    : _apiClient = apiClient,
      _apiToken = apiToken;

  final api.WebtritApiClient _apiClient;
  final String _apiToken;

  @override
  Future<FavoritesPullResult> getFavorites({String? ifNoneMatch}) async {
    final result = await _apiClient.getFavorites(_apiToken, ifNoneMatch: ifNoneMatch);
    if (result.notModified) {
      return FavoritesPullResult(notModified: true, etag: result.etag, items: const []);
    }

    return FavoritesPullResult(
      notModified: false,
      etag: result.etag,
      items: result.data!.items.map(favoriteFromApi).toList(),
    );
  }

  @override
  Future<FavoritesBatchSyncResult> batchSyncFavorites(List<FavoriteOutboxAction> actions) async {
    final response = await _apiClient.batchSyncFavorites(_apiToken, actions.map(favoriteBatchActionFromModel).toList());

    return FavoritesBatchSyncResult(etag: response.etag, items: response.data.items.map(favoriteFromApi).toList());
  }
}
