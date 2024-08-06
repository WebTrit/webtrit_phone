import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:_http_client/_http_client.dart';

import 'exceptions.dart';
import 'models/models.dart';

class WebtritApiClient {
  static final _requestIdRandom = Random();

  @visibleForTesting
  static Uri buildTenantUrl(Uri baseUrl, String tenantId) {
    if (tenantId.isEmpty) {
      return baseUrl;
    } else {
      final baseUrlPathSegments = List.of(baseUrl.pathSegments);
      if (baseUrlPathSegments.length >= 2 && baseUrlPathSegments[baseUrlPathSegments.length - 2] == 'tenant') {
        baseUrlPathSegments.removeRange(baseUrlPathSegments.length - 2, baseUrlPathSegments.length);
      }
      return baseUrl.replace(
        pathSegments: [
          ...baseUrlPathSegments,
          ...['tenant', tenantId],
        ],
      );
    }
  }

  WebtritApiClient(
    Uri baseUrl,
    String tenantId, {
    Duration? connectionTimeout,
    TrustedCertificates certs = TrustedCertificates.empty,
  }) : this.inner(
          baseUrl,
          tenantId,
          httpClient: createHttpClient(
            connectionTimeout: connectionTimeout,
            certs: certs,
          ),
        );

  @visibleForTesting
  WebtritApiClient.inner(
    Uri baseUrl,
    String tenantId, {
    required http.Client httpClient,
  })  : _httpClient = httpClient,
        tenantUrl = buildTenantUrl(baseUrl, tenantId);

  final Uri tenantUrl;
  final http.Client _httpClient;

  void close() {
    _httpClient.close();
  }

  Future<dynamic> _httpClientExecute(
    String method,
    List<String> pathSegments,
    String? token,
    Object? requestDataJson, {
    String? requestId,
  }) async {
    final url = tenantUrl.replace(
      pathSegments: [
        ...tenantUrl.pathSegments,
        'api',
        'v1',
        ...pathSegments,
      ],
    );
    final httpRequest = http.Request(method, url);

    final xRequestId = requestId ?? _generateRequestId();
    httpRequest.headers.addAll({
      'content-type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'x-request-id': xRequestId,
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
      final error = switch (responseDataJson) {
        Map(isEmpty: true) => null,
        {'errors': {'detail': _}} => null,
        _ => ErrorResponse.fromJson(responseDataJson),
      };
      throw RequestFailure(
        statusCode: httpResponse.statusCode,
        requestId: xRequestId,
        token: token,
        error: error,
      );
    }
  }

  String _generateRequestId([int length = 32]) {
    return String.fromCharCodes(List.generate(length, (index) => _requestIdRandom.nextInt(26) + 97));
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

  Future<SessionToken> createSessionAutoProvision(SessionAutoProvisionCredential sessionAutoProvisionCredential) async {
    final requestJson = sessionAutoProvisionCredential.toJson();

    final responseJson = await _httpClientExecutePost(['session', 'auto-provision'], null, requestJson);

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

  Future<void> deleteUserInfo(String token) async {
    await _httpClientExecuteDelete(['user'], token);
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

  Future<DemoCallToActionsResponse> getCallToActions(String token, DemoCallToActionsParam callToActionsParam) async {
    final requestJson = callToActionsParam.toJson();

    final responseJson = await _httpClientExecutePost(['custom', 'private', 'call-to-actions','/'], token, requestJson);

    return DemoCallToActionsResponse.fromJson(responseJson);
  }
}
