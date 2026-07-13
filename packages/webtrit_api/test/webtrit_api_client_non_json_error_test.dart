import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'demo.webtrit.com';

  WebtritApiClient clientAnswering(int statusCode, {String body = '', int expectedRequests = 1}) {
    Future<Response> handler(Request request) async {
      return Response(body, statusCode, request: request);
    }

    final httpClient = MockClient(expectAsync1(handler, count: expectedRequests));
    return WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);
  }

  group('non-JSON error response body', () {
    test('maps to RequestFailure carrying the status code and raw body, without retries', () {
      final apiClient = clientAnswering(404, body: '404 page not found');

      expect(
        apiClient.getSystemInfo(),
        throwsA(
          isA<RequestFailure>()
              .having((e) => e.statusCode, 'statusCode', 404)
              .having((e) => e.error, 'error', isNull)
              .having((e) => e.rawBody, 'rawBody', '404 page not found'),
        ),
      );
    });

    test('truncates an oversized raw body', () {
      final apiClient = clientAnswering(502, body: 'x' * 1000);

      expect(
        apiClient.getSystemInfo(),
        throwsA(isA<RequestFailure>().having((e) => e.rawBody, 'rawBody', '${'x' * 256}...')),
      );
    });

    test('keeps rawBody out of a parsed JSON error response', () {
      final apiClient = clientAnswering(500, body: '{"code": "internal_error"}');

      expect(
        apiClient.getSystemInfo(),
        throwsA(
          isA<RequestFailure>()
              .having((e) => e.errorCode, 'errorCode', 'internal_error')
              .having((e) => e.rawBody, 'rawBody', isNull),
        ),
      );
    });

    test('keeps FormatException for a malformed JSON body on a success status', () {
      final apiClient = clientAnswering(200, body: 'not json', expectedRequests: 2);

      expect(
        apiClient.getSystemInfo(options: const RequestOptions(retries: 1, retryDelay: Duration(milliseconds: 1))),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
