import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:webtrit_api/src/models/account_contacts.dart';
import 'package:webtrit_api/src/models/app_contacts_smart.dart';

import 'package:webtrit_api/webtrit_api.dart';

class RequestFailure implements Exception {
  RequestFailure({
    required this.statusCode,
    this.error,
  });

  final int statusCode;
  final ErrorResponse? error;

  @override
  String toString() {
    final error = this.error;
    if (error != null) {
      final refining = error.refining;
      if (refining != null) {
        final s = refining.map((r) => '${r.path}: ${r.reason}').join(', ');
        return '$RequestFailure($statusCode, ${error.code}, [$s])';
      } else {
        return '$RequestFailure($statusCode, ${error.code})';
      }
    } else {
      return '$RequestFailure($statusCode)';
    }
  }
}

class WebtritApiClient {
  WebtritApiClient(this.baseUrl, {http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  static const _apiVersionPathSegments = ['api', 'v1'];

  static const _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  final Uri baseUrl;
  final http.Client _httpClient;

  Future<String> sessionOtpRequest(AppType type, String identifier, String phone) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session', 'otp-request'],
    );

    final request = SessionOtpRequestRequest(type: type, identifier: identifier, phone: phone);

    final httpResponse = await _httpClient.post(
      url,
      headers: _headers,
      body: jsonEncode(request.toJson()),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }

    final response = SessionOtpRequestResponse.fromJson(jsonDecode(httpResponse.body));

    return response.otpId;
  }

  Future<String> sessionOtpVerify(String otpId, String code) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session', 'otp-verify'],
    );

    final request = SessionOtpVerifyRequest(otpId: otpId, code: code);

    final httpResponse = await _httpClient.post(
      url,
      headers: _headers,
      body: jsonEncode(request.toJson()),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }

    final response = SessionOtpVerifyResponse.fromJson(jsonDecode(httpResponse.body));

    return response.token;
  }

  Future<String> sessionLogin(AppType type, String identifier, String login, String password) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session'],
    );

    final request = SessionLoginRequest(type: type, identifier: identifier, login: login, password: password);

    final httpResponse = await _httpClient.post(
      url,
      headers: _headers,
      body: jsonEncode(request.toJson()),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }

    final response = SessionLoginResponse.fromJson(jsonDecode(httpResponse.body));

    return response.token;
  }

  Future<void> sessionLogout(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['session'],
    );

    final httpResponse = await _httpClient.delete(
      url,
      headers: _headersWithToken(token),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }
  }

  Future<AccountInfo> accountInfo(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['account', 'info'],
    );

    final httpResponse = await _httpClient.get(
      url,
      headers: _headersWithToken(token),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }

    return AccountInfoResponse.fromJson(jsonDecode(httpResponse.body)).data;
  }

  Future<List<AccountContact>> accountContacts(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['account', 'contacts'],
    );

    final httpResponse = await _httpClient.get(
      url,
      headers: _headersWithToken(token),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }

    return AccountContactsResponse.fromJson(jsonDecode(httpResponse.body)).data;
  }

  Future<void> appCreateContacts(String token, List<AppContact> appContacts) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'contacts'],
    );

    final request = AppCreateContactsRequest(data: appContacts);

    final httpResponse = await _httpClient.post(
      url,
      headers: _headersWithToken(token),
      body: jsonEncode(request.toJson()),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }
  }

  Future<List<AppSmartContact>> appSmartContacts(String token) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'contacts', 'smart'],
    );

    final httpResponse = await _httpClient.get(
      url,
      headers: _headersWithToken(token),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }

    return AppSmartContactsResponse.fromJson(jsonDecode(httpResponse.body)).data;
  }

  Future<void> appCreatePushToken(String token, PushTokenType type, String value) async {
    final url = baseUrl.replace(
      pathSegments: baseUrl.pathSegments + _apiVersionPathSegments + ['app', 'push-tokens'],
    );

    final request = AppCreatePushTokenRequest(type: type, value: value);

    final httpResponse = await _httpClient.post(
      url,
      headers: _headersWithToken(token),
      body: jsonEncode(request.toJson()),
    );

    if (httpResponse.statusCode != 200) {
      _throwRequestFailure(httpResponse);
    }
  }

  void _throwRequestFailure(http.Response httpResponse) {
    final error = httpResponse.body.isEmpty ? null : ErrorResponse.fromJson(jsonDecode(httpResponse.body));
    throw RequestFailure(
      statusCode: httpResponse.statusCode,
      error: error,
    );
  }

  Map<String, String> _headersWithToken(String token) {
    return {
      ..._headers,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }
}
