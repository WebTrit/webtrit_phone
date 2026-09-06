import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  test('getCdrHistory sends filters and page parameters', () async {
    late Request captured;
    final httpClient = MockClient((request) async {
      captured = request;
      return Response('{"items": []}', 200, request: request, headers: const {'content-type': 'application/json'});
    });
    final apiClient = WebtritApiClient.inner(Uri.https('core.webtrit.com'), '', httpClient: httpClient);
    final from = DateTime.utc(2026, 1, 2, 3, 4, 5);
    final to = DateTime.utc(2026, 2, 3, 4, 5, 6);

    await apiClient.getCdrHistory('token', from: from, to: to, page: 3, limit: 50);

    expect(captured.method, equalsIgnoringCase('GET'));
    expect(captured.url.path, '/api/v1/user/history');
    expect(captured.url.queryParameters, {
      'time_from': from.toIso8601String(),
      'time_to': to.toIso8601String(),
      'page': '3',
      'items_per_page': '50',
    });
    expect(captured.headers['Authorization'], 'Bearer token');
  });
}
