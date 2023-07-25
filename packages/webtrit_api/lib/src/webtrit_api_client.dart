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
    Uri baseUrl,
    String tenantId, {
    Duration? connectionTimeout,
  }) : this.inner(
          baseUrl,
          tenantId,
          httpClient: platform.createHttpClient(
            connectionTimeout: connectionTimeout,
          ),
        );

  @visibleForTesting
  WebtritApiClient.inner(
    this.baseUrl,
    this.tenantId, {
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  final Uri baseUrl;
  final String tenantId;
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
      pathSegments: [
        ...baseUrl.pathSegments,
        if (tenantId.isNotEmpty) ...['tenant', tenantId],
        'api',
        'v1',
        ...pathSegments,
      ],
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

  Future<SystemInfo> getSystemInfo() async {
    final responseJson = await _httpClientExecuteGet(['system-info'], null);

    return SystemInfo.fromJson(responseJson);
  }

  Future<SessionResult> createUser(SessionUserCredential sessionUserCredential) async {
    final requestJson = sessionUserCredential.toJson();

    final responseJson = await _httpClientExecutePost(['user'], null, requestJson);

    return SessionResult.fromJson(responseJson);
  }

  Future<SessionOtpProvisional> createSessionOtp(SessionOtpCredential sessionOtpCredential) async {
    final requestJson = sessionOtpCredential.toJson();

    final responseJson = await _httpClientExecutePost(['session', 'otp-create'], null, requestJson);

    return SessionOtpProvisional.fromJson(responseJson);
  }

  Future<SessionToken> verifySessionOtp(SessionOtpProvisional sessionOtpProvisional, String code) async {
    final requestJson = {
      'otp_id': sessionOtpProvisional.otpId,
      'code': code,
    };

    final responseJson = await _httpClientExecutePost(['session', 'otp-verify'], null, requestJson);
    return SessionToken.fromJson(responseJson);
  }

  Future<SessionToken> createSession(SessionLoginCredential sessionLoginCredential) async {
    final requestJson = sessionLoginCredential.toJson();

    final responseJson = await _httpClientExecutePost(['session'], null, requestJson);

    return SessionToken.fromJson(responseJson);
  }

  Future<void> deleteSession(String token) async {
    await _httpClientExecuteDelete(['session'], token);
  }

  Future<UserInfo> getUserInfo(String token) async {
    final responseJson = await _httpClientExecuteGet(['user'], token);

    return UserInfo.fromJson(responseJson);
  }

  Future<List<UserContact>> getUserContactList(String token) async {
    final responseJson = await _httpClientExecuteGet(['user', 'contacts'], token);

    return (responseJson['items'] as List<dynamic>)
        .map((e) => UserContact.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AppStatus> getAppStatus(String token) async {
    final responseJson = await _httpClientExecuteGet(['app', 'status'], token);

    return AppStatus.fromJson(responseJson);
  }

  Future<void> updateAppStatus(String token, AppStatus appStatus) async {
    final requestJson = appStatus.toJson();

    await _httpClientExecutePatch(['app', 'status'], token, requestJson);
  }

  Future<void> createAppContact(String token, List<AppContact> appContacts) async {
    final requestJson = appContacts.map((e) => e.toJson()).toList();

    await _httpClientExecutePost(['app', 'contacts'], token, requestJson);
  }

  Future<List<AppSmartContact>> getAppSmartContactList(String token) async {
    final responseJson = await _httpClientExecuteGet(['app', 'contacts', 'smart'], token);

    return (responseJson as List<dynamic>).map((e) => AppSmartContact.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> createAppPushToken(String token, AppPushToken appPushToken) async {
    final requestJson = appPushToken.toJson();

    await _httpClientExecutePost(['app', 'push-tokens'], token, requestJson);
  }
}
