import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

class SipSubscriptionsPullResult {
  const SipSubscriptionsPullResult({required this.notModified, required this.etag, required this.items});

  final bool notModified;
  final String etag;
  final List<SipSubscription> items;
}

class SipSubscriptionsBatchSyncResult {
  const SipSubscriptionsBatchSyncResult({required this.etag, required this.items});

  final String etag;
  final List<SipSubscription> items;
}

abstract class SipSubscriptionsRemoteDataSource {
  Future<SipSubscriptionsPullResult> getSipSubscriptions({String? ifNoneMatch});

  Future<SipSubscriptionsBatchSyncResult> batchSyncSipSubscriptions(List<SipSubscriptionOutboxAction> actions);
}

class SipSubscriptionsRemoteDataSourceApiImpl
    with SipSubscriptionApiMapper
    implements SipSubscriptionsRemoteDataSource {
  SipSubscriptionsRemoteDataSourceApiImpl({required api.WebtritApiClient apiClient, required String apiToken})
    : _apiClient = apiClient,
      _apiToken = apiToken;

  final api.WebtritApiClient _apiClient;
  final String _apiToken;

  @override
  Future<SipSubscriptionsPullResult> getSipSubscriptions({String? ifNoneMatch}) async {
    final result = await _apiClient.getSipSubscriptions(_apiToken, ifNoneMatch: ifNoneMatch);
    if (result.notModified) {
      return SipSubscriptionsPullResult(notModified: true, etag: result.etag, items: const []);
    }

    return SipSubscriptionsPullResult(
      notModified: false,
      etag: result.etag,
      items: result.data!.subscriptions.map(sipSubscriptionFromApi).toList(),
    );
  }

  @override
  Future<SipSubscriptionsBatchSyncResult> batchSyncSipSubscriptions(List<SipSubscriptionOutboxAction> actions) async {
    final response = await _apiClient.batchSyncSipSubscriptions(
      _apiToken,
      actions.map(sipSubscriptionBatchActionFromModel).toList(),
    );

    return SipSubscriptionsBatchSyncResult(
      etag: response.etag,
      items: response.data.subscriptions.map(sipSubscriptionFromApi).toList(),
    );
  }
}
