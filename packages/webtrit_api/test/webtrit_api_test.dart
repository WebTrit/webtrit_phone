import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:webtrit_api/webtrit_api.dart';

void main() {
  const authority = 'core.webtrit.com';
  const token = 'qwerty';
  const userId = '123';

  group('buildTenantUrl', () {
    test('do not add tenant path segments for empty tenantId 1', () {
      final baseUrl = Uri.https(authority, '/');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('https://$authority/'));
    });

    test('do not add tenant path segments for empty tenantId 2', () {
      final baseUrl = Uri.https(authority, '/path1/path2');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('https://$authority/path1/path2'));
    });

    test('add tenant path segments for not empty tenantId 1', () {
      final baseUrl = Uri.https(authority, '/');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, 'tid');
      expect(tenantUrl.toString(), equals('https://$authority/tenant/tid'));
    });

    test('add tenant path segments for not empty tenantId 2', () {
      final baseUrl = Uri.https(authority, '/path1/path2');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, 'tid');
      expect(tenantUrl.toString(), equals('https://$authority/path1/path2/tenant/tid'));
    });

    test('do not update tenant path segments for empty tenantId 1', () {
      final baseUrl = Uri.https(authority, '/tenant/tid1');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('https://$authority/tenant/tid1'));
    });

    test('do not update tenant path segments for empty tenantId 2', () {
      final baseUrl = Uri.https(authority, '/path1/path2/tenant/tid1');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, '');
      expect(tenantUrl.toString(), equals('https://$authority/path1/path2/tenant/tid1'));
    });

    test('update tenant path segments for not empty tenantId 1', () {
      final baseUrl = Uri.https(authority, '/tenant/tid1');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, 'tid2');
      expect(tenantUrl.toString(), equals('https://$authority/tenant/tid2'));
    });

    test('update tenant path segments for not empty tenantId 2', () {
      final baseUrl = Uri.https(authority, '/path1/path2/tenant/tid1');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, 'tid2');
      expect(tenantUrl.toString(), equals('https://$authority/path1/path2/tenant/tid2'));
    });

    test('update tenant path segments for not empty tenantId 3', () {
      final baseUrl = Uri.https(authority, '/path1/tenant/tid1/path2/tenant/tid2');
      final tenantUrl = WebtritApiClient.buildTenantUrl(baseUrl, 'tid3');
      expect(tenantUrl.toString(), equals('https://$authority/path1/tenant/tid1/path2/tenant/tid3'));
    });
  });

  group('info', () {
    test('get info', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('get'));
        expect(request.url.toString(), equals('https://$authority/api/v1/system-info'));
        expect(request.headers['authorization'], isNull);
        return Response(
          jsonEncode({
            'core': {'version': '1.0.0'},
            'postgres': {'version': '1.0.0'},
            'adapter': {
              'name': 'sample_text',
              'version': '1.2.3',
              'supported': ['feat1', 'feat2'],
              'custom': {'abc': 'qwe'},
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
            adapter: AdapterInfo(
              name: 'sample_text',
              version: '1.2.3',
              supported: ['feat1', 'feat2'],
              custom: {'abc': 'qwe'},
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
      Future<Response> handler1(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': null,
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

      Future<Response> handler2(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_2',
              'type': 'web',
              'identifier': 'identifier_2',
              'email': 'email_2',
            },
          ),
        );
        return Response(
          jsonEncode({
            'otp_id': 'otp_id_2',
            'notification_type': 'email',
            'from_email': 'from_email_2',
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsyncSend([handler1, handler2]));
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
      expect(
        apiClient.createUser(SessionUserCredential(
          bundleId: 'bundle_id_2',
          type: AppType.web,
          identifier: 'identifier_2',
          email: 'email_2',
        )),
        completion(equals(
          SessionOtpProvisional(
            otpId: 'otp_id_2',
            notificationType: OtpNotificationType.email,
            fromEmail: 'from_email_2',
          ),
        )),
      );
    });

    test('create user with token result', () {
      Future<Response> handler1(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': null,
              'type': 'web',
              'identifier': 'identifier_1',
              'email': 'email_1',
            },
          ),
        );
        return Response(
          jsonEncode({
            'token': token,
            'user_id': userId,
          }),
          200,
          request: request,
        );
      }

      Future<Response> handler2(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_2',
              'type': 'web',
              'identifier': 'identifier_2',
              'email': 'email_2',
            },
          ),
        );
        return Response(
          jsonEncode({
            'token': token,
            'user_id': userId,
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsyncSend([handler1, handler2]));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createUser(SessionUserCredential(
          type: AppType.web,
          identifier: 'identifier_1',
          email: 'email_1',
        )),
        completion(equals(
          SessionToken(token: token, userId: userId),
        )),
      );
      expect(
        apiClient.createUser(SessionUserCredential(
          bundleId: 'bundle_id_2',
          type: AppType.web,
          identifier: 'identifier_2',
          email: 'email_2',
        )),
        completion(equals(
          SessionToken(token: token, userId: userId),
        )),
      );
    });

    test('create user with data result', () {
      Future<Response> handler1(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': null,
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

      Future<Response> handler2(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_2',
              'type': 'web',
              'identifier': 'identifier_2',
              'email': 'email_2',
            },
          ),
        );
        return Response(
          jsonEncode({
            'k': 'v',
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsyncSend([handler1, handler2]));
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
      expect(
        apiClient.createUser(SessionUserCredential(
          bundleId: 'bundle_id_2',
          type: AppType.web,
          identifier: 'identifier_2',
          email: 'email_2',
        )),
        completion(equals(
          SessionData(
            data: {
              'k': 'v',
            },
          ),
        )),
      );
    });

    test('otp request', () {
      Future<Response> handler1(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session/otp-create'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': null,
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

      Future<Response> handler2(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session/otp-create'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_2',
              'type': 'web',
              'identifier': 'identifier_2',
              'user_ref': 'phone_2',
            },
          ),
        );
        return Response(
          jsonEncode({
            'otp_id': 'otp_id_2',
            'notification_type': 'email',
            'from_email': 'from_email_2',
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsyncSend([handler1, handler2]));
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
      expect(
        apiClient.createSessionOtp(SessionOtpCredential(
          bundleId: 'bundle_id_2',
          type: AppType.web,
          identifier: 'identifier_2',
          userRef: 'phone_2',
        )),
        completion(equals(
          SessionOtpProvisional(
            otpId: 'otp_id_2',
            notificationType: OtpNotificationType.email,
            fromEmail: 'from_email_2',
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
            'user_id': userId,
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
        completion(equals(SessionToken(token: token, userId: userId))),
      );
    });

    test('login', () {
      Future<Response> handler1(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals({
            'bundle_id': null,
            'type': 'web',
            'identifier': 'identifier_1',
            'login': 'login_1',
            'password': 'password_1',
          }),
        );
        return Response(
          jsonEncode({
            'token': token,
            'user_id': userId,
          }),
          200,
          request: request,
        );
      }

      Future<Response> handler2(Request request) async {
        expect(request.method, equalsIgnoringCase('post'));
        expect(request.url.toString(), equals('https://$authority/api/v1/session'));
        expect(request.headers['authorization'], isNull);
        expect(
          jsonDecode(request.body),
          equals(
            {
              'bundle_id': 'bundle_id_2',
              'type': 'web',
              'identifier': 'identifier_2',
              'login': 'login_2',
              'password': 'password_2',
            },
          ),
        );
        return Response(
          jsonEncode({
            'token': token,
            'user_id': userId,
          }),
          200,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsyncSend([handler1, handler2]));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.createSession(SessionLoginCredential(
          type: AppType.web,
          identifier: 'identifier_1',
          login: 'login_1',
          password: 'password_1',
        )),
        completion(equals(SessionToken(token: token, userId: userId))),
      );
      expect(
        apiClient.createSession(SessionLoginCredential(
          bundleId: 'bundle_id_2',
          type: AppType.web,
          identifier: 'identifier_2',
          login: 'login_2',
          password: 'password_2',
        )),
        completion(equals(SessionToken(token: token, userId: userId))),
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
            'email': 'email_1',
            'first_name': 'first_name_1',
            'last_name': 'last_name_1',
            'alias_name': 'alias_name_1',
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
            email: 'email_1',
            firstName: 'first_name_1',
            lastName: 'last_name_1',
            aliasName: 'alias_name_1',
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
                'user_id': '123',
                'sip_status': 'registered',
                'numbers': {
                  'main': '14155551234',
                  'ext': '0001',
                  'additional': ['380441234567', '34911234567'],
                },
                'first_name': 'first_name_1',
                'last_name': 'last_name_1',
                'email': 'email_1',
                'alias_name': 'alias_name_1',
                'company_name': 'company_name',
              },
              {
                'user_id': '234',
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
              userId: '123',
              sipStatus: SipStatus.registered,
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
              aliasName: 'alias_name_1',
              companyName: 'company_name',
            ),
            UserContact(
              userId: '234',
              numbers: Numbers(main: 'number_2'),
              firstName: 'first_name_2',
              lastName: 'last_name_2',
              email: 'email_2',
            ),
          ],
        )),
      );
    });

    test('delete info', () {
      Future<Response> handler(Request request) async {
        expect(request.method, equalsIgnoringCase('delete'));
        expect(request.url.toString(), equals('https://$authority/api/v1/user'));
        expect(request.headers['authorization'], endsWith(token));
        return Response(
          '',
          204,
          request: request,
        );
      }

      final httpClient = MockClient(expectAsync1(handler));
      final apiClient = WebtritApiClient.inner(Uri.https(authority), '', httpClient: httpClient);

      expect(
        apiClient.deleteUserInfo(token),
        completion(anything),
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

Func1<T, A> expectAsync1WithCallCounter<T, A>(T Function(A, int) callbackWithCounter,
    {int count = 1, int max = 0, String? id, String? reason}) {
  var callCounter = 0;
  T callback(A a) {
    callCounter++;
    return callbackWithCounter(a, callCounter);
  }

  return expectAsync1(callback, count: count, max: max, id: id, reason: reason);
}

Func1<T, A> expectAsyncSend<T, A>(List<T Function(A)> callbacks) {
  var callCounter = 0;
  T callback(A a) => callbacks[callCounter++](a);
  return expectAsync1(callback, count: callbacks.length);
}
