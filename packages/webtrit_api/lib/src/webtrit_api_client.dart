import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '_http_client/_http_client.dart'
    if (dart.library.html) '_http_client/_http_client_html.dart'
    if (dart.library.io) '_http_client/_http_client_io.dart' as platform;
import 'exceptions.dart';
import 'models/models.dart';

class WebtritApiClient {
  WebtritApiClient(
    Uri baseUrl, {
    Duration? connectionTimeout,
  }) : this.inner(
          baseUrl,
          httpClient: platform.createHttpClient(
            connectionTimeout: connectionTimeout,
          ),
        );

  @visibleForTesting
  WebtritApiClient.inner(
    this.baseUrl, {
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  static const _apiVersionPathSegments = ['api', 'v1'];

  final Uri baseUrl;
  final http.Client _httpClient;

  void close() {
    _httpClient.close();
  }

  Future<dynamic> _httpClientExecute(String method, Uri url, String? token, Object? requestDataJson) async {
    final httpRequest = http.Request(method, url);
    httpRequest.headers.addAll({
      'content-type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      if (token != null) 'authorization': 'Bearer $token',
    });
    if (requestDataJson != null) {
      httpRequest.body = jsonEncode(requestDataJson);
    }
    final httpResponse = await http.Response.fromStream(await _httpClient.send(httpRequest));

    final responseData = httpResponse.body;
    final responseDataJson = responseData.isEmpty ? {} : jsonDecode(responseData);

    if (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
      return responseDataJson;
    } else {
      final error = responseDataJson.isEmpty ? null : ErrorResponse.fromJson(responseDataJson);
      throw RequestFailure(
        statusCode: httpResponse.statusCode,
        error: error,
      );
    }
  }

  Future<dynamic> _httpClientExecuteGet(Uri url, String? token) {
    return _httpClientExecute('get', url, token, null);
  }

  Future<dynamic> _httpClientExecutePost(Uri url, String? token, Object? requestDataJson) {
    return _httpClientExecute('post', url, token, requestDataJson);
  }

  Future<dynamic> _httpClientExecutePatch(Uri url, String? token, Object? requestDataJson) {
    return _httpClientExecute('patch', url, token, requestDataJson);
  }

  Future<dynamic> _httpClientExecuteDelete(Uri url, String? token) {
    return _httpClientExecute('delete', url, token, null);
  }

  Future<Info> info() async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['info'],
    );

    final responseJson = await _httpClientExecuteGet(url, null);

    final response = Info.fromJson(responseJson);

    return response;
  }

  Future<SessionOtpRequestResult> sessionOtpRequestDemo(AppType type, String identifier, String email) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session', 'otp-request-demo'],
    );

    final requestJson = SessionOtpRequestDemoRequest(
      type: type,
      identifier: identifier,
      email: email,
    ).toJson();

    final responseJson = await _httpClientExecutePost(url, null, requestJson);

    final response = SessionOtpRequestDemoResponse.fromJson(responseJson);

    return response;
  }

  Future<SessionOtpRequestResult> sessionOtpRequest(AppType type, String identifier, String phone) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session', 'otp-request'],
    );

    final requestJson = SessionOtpRequestRequest(
      type: type,
      identifier: identifier,
      phone: phone,
    ).toJson();

    final responseJson = await _httpClientExecutePost(url, null, requestJson);

    final response = SessionOtpRequestResponse.fromJson(responseJson);

    return response;
  }

  Future<String> sessionOtpVerify(String otpId, String code) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session', 'otp-verify'],
    );

    final requestJson = SessionOtpVerifyRequest(
      otpId: otpId,
      code: code,
    ).toJson();

    final responseJson = await _httpClientExecutePost(url, null, requestJson);

    final response = SessionOtpVerifyResponse.fromJson(responseJson);

    return response.token;
  }

  Future<String> sessionLogin(AppType type, String identifier, String login, String password) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session'],
    );

    final requestJson = SessionLoginRequest(
      type: type,
      identifier: identifier,
      login: login,
      password: password,
    ).toJson();

    final responseJson = await _httpClientExecutePost(url, null, requestJson);

    final response = SessionLoginResponse.fromJson(responseJson);

    return response.token;
  }

  Future<void> sessionLogout(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session'],
    );

    await _httpClientExecuteDelete(url, token);
  }

  Future<AccountInfo> accountInfo(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['account', 'info'],
    );

    final responseJson = await _httpClientExecuteGet(url, token);

    final response = AccountInfoResponse.fromJson(responseJson);

    return response.data;
  }

  Future<List<AccountContact>> accountContacts(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['account', 'contacts'],
    );

    final responseJson = await _httpClientExecuteGet(url, token);

    final response = AccountContactsResponse.fromJson(responseJson);

    return response.data;
  }

  Future<AppStatus> appStatus(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'status'],
    );

    final responseJson = await _httpClientExecuteGet(url, token);

    final response = AppStatusResponse.fromJson(responseJson);

    return response.data;
  }

  Future<void> appStatusUpdate(String token, AppStatus appStatus) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'status'],
    );

    final requestJson = AppStatusUpdateRequest(
      data: appStatus,
    ).toJson();

    await _httpClientExecutePatch(url, token, requestJson);
  }

  Future<void> appCreateContacts(String token, List<AppContact> appContacts) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'contacts'],
    );

    final requestJson = AppCreateContactsRequest(data: appContacts).toJson();

    await _httpClientExecutePost(url, token, requestJson);
  }

  Future<List<AppSmartContact>> appSmartContacts(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'contacts', 'smart'],
    );

    final responseJson = await _httpClientExecuteGet(url, token);

    final response = AppSmartContactsResponse.fromJson(responseJson);

    return response.data;
  }

  Future<void> appCreatePushToken(String token, PushTokenType type, String value) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'push-tokens'],
    );

    final requestJson = AppCreatePushTokenRequest(
      type: type,
      value: value,
    ).toJson();

    await _httpClientExecutePost(url, token, requestJson);
  }
}
