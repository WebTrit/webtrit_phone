import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';

import '../exceptions.dart';
import '../models/models.dart';
import 'store_client.dart';

class AppleAppStoreClient extends BaseStoreClient {
  AppleAppStoreClient({
    super.httpClient,
  });

  @override
  Future<StoreInfo?> getStoreInfo(String appPackageName) async {
    final lookupUrl = Uri.https(
      'itunes.apple.com',
      '/lookup',
      {
        'bundleId': appPackageName,
      },
    );
    final response = await get(
      lookupUrl,
      headers: {
        'Cache-Control': 'no-cache',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode != 200) {
      throw StoreInfoExtractorResponseError(
        statusCode: response.statusCode,
        reasonPhrase: response.reasonPhrase,
      );
    } else {
      try {
        final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;
        final resultsJson = bodyJson['results'] as List<dynamic>;
        if (resultsJson.isEmpty) {
          return null;
        } else {
          final resultJson = resultsJson[0] as Map<String, dynamic>;
          final versionValue = resultJson['version'] as String;
          final trackViewUrlValue = resultJson['trackViewUrl'] as String;

          return StoreInfo(
            version: Version.parse(versionValue),
            viewUrl: Uri.parse(trackViewUrlValue),
          );
        }
      } catch (e) {
        throw StoreInfoExtractorResponseFormatException(
          sourceError: e,
        );
      }
    }
  }
}
