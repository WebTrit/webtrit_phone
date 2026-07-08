import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'demo.webtrit.com';
  const token = 'token_1';

  WebtritApiClient clientAnswering(int statusCode) {
    Future<Response> handler(Request request) async {
      return Response('', statusCode, request: request);
    }

    final httpClient = MockClient(expectAsync1(handler));
    return WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);
  }

  group('optional endpoint declaration', () {
    test('optional endpoint throws EndpointNotSupportedException on 501', () {
      final apiClient = clientAnswering(501);

      expect(apiClient.getUserVoicemailList(token), throwsA(isA<EndpointNotSupportedException>()));
    });

    test('optional endpoint throws EndpointNotSupportedException on 404', () {
      final apiClient = clientAnswering(404);

      expect(apiClient.getUserVoicemailList(token), throwsA(isA<EndpointNotSupportedException>()));
    });

    test('mandatory endpoint throws plain RequestFailure on 501', () {
      final apiClient = clientAnswering(501);

      expect(
        apiClient.getUserInfo(token, options: RequestOptions.withNoRetries()),
        throwsA(isA<RequestFailure>().having((e) => e is EndpointNotSupportedException, 'is not typed', isFalse)),
      );
    });

    test('mandatory user endpoint keeps UserNotFoundException on 404', () {
      final apiClient = clientAnswering(404);

      expect(apiClient.getUserInfo(token), throwsA(isA<UserNotFoundException>()));
    });
  });
}
