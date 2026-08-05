import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'demo.webtrit.com';
  const token = 'token_1';

  WebtritApiClient clientCapturing(void Function(Request request) onRequest) {
    Future<Response> handler(Request request) async {
      onRequest(request);
      return Response.bytes(Uint8List.fromList(const [1, 2, 3]), 200, request: request);
    }

    final httpClient = MockClient(handler);
    return WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);
  }

  group('getUserVoicemailAttachment', () {
    test('forwards fileFormat as the file_format query parameter', () async {
      late Request captured;
      final apiClient = clientCapturing((request) => captured = request);

      await apiClient.getUserVoicemailAttachment(token, 'vm-1', fileFormat: 'wav');

      expect(captured.url.path, endsWith('/user/voicemails/vm-1/attachment'));
      expect(captured.url.queryParameters['file_format'], 'wav');
    });

    test('omits the query parameter when fileFormat is not provided', () async {
      late Request captured;
      final apiClient = clientCapturing((request) => captured = request);

      await apiClient.getUserVoicemailAttachment(token, 'vm-1');

      expect(captured.url.queryParameters.containsKey('file_format'), isFalse);
    });
  });
}
