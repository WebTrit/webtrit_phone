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
  static generateTenantApiVersionPathSegments(String id) {
    return id.isEmpty ? defaultApiVersionPathSegments : ['tenant', id, ...defaultApiVersionPathSegments];
  }

  WebtritApiClient(
    Uri baseUrl, {
    Duration? connectionTimeout,
    List<String>? customSegments,
  }) : this.inner(baseUrl,
            httpClient: platform.createHttpClient(
              connectionTimeout: connectionTimeout,
            ),
            customSegments: customSegments);

  @visibleForTesting
  WebtritApiClient.inner(
    this.baseUrl, {
    required http.Client httpClient,
    required List<String>? customSegments,
  })  : _httpClient = httpClient,
        _apiVersionPathSegments = customSegments ?? defaultApiVersionPathSegments;

  static const defaultApiVersionPathSegments = ['api', 'v1'];
  List<String> _apiVersionPathSegments;

  final Uri baseUrl;
  final http.Client _httpClient;

  void close() {
    _httpClient.close();
  }

  Future<dynamic> _httpClientExecute(
    String method,
    List<String> pathSegments,
    String? token,
    Object? requestDataJson,
  ) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + pathSegments,
    );
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

  Future<dynamic> _httpClientExecuteGet(List<String> pathSegments, String? token) {
    return _httpClientExecute('get', pathSegments, token, null);
  }

  Future<dynamic> _httpClientExecutePost(List<String> pathSegments, String? token, Object? requestDataJson) {
    return _httpClientExecute('post', pathSegments, token, requestDataJson);
  }

  Future<dynamic> _httpClientExecutePatch(List<String> pathSegments, String? token, Object? requestDataJson) {
    return _httpClientExecute('patch', pathSegments, token, requestDataJson);
  }

  Future<dynamic> _httpClientExecuteDelete(List<String> pathSegments, String? token) {
    return _httpClientExecute('delete', pathSegments, token, null);
  }

  Future<Info> info() async {
    final responseJson = await _httpClientExecuteGet(['info'], null);

    return Info.fromJson(responseJson);
  }

  Future<BaseSessionResponse> createUser(UserSignupCredentials sessionLoginCreateUser) async {
    final requestJson = sessionLoginCreateUser.toJson();

    final responseJson = await _httpClientExecutePost(['user'], null, requestJson);

    return BaseSessionResponse.fromJson(responseJson);
  }

  Future<SessionOtpResponse> sessionOtpRequest(SessionOtpCredential sessionOtpCredential) async {
    final requestJson = sessionOtpCredential.toJson();

    final responseJson = await _httpClientExecutePost(['session', 'otp-request'], null, requestJson);

    return SessionOtpResponse.fromJson(responseJson);
  }

  Future<SessionAuthorizedResponse> sessionOtpVerify(String otpId, String code) async {
    final requestJson = {
      'otp_id': otpId,
      'code': code,
    };

    final responseJson = await _httpClientExecutePost(['session', 'otp-verify'], null, requestJson);
    return SessionAuthorizedResponse.fromJson(responseJson);
  }

  Future<String> sessionLogin(SessionLoginCredential sessionLoginCredential) async {
    final requestJson = sessionLoginCredential.toJson();

    final responseJson = await _httpClientExecutePost(['session'], null, requestJson);

    return responseJson['token'];
  }

  Future<void> sessionLogout(String token) async {
    await _httpClientExecuteDelete(['session'], token);
  }

  Future<AccountInfo> accountInfo(String token) async {
    final responseJson = await _httpClientExecuteGet(['account', 'info'], token);

    return AccountInfo.fromJson(responseJson['data']);
  }

  Future<List<AccountContact>> accountContacts(String token) async {
    final responseJson = await _httpClientExecuteGet(['account', 'contacts'], token);

    return (responseJson['data'] as List<dynamic>)
        .map((e) => AccountContact.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AppStatus> appStatus(String token) async {
    final responseJson = await _httpClientExecuteGet(['app', 'status'], token);

    return AppStatus.fromJson(responseJson);
  }

  Future<void> appStatusUpdate(String token, AppStatus appStatus) async {
    final requestJson = appStatus.toJson();

    await _httpClientExecutePatch(['app', 'status'], token, requestJson);
  }

  Future<void> appCreateContacts(String token, List<AppContact> appContacts) async {
    final requestJson = appContacts.map((e) => e.toJson()).toList();

    await _httpClientExecutePost(['app', 'contacts'], token, requestJson);
  }

  Future<List<AppSmartContact>> appSmartContacts(String token) async {
    final responseJson = await _httpClientExecuteGet(['app', 'contacts', 'smart'], token);

    return (responseJson as List<dynamic>).map((e) => AppSmartContact.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> appCreatePushToken(String token, AppPushToken appPushToken) async {
    final requestJson = appPushToken.toJson();

    await _httpClientExecutePost(['app', 'push-tokens'], token, requestJson);
  }
}
