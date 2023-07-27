import 'dart:convert' as convert;

import '../_http_client/_http_client.dart'
    if (dart.library.html) '../_http_client/_http_client_html.dart'
    if (dart.library.io) '../_http_client/_http_client_io.dart' as platform;

import 'package:style/src/dto/dto.dart';

import 'api_exception.dart';

class ConfiguratorApi {
  ConfiguratorApi(this.baseUrl);

  final String baseUrl;

  Future<ApplicationDTO> getApplication({
    required String applicationId,
  }) async {
    var uri = '$baseUrl/applications/$applicationId';
    var url = Uri.parse(uri);

    var response = await platform.createHttpClient().get(url, headers: {
      'Accept': '*/*',
      'Content-Type': 'application/json',
    });
    if (response.statusCode != 200) {
      throw ApiException('Failed to fetch bundle info', response.statusCode);
    }

    var jsonResponse = convert.jsonDecode(response.body);

    return ApplicationDTO.fromJson(jsonResponse);
  }

  Future<ThemeDTO> getTheme({
    required String themeId,
    required String applicationId,
  }) async {
    var uri = '$baseUrl/applications/$applicationId/themes/$themeId';
    var response = await platform.createHttpClient().get(Uri.parse(uri));

    if (response.statusCode != 200) {
      throw ApiException('Failed to fetch bundle data', response.statusCode);
    }

    var jsonResponse = convert.jsonDecode(response.body);

    return ThemeDTO.fromJson(jsonResponse);
  }
}
