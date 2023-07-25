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
        expect(request.url.toString(), equals('https://$authority/api/v1/info'));
        expect(request.headers['authorization'], isNull);
        return Response(
          jsonEncode({
            'core': {
              'version': '1.0.0',
            },
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
              version: Version(1, 0, 0),
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
        expect(request.url.toString(), equals('https://$authority/api/v1/session/otp-request'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'type': 'web',
              'identifier': 'identifier_1',
              'phone': 'phone_1',
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
        expect(request.url.toString(), equals('https://$authority/api/v1/account/info'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          jsonEncode({
            'data': {
              'login': 'login_1',
              'billing_model': 'recharge_voucher',
              'balance_control_type': 'individual_credit_limit',
              'balance': 111.1,
              'currency': 'UAH',
              'extension_name': 'extension_name_1',
              'firstname': 'first_name_1',
              'lastname': 'last_name_1',
              'company_name': 'company_name_1',
              'ext': 'ext_1',
            },
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
            balance: Balance(amount: 111.1, currency: 'UAH', balanceType: BalanceType.prepaid),
            sip: UserSipInfo(login: 'login_1'),
            firstName: 'first_name_1',
            lastName: 'last_name_1',
            companyName: 'company_name_1',
          ),
        )),
      );
    });

    test('get contacts', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('get'));
        expect(request.url.toString(), equals('https://$authority/api/v1/account/contacts'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          jsonEncode({
            'items': [
              {
                'number': 'number_1',
                'extension_id': 'extension_id_1',
                'extension_name': 'extension_name_1',
                'firstname': 'first_name_1',
                'lastname': 'last_name_1',
                'email': 'email_1',
                'mobile': 'mobile_1',
                'company_name': 'company_name_1',
                'sip_status': 1,
              },
              {
                'number': 'number_2',
                'extension_id': 'extension_id_2',
                'sip_status': 0,
              },
            ],
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
              numbers: Numbers(main: 'number_1'),
              firstName: 'first_name_1',
              lastName: 'last_name_1',
              email: 'email_1',
              companyName: 'company_name_1',
              sip: UserContactSip(displayName: 'number_1', status: '0'),
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
