import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'models/error.dart';
import 'utils/request_utils.dart';
import 'exceptions.dart';
import 'webtrit_api_response_options.dart';

class HttpRequestExecutor {
  final http.Client _httpClient;
  final Logger _logger;

  HttpRequestExecutor({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client(),
      _logger = Logger('HttpRequestExecutor');

  void close() => _httpClient.close();

  Future<dynamic> execute({
    required String method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    String? requestId,
    ResponseOptions responseOptions = const ResponseOptions(),
  }) async {
    final uri = Uri.parse(url);
    final request = http.Request(method.toUpperCase(), uri);

    final xRequestId = requestId ?? RequestUtil.generate();
    final finalHeaders = {'x-request-id': xRequestId, if (headers != null) ...headers};

    request.headers.addAll(finalHeaders);

    if (data != null) {
      request.body = jsonEncode(data);
      request.headers['Content-Type'] ??= 'application/json';
    }

    _logger.info('[$method] $url');

    try {
      final streamedResponse = await _httpClient.send(request);
      final httpResponse = await http.Response.fromStream(streamedResponse);

      final responseData = httpResponse.body;
      final responseDataJson = responseData.isEmpty ? {} : jsonDecode(responseData);

      _logger.info('${method.toUpperCase()} response ${httpResponse.statusCode} for $url: ${httpResponse.body}');

      if (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
        return switch (responseOptions.responseType) {
          ResponseType.json => responseDataJson,
          ResponseType.bytes => httpResponse.bodyBytes,
          ResponseType.raw => httpResponse,
        };
      } else {
        final error = switch (responseDataJson) {
          Map(isEmpty: true) => null,
          {'errors': {'detail': _}} => null,
          _ => ErrorResponse.fromJson(responseDataJson),
        };

        throw RequestFailure(
          url: uri,
          statusCode: httpResponse.statusCode,
          requestId: xRequestId,
          token: headers?['Authorization'],
          error: error,
        );
      }
    } catch (e, st) {
      _logger.severe('Request to $url failed: $e', e, st);
      rethrow;
    }
  }
}
