import 'package:pub_semver/pub_semver.dart';

import '../exceptions.dart';
import '../models/models.dart';
import 'store_client.dart';

class GooglePlayStoreClient extends BaseStoreClient {
  GooglePlayStoreClient({
    super.httpClient,
  });

  @override
  Future<StoreInfo?> getStoreInfo(String appPackageName) async {
    final viewUrl = Uri.https(
      'play.google.com',
      '/store/apps/details',
      {
        'id': appPackageName,
      },
    );
    print('viewUrl: $viewUrl');
    final response = await get(
      viewUrl,
    );
    if (response.statusCode != 200) {
      throw StoreInfoExtractorResponseError(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase,
      );
    } else {
      final match = RegExp(r'\[\[\["(\d+.\d+.\d+)"\]\]').firstMatch(response.body);
      if (match == null) {
        return null;
      } else {
        final versionValue = match.group(1);
        if (versionValue == null) {
          return null;
        } else {
          return StoreInfo(
            version: Version.parse(versionValue),
            viewUrl: viewUrl,
          );
        }
      }
    }
  }
}
