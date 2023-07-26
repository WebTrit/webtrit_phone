import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'core.webtrit.com';
  const token = 'qwerty';

  group('info', () {
    test('get info', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('get'));
        expect(request.url.toString(), equals('https://$authority/api/v1/system-info'));
        expect(request.headers['authorization'], isNull);
        return Response(
          jsonEncode({
            'core': {'version': '1.0.0'},
            'postgres': {'version': '1.0.0'}
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.getSystemInfo(),
        completion(equals(
          SystemInfo(
            core: CoreInfo(
              version: Version(1, 0, 0),
            ),
            postgres: PostgresInfo(
              version: '1.0.0',
            ),
          ),
        )),
      );
    });
  });

  group('session', () {
    test('create user with otp provisional result', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_1',
              'type': 'web',
              'identifier': 'identifier_1',
              'email': 'email_1',
            },
          ),
        );
        return Response(
          jsonEncode({
            'otp_id': 'otp_id_1',
            'notification_type': 'email',
            'from_email': 'from_email_1',
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createUser(SessionUserCredential(
          bundleId: 'bundle_id_1',
          type: AppType.web,
          identifier: 'identifier_1',
          email: 'email_1',
        )),
        completion(equals(
          SessionOtpProvisional(
            otpId: 'otp_id_1',
            notificationType: OtpNotificationType.email,
            fromEmail: 'from_email_1',
          ),
        )),
      );
    });

    test('create user with token result', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_1',
              'type': 'web',
              'identifier': 'identifier_1',
              'email': 'email_1',
            },
          ),
        );
        return Response(
          jsonEncode({
            'token': token,
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createUser(SessionUserCredential(
          bundleId: 'bundle_id_1',
          type: AppType.web,
          identifier: 'identifier_1',
          email: 'email_1',
        )),
        completion(equals(
          SessionToken(
            token: token,
          ),
        )),
      );
    });

    test('create user with data result', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_1',
              'type': 'web',
              'identifier': 'identifier_1',
              'email': 'email_1',
            },
          ),
        );
        return Response(
          jsonEncode({
            'k1': 'v1',
            'k2': 'v2',
            'k3': 'v3',
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createUser(SessionUserCredential(
          bundleId: 'bundle_id_1',
          type: AppType.web,
          identifier: 'identifier_1',
          email: 'email_1',
        )),
        completion(equals(
          SessionData(
            data: {
              'k1': 'v1',
              'k2': 'v2',
              'k3': 'v3',
            },
          ),
        )),
      );
    });

    test('otp request', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session/otp-create'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_1',
              'type': 'web',
              'identifier': 'identifier_1',
              'user_ref': 'phone_1',
            },
          ),
        );
        return Response(
          jsonEncode({
            'otp_id': 'otp_id_1',
            'notification_type': 'email',
            'from_email': 'from_email_1',
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createSessionOtp(SessionOtpCredential(
          bundleId: 'bundle_id_1',
          type: AppType.web,
          identifier: 'identifier_1',
          userRef: 'phone_1',
        )),
        completion(equals(
          SessionOtpProvisional(
            otpId: 'otp_id_1',
            notificationType: OtpNotificationType.email,
            fromEmail: 'from_email_1',
          ),
        )),
      );
    });

    test('otp verify', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session/otp-verify'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'otp_id': 'otp_id_1',
              'code': 'code_1',
            },
          ),
        );
        return Response(
          jsonEncode({
            'token': token,
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.verifySessionOtp(
          SessionOtpProvisional(otpId: 'otp_id_1'),
          'code_1',
        ),
        completion(equals(SessionToken(token: token))),
      );
    });

    test('login', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_1',
              'type': 'web',
              'identifier': 'identifier_1',
              'login': 'login_1',
              'password': 'password_1',
            },
          ),
        );
        return Response(
          jsonEncode({
            'token': token,
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createSession(SessionLoginCredential(
          bundleId: 'bundle_id_1',
          type: AppType.web,
          identifier: 'identifier_1',
          login: 'login_1',
          password: 'password_1',
        )),
        completion(equals(SessionToken(token: token))),
      );
    });

    test('logout', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('delete'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          '',
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.deleteSession(token),
        completion(anything),
      );
    });
  });

  group('account', () {
    test('get info', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('get'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          jsonEncode({
            'sip': {
              'display_name': 'display_name_1',
              'login': 'login_1',
              'password': 'strong_password',
            },
            'balance': {
              'amount': 111.1,
              'balance_type': 'unknown',
              'currency': 'UAH',
            },
            'numbers': {
              'main': '14155551234',
              'ext': '0001',
              'additional': ['380441234567', '34911234567'],
            },
            'first_name': 'first_name_1',
            'last_name': 'last_name_1',
            'email': 'email_1',
            'company_name': 'company_name_1',
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.getUserInfo(token),
        completion(equals(
          UserInfo(
            sip: SipInfo(
              displayName: 'display_name_1',
              login: 'login_1',
              password: 'strong_password',
            ),
            balance: Balance(
              amount: 111.1,
              balanceType: BalanceType.unknown,
              currency: 'UAH',
            ),
            numbers: Numbers(
              main: '14155551234',
              ext: '0001',
              additional: [
                '380441234567',
                '34911234567',
              ],
            ),
            firstName: 'first_name_1',
            lastName: 'last_name_1',
            email: 'email_1',
            companyName: 'company_name_1',
          ),
        )),
      );
    });

    test('get contacts', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('get'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user/contacts'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          jsonEncode({
            'items': [
              {
                'sip': {'display_name': 'display_name_1', 'status': 'unknown'},
                'numbers': {
                  'main': '14155551234',
                  'ext': '0001',
                  'additional': ['380441234567', '34911234567'],
                },
                'first_name': 'first_name_1',
                'last_name': 'last_name_1',
                'email': 'email_1',
                'company_name': 'company_name',
              },
              {
                'numbers': {
                  'main': 'number_2',
                },
                'first_name': 'first_name_2',
                'last_name': 'last_name_2',
                'email': 'email_2',
              }
            ]
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.getUserContactList(token),
        completion(equals(
          [
            UserContact(
              sip: SipStatus(
                displayName: 'display_name_1',
                status: 'unknown',
              ),
              numbers: Numbers(
                main: '14155551234',
                ext: '0001',
                additional: [
                  '380441234567',
                  '34911234567',
                ],
              ),
              firstName: 'first_name_1',
              lastName: 'last_name_1',
              email: 'email_1',
              companyName: 'company_name',
            ),
            UserContact(
              numbers: Numbers(main: 'number_2'),
              firstName: 'first_name_2',
              lastName: 'last_name_2',
              email: 'email_2',
            ),
          ],
        )),
      );
    });
  });

  group('app', () {
    test('get status', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('get'));
        expect(request.url.toString(), equals('https://$authority/api/v1/app/status'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          jsonEncode({
            'register': true,
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.getAppStatus(token),
        completion(equals(
          AppStatus(
            register: true,
          ),
        )),
      );
    });

    test('update status', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('patch'));
        expect(request.url.toString(), equals('https://$authority/api/v1/app/status'));
        expect(request.headers['authorization'], endsWith(token));
        expect(
          jsonDecode(request.body),
          equals({
            'register': false,
          }),
        );
        return Response(
          '',
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.updateAppStatus(token, AppStatus(register: false)),
        completion(anything),
      );
    });

    test('create contacts', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/app/contacts'));
        expect(request.headers['authorization'], endsWith(token));
        expect(
          jsonDecode(request.body),
          equals(
            [
              {
                'identifier': 'identifier_1',
                'phones': [
                  'number_1_1',
                  'number_1_2',
                ],
              },
              {
                'identifier': 'identifier_2',
                'phones': [
                  'number_2_1',
                ],
              },
            ],
          ),
        );
        return Response(
          '',
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createAppContact(
          token,
          [
            AppContact(
              identifier: 'identifier_1',
              phones: [
                'number_1_1',
                'number_1_2',
              ],
            ),
            AppContact(
              identifier: 'identifier_2',
              phones: [
                'number_2_1',
              ],
            ),
          ],
        ),
        completion(anything),
      );
    });

    test('get smart contacts', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('get'));
        expect(request.url.toString(), equals('https://$authority/api/v1/app/contacts/smart'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          jsonEncode([
            {
              'identifier': 'identifier_1',
              'phones': [
                'number_1_1',
              ],
            },
            {
              'identifier': 'identifier_2',
              'phones': [
                'number_2_1',
              ],
            },
          ]),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.getAppSmartContactList(token),
        completion(equals(
          [
            AppSmartContact(
              identifier: 'identifier_1',
              phones: [
                'number_1_1',
              ],
            ),
            AppSmartContact(
              identifier: 'identifier_2',
              phones: [
                'number_2_1',
              ],
            ),
          ],
        )),
      );
    });

    test('create push token', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/app/push-tokens'));
        expect(request.headers['authorization'], endsWith(token));
        expect(
          jsonDecode(request.body),
          equals({
            'type': 'fcm',
            'value': 'push_token_value',
          }),
        );
        return Response(
          '',
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createAppPushToken(token, AppPushToken(type: AppPushTokenType.fcm, value: 'push_token_value')),
        completion(anything),
      );
    });
  });
}
