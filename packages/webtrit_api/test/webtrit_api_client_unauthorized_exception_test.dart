import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

const authority = 'example.com';
const baseUri = 'https://$authority';
const tenantId = 'tenant-id';
const token = 'fake_token';

class MockHttpClient extends Mock implements http.Client {}

class FakeBaseRequest extends Fake implements http.BaseRequest {}

http.StreamedResponse _jsonResponse(Object json, int status) {
  final body = jsonEncode(json);
  return http.StreamedResponse(
    Stream.value(utf8.encode(body)),
    status,
    headers: {'content-type': 'application/json'},
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeBaseRequest());
  });

  group('UnauthorizedException', () {
    late MockHttpClient mockHttpClient;
    late WebtritApiClient apiClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      apiClient = WebtritApiClient.inner(
        Uri.parse(baseUri),
        tenantId,
        httpClient: mockHttpClient,
      );
    });

    tearDown(() {
      apiClient.close();
      reset(mockHttpClient);
    });

    test('throws on 422 with code "refresh_token_invalid"', () async {
      when(() => mockHttpClient.send(any())).thenAnswer((_) async {
        return _jsonResponse(
          {
            'code': 'refresh_token_invalid',
            'message': 'Invalid refresh token',
          },
          422,
        );
      });

      expect(
        () => apiClient.getUserInfo(token),
        throwsA(
          isA<UnauthorizedException>()
              .having((e) => e.statusCode, 'statusCode', 422)
              .having(
                  (e) => e.error?.code, 'error.code', 'refresh_token_invalid'),
        ),
      );

      verify(() => mockHttpClient.send(any())).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });
  });
}
