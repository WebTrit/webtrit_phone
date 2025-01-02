import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'package:_http_client/_http_client.dart';

import 'exceptions.dart';
import 'webtrit_api_request_options.dart';
import 'models/models.dart';

class WebtritApiClient {
  static final _requestIdRandom = Random();

  final Logger _logger;

  @visibleForTesting
  static Uri buildTenantUrl(Uri baseUrl, String tenantId) {
    if (tenantId.isEmpty) {
      return baseUrl;
    } else {
      final baseUrlPathSegments = List.of(baseUrl.pathSegments.where((segment) => segment.isNotEmpty));
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
    Logger? logger,
  })  : _httpClient = httpClient,
        _logger = Logger('WebtritApiClient'),
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
    Map<String, String>? headers,
    RequestOptions options = const RequestOptions(),
  }) async {
    final url = tenantUrl.replace(
      pathSegments: [
        ...tenantUrl.pathSegments.where((segment) => segment.isNotEmpty),
        'api',
        'v1',
        ...pathSegments,
      ],
    );

    final xRequestId = requestId ?? _generateRequestId();

    final requestHeaders = {
      'content-type': 'application/json; charset=utf-8',
      'accept': 'application/json',
      'x-request-id': xRequestId,
      if (token != null) 'authorization': 'Bearer $token',
    };

    final requestData = requestDataJson != null ? jsonEncode(requestDataJson) : null;

    int requestAttempt = 0;

    while (true) {
      try {
        // Create a new `http.Request` instance for each iteration.
        // Once sent, a request is finalized and cannot be reused.
        // A fresh instance prevents "Can't finalize a finalized Request" errors.
        final httpRequest = http.Request(method, url);

        httpRequest.headers.addAll(requestHeaders);

        if (headers != null) httpRequest.headers.addAll(headers);

        if (requestData != null) httpRequest.body = requestData;

        _logger.info(' ${method.toUpperCase()} request($requestAttempt) to $url with requestId: $xRequestId');

        final httpResponse = await http.Response.fromStream(await _httpClient.send(httpRequest));

        final responseData = httpResponse.body;
        final responseDataJson = responseData.isEmpty ? {} : jsonDecode(responseData);

        _logger.info(
            '${method.toUpperCase()} response with status code: ${httpResponse.statusCode} for requestId: $xRequestId, response body: ${httpResponse.body}');

        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 204) {
          return responseDataJson;
        } else {
          final error = switch (responseDataJson) {
            Map(isEmpty: true) => null,
            {'errors': {'detail': _}} => null,
            _ => ErrorResponse.fromJson(responseDataJson),
          };
          throw RequestFailure(
            url: tenantUrl,
            statusCode: httpResponse.statusCode,
            requestId: xRequestId,
            token: token,
            error: error,
          );
        }
      } catch (e) {
        _logger.severe('${method.toUpperCase()} failed for requestId: $requestId with error: $e');

        // Do not retry for valid server responses with a defined HTTP status code.
        if (e is RequestFailure || requestAttempt >= options.retries) rethrow;

        requestAttempt++;
        await Future.delayed(options.retryDelay);
      }
    }
  }

  String _generateRequestId([int length = 32]) {
    return String.fromCharCodes(List.generate(length, (index) => _requestIdRandom.nextInt(26) + 97));
  }

  Future<dynamic> _httpClientExecuteGet(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token, {
    RequestOptions options = const RequestOptions(),
  }) {
    return _httpClientExecute(
      'get',
      pathSegments,
      token,
      null,
      options: options,
    );
  }

  Future<dynamic> _httpClientExecutePost(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token,
    Object? requestDataJson, {
    RequestOptions options = const RequestOptions(),
  }) {
    return _httpClientExecute(
      'post',
      pathSegments,
      token,
      requestDataJson,
      headers: headers,
      options: options,
    );
  }

  Future<dynamic> _httpClientExecutePatch(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token,
    Object? requestDataJson, {
    RequestOptions options = const RequestOptions(),
  }) {
    return _httpClientExecute(
      'patch',
      pathSegments,
      token,
      requestDataJson,
      options: options,
    );
  }

  Future<dynamic> _httpClientExecuteDelete(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token, {
    RequestOptions options = const RequestOptions(),
  }) {
    return _httpClientExecute(
      'delete',
      pathSegments,
      token,
      null,
      options: options,
    );
  }

  Future<SystemInfo> getSystemInfo({
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      ['system-info'],
      null,
      null,
      options: options,
    );

    return SystemInfo.fromJson(responseJson);
  }

  Future<SessionResult> createUser(
    SessionUserCredential sessionUserCredential, {
    Map<String, dynamic>? extraPayload,
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestPayload = {
      ...sessionUserCredential.toJson(),
      if (extraPayload?.isNotEmpty == true) ...extraPayload!,
    };

    final responseJson = await _httpClientExecutePost(
      ['user'],
      null,
      null,
      requestPayload,
      options: options,
    );

    return SessionResult.fromJson(responseJson);
  }

  Future<SessionOtpProvisional> createSessionOtp(
    SessionOtpCredential sessionOtpCredential, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = sessionOtpCredential.toJson();

    final responseJson = await _httpClientExecutePost(
      ['session', 'otp-create'],
      null,
      null,
      requestJson,
      options: options,
    );

    return SessionOtpProvisional.fromJson(responseJson);
  }

  Future<SessionToken> verifySessionOtp(
    SessionOtpProvisional sessionOtpProvisional,
    String code, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = {
      'otp_id': sessionOtpProvisional.otpId,
      'code': code,
    };

    final responseJson = await _httpClientExecutePost(
      ['session', 'otp-verify'],
      null,
      null,
      requestJson,
      options: options,
    );
    return SessionToken.fromJson(responseJson);
  }

  Future<SessionToken> createSession(
    SessionLoginCredential sessionLoginCredential, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = sessionLoginCredential.toJson();

    final responseJson = await _httpClientExecutePost(
      ['session'],
      null,
      null,
      requestJson,
      options: options,
    );

    return SessionToken.fromJson(responseJson);
  }

  Future<SessionToken> createSessionAutoProvision(
    SessionAutoProvisionCredential sessionAutoProvisionCredential, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = sessionAutoProvisionCredential.toJson();

    final responseJson = await _httpClientExecutePost(
      ['session', 'auto-provision'],
      null,
      null,
      requestJson,
      options: options,
    );

    return SessionToken.fromJson(responseJson);
  }

  Future<void> deleteSession(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    await _httpClientExecuteDelete(
      ['session'],
      null,
      token,
      options: options,
    );
  }

  Future<UserInfo> getUserInfo(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      ['user'],
      null,
      token,
      options: options,
    );

    return UserInfo.fromJson(responseJson);
  }

  Future<List<UserContact>> getUserContactList(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      ['user', 'contacts'],
      null,
      token,
      options: options,
    );

    return (responseJson['items'] as List<dynamic>).map((e) {
      return UserContact.fromJson(e as Map<String, dynamic>);
    }).toList();
  }

  Future<void> deleteUserInfo(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    await _httpClientExecuteDelete(
      ['user'],
      null,
      token,
      options: options,
    );
  }

  Future<AppStatus> getAppStatus(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      ['app', 'status'],
      null,
      token,
      options: options,
    );

    return AppStatus.fromJson(responseJson);
  }

  Future<void> updateAppStatus(
    String token,
    AppStatus appStatus, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = appStatus.toJson();

    await _httpClientExecutePatch(
      ['app', 'status'],
      null,
      token,
      requestJson,
      options: options,
    );
  }

  Future<void> createAppContact(
    String token,
    List<AppContact> appContacts, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = appContacts.map((e) => e.toJson()).toList();

    await _httpClientExecutePost(
      ['app', 'contacts'],
      null,
      token,
      requestJson,
      options: options,
    );
  }

  Future<List<AppSmartContact>> getAppSmartContactList(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      ['app', 'contacts', 'smart'],
      null,
      token,
      options: options,
    );

    return (responseJson as List<dynamic>).map((e) => AppSmartContact.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> createAppPushToken(
    String token,
    AppPushToken appPushToken, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = appPushToken.toJson();

    await _httpClientExecutePost(
      ['app', 'push-tokens'],
      null,
      token,
      requestJson,
      options: options,
    );
  }

  Future<DemoCallToActionsResponse> getCallToActions(
    String token,
    String locale,
    DemoCallToActionsParam callToActionsParam, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = callToActionsParam.toJson();

    final responseJson = await _httpClientExecutePost(
      ['custom', 'private', 'call-to-actions'],
      {'Accept-Language': locale},
      token,
      requestJson,
      options: options,
    );

    return DemoCallToActionsResponse.fromJson(responseJson);
  }

  @Deprecated('replaced by getCustomPages')
  Future<SelfConfigResponse> getSelfConfig(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecutePost(
      ['custom', 'private', 'self-config-portal-url'],
      null,
      token,
      {},
      options: options,
    );

    return SelfConfigResponse.fromJson(responseJson);
  }

  Future<CustomPagesResponse> getCustomPages(
    String token,
    String locale, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecutePost(
      ['custom', 'private', 'custom-pages'],
      {'Accept-Language': locale},
      token,
      {},
      options: options,
    );

    return CustomPagesResponse.fromJson(responseJson);
  }
}
