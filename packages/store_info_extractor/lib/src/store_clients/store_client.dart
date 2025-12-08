import 'package:http/http.dart' as http;

import '../models/models.dart';

abstract class StoreClient {
  Future<StoreInfo?> getStoreInfo(String appPackageName);
}

abstract class BaseStoreClient extends StoreClient {
  BaseStoreClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) => _httpClient.get(url, headers: headers);
}
