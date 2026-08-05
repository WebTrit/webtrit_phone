import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'core.webtrit.com';
  const token = 'qwerty';
  const baseUri = 'https://$authority';

  group('RequestFailure', () {
    test('toString handles null statusCode with error', () {
      const requestId = 'req-null-status';
      const code = 'network_error';
      const path = 'connection';
      const reason = 'timeout reached';
      final uri = Uri.parse('$baseUri/login');

      final error = ErrorResponse(
        code: code,
        details: ErrorDetail(path: path, reason: reason),
      );

      final failure = RequestFailure(url: uri, statusCode: null, requestId: requestId, token: token, error: error);

      final logString = failure.toString();
      print('Log output: $logString');

      expect(logString, contains('RequestFailure'));
      expect(logString, contains('statusCode: null'));
      expect(logString, contains(requestId));
      expect(logString, contains(code));
      expect(logString, contains(path));
      expect(logString, contains(reason));
    });

    test('toString works when error is null', () {
      const requestId = 'req-no-error';
      final uri = Uri.parse('$baseUri/noerror');

      final failure = RequestFailure(url: uri, statusCode: 400, requestId: requestId, token: null, error: null);

      final logString = failure.toString();
      print('Log output: $logString');

      expect(logString, contains('RequestFailure'));
      expect(logString, contains('statusCode: 400'));
      expect(logString, contains(requestId));
      expect(logString, isNot(contains('code')));
    });

    test('toString includes details for 404 without error.details', () {
      const requestId = 'req-404-user';
      const code = 'not_found';
      final uri = Uri.parse('$baseUri/user');

      final error = ErrorResponse(code: code, details: null);

      final failure = RequestFailure(url: uri, statusCode: 404, requestId: requestId, token: null, error: error);

      final logString = failure.toString();
      print('Log output: $logString');

      expect(logString, contains('RequestFailure'));
      expect(logString, contains('404'));
      expect(logString, contains(code));
      expect(logString, contains(requestId));
      expect(logString, isNot(contains('path')));
      expect(logString, isNot(contains('reason')));
    });

    test('toString includes all details for 500 status', () {
      const requestId = 'req-500-abc';
      const code = 'external_api_issue';
      const path = 'token';
      const reason = 'service temporarily unavailable';
      final uri = Uri.parse('$baseUri/token');

      final error = ErrorResponse(
        code: code,
        details: ErrorDetail(path: path, reason: reason),
      );

      final failure = RequestFailure(url: uri, statusCode: 500, requestId: requestId, token: token, error: error);

      final logString = failure.toString();
      print('Log output: $logString');

      expect(logString, contains('RequestFailure'));
      expect(logString, contains('500'));
      expect(logString, contains(code));
      expect(logString, contains(path));
      expect(logString, contains(reason));
      expect(logString, contains(requestId));
    });

    group('classification getters', () {
      RequestFailure failure({int? statusCode, String? code}) => RequestFailure(
        url: Uri.parse('$baseUri/user'),
        statusCode: statusCode,
        requestId: 'req-classification',
        error: code != null ? ErrorResponse(code: code) : null,
      );

      test('isClientError is true only for 4xx', () {
        expect(failure(statusCode: 400).isClientError, isTrue);
        expect(failure(statusCode: 499).isClientError, isTrue);
        expect(failure(statusCode: 399).isClientError, isFalse);
        expect(failure(statusCode: 500).isClientError, isFalse);
        expect(failure(statusCode: null).isClientError, isFalse);
      });

      test('isServerError is true only for 5xx', () {
        expect(failure(statusCode: 500).isServerError, isTrue);
        expect(failure(statusCode: 599).isServerError, isTrue);
        expect(failure(statusCode: 499).isServerError, isFalse);
        expect(failure(statusCode: null).isServerError, isFalse);
      });

      test('isTransient is true only for 408, 425 and 429', () {
        expect(failure(statusCode: 408).isTransient, isTrue);
        expect(failure(statusCode: 425).isTransient, isTrue);
        expect(failure(statusCode: 429).isTransient, isTrue);
        expect(failure(statusCode: 422).isTransient, isFalse);
        expect(failure(statusCode: 503).isTransient, isFalse);
        expect(failure(statusCode: null).isTransient, isFalse);
      });

      test('errorCode exposes the backend error code when present', () {
        expect(failure(statusCode: 422, code: 'some_code').errorCode, 'some_code');
        expect(failure(statusCode: 422).errorCode, isNull);
      });
    });
  });
}
