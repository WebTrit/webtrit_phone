import 'dart:async';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'demo.webtrit.com';
  const token = 'token_1';

  WebtritApiClient clientAnswering(int statusCode, {String body = ''}) {
    Future<Response> handler(Request request) async {
      return Response(body, statusCode, request: request);
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

    test('optional endpoint keeps EndpointNotSupportedException on 501 with a backend code', () {
      final apiClient = clientAnswering(501, body: '{"code": "functionality_not_implemented"}');

      expect(apiClient.getUserVoicemailList(token), throwsA(isA<EndpointNotSupportedException>()));
    });

    test('optional endpoint passes through a 404 carrying a backend code as plain RequestFailure', () {
      final apiClient = clientAnswering(404, body: '{"code": "message_not_found"}');

      expect(
        apiClient.getUserVoicemail(token, 'message_1'),
        throwsA(
          isA<RequestFailure>()
              .having((e) => e is EndpointNotSupportedException, 'is not typed', isFalse)
              .having((e) => e.errorCode, 'errorCode', 'message_not_found'),
        ),
      );
    });

    test('optional endpoint throws UserNotFoundException on 404 with user_not_found', () {
      final apiClient = clientAnswering(404, body: '{"code": "user_not_found"}');

      expect(apiClient.deleteUserInfo(token), throwsA(isA<UserNotFoundException>()));
    });

    test('mandatory endpoint throws UserNotFoundException on 404 with user_not_found', () {
      final apiClient = clientAnswering(404, body: '{"code": "user_not_found"}');

      expect(apiClient.getUserContactList(token), throwsA(isA<UserNotFoundException>()));
    });
  });

  group('failure log level', () {
    late List<LogRecord> records;
    late StreamSubscription<LogRecord> subscription;

    setUp(() {
      Logger.root.level = Level.ALL;
      records = [];
      subscription = Logger('WebtritApiClient').onRecord.listen((record) {
        if (record.level > Level.INFO) records.add(record);
      });
    });

    tearDown(() => subscription.cancel());

    test('client error (mandatory 404) is logged as warning', () async {
      final apiClient = clientAnswering(404);

      await expectLater(apiClient.getUserContactList(token), throwsA(isA<RequestFailure>()));

      expect(records, hasLength(1));
      expect(records.single.level, Level.WARNING);
    });

    test('server error (500) is logged as severe', () async {
      final apiClient = clientAnswering(500);

      await expectLater(apiClient.getUserContactList(token), throwsA(isA<RequestFailure>()));

      expect(records, hasLength(1));
      expect(records.single.level, Level.SEVERE);
    });

    test('optional endpoint 404 is not logged', () async {
      final apiClient = clientAnswering(404);

      await expectLater(apiClient.getUserVoicemailList(token), throwsA(isA<EndpointNotSupportedException>()));

      expect(records, isEmpty);
    });
  });
}
