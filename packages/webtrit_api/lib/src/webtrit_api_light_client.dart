import 'dart:async';
import 'dart:convert';

import 'package:_http_client/_http_client.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'webtrit_api_models.dart';
import 'webtrit_api_request_options.dart';
import 'webtrit_api_utils.dart';

class LightHttpClient {
  final Logger _logger;
  final http.Client _httpClient;

  LightHttpClient({
    http.Client? httpClient,
    Logger? logger,
    Duration? connectionTimeout,
    TrustedCertificates certs = TrustedCertificates.empty,
  })  : _httpClient = createHttpClient(
          connectionTimeout: connectionTimeout,
          certs: certs,
        ),
        _logger = logger ?? Logger('LightHttpClient');

  void close() {
    _httpClient.close();
  }

  Future<dynamic> execute(
    HttpMethod method,
    Uri url, {
    String? token,
    Object? requestDataJson,
    Map<String, String>? headers,
    RequestOptions options = const RequestOptions(),
  }) async {
    final httpRequest = http.Request(method.name, url);

    final xRequestId = ApiUtils.generateRequestId();

    httpRequest.headers.addAll({
      'content-type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'x-request-id': xRequestId,
      if (token != null) 'authorization': 'Bearer $token',
    });

    if (headers != null) {
      httpRequest.headers.addAll(headers);
    }

    if (requestDataJson != null) {
      httpRequest.body = jsonEncode(requestDataJson);
    }

    int requestAttempt = 0;

    while (true) {
      try {
        _logger.info('$method request($requestAttempt) to $url with requestId: $xRequestId');

        final httpResponse = await http.Response.fromStream(await _httpClient.send(httpRequest));
        final responseData = httpResponse.body;
        final responseDataJson = responseData.isEmpty ? {} : jsonDecode(responseData);

        _logger.info(
            '$method response with status code: ${httpResponse.statusCode} for requestId: $xRequestId, response body: $responseData');

        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
          return responseDataJson;
        } else {
          throw Exception('Request failed with status: ${httpResponse.statusCode}');
        }
      } catch (e) {
        _logger.severe('$method failed for requestId: $xRequestId with error: $e');
        if (requestAttempt >= options.retries) {
          throw Exception('Max retries reached: $e');
        }
        requestAttempt++;
        await Future.delayed(options.retryDelay);
      }
    }
  }
}
