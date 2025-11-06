import 'dart:io';

import 'package:flutter/foundation.dart';

import '_http_client/_http_client.dart'
    if (dart.library.html) '_http_client/_http_client_html.dart'
    if (dart.library.io) '_http_client/_http_client_io.dart'
    as platform;
import 'models/models.dart';
import 'store_clients/store_clients.dart';

class StoreInfoExtractor {
  StoreInfoExtractor();

  StoreClient _createStoreClient(Duration? connectionTimeout) {
    if (kIsWeb) {
      return StubStoreClient();
    } else {
      if (Platform.isAndroid) {
        return GooglePlayStoreClient(httpClient: platform.createHttpClient(connectionTimeout: connectionTimeout));
      }

      if (Platform.isIOS || Platform.isMacOS) {
        return AppleAppStoreClient(httpClient: platform.createHttpClient(connectionTimeout: connectionTimeout));
      }

      throw UnimplementedError('Currently only supports Android, iOS, and MacOS platforms');
    }
  }

  Future<StoreInfo?> getStoreInfo(String appPackageName, {Duration? connectionTimeout}) {
    return _createStoreClient(connectionTimeout).getStoreInfo(appPackageName);
  }
}
