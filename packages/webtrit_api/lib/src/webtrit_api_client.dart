import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'package:_http_client/_http_client.dart';

import 'exceptions.dart';
import 'utils/request_utils.dart';
import 'webtrit_api_request_options.dart';
import 'webtrit_api_response_options.dart';
import 'models/models.dart';

// TODO(Serdun): Use correct naming for request and response options
class WebtritApiClient {
  final Logger _logger;

  static const _apiBasePath = 'api';
  static const _apiBasePathSegmentsV1 = [_apiBasePath, 'v1'];

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
    bool isDebug = false,
  }) : this.inner(
         baseUrl,
         tenantId,
         httpClient: createHttpClient(connectionTimeout: connectionTimeout, certs: certs),
         isDebug: isDebug,
       );

  @visibleForTesting
  WebtritApiClient.inner(
    Uri baseUrl,
    String tenantId, {
    required http.Client httpClient,
    Logger? logger,
    this.isDebug = false,
  }) : _httpClient = httpClient,
       _logger = Logger('WebtritApiClient'),
       tenantUrl = buildTenantUrl(baseUrl, tenantId);

  final Uri tenantUrl;
  final http.Client _httpClient;
  final bool isDebug;

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
    Map<String, String>? queryParameters,
    RequestOptions requestOptions = const RequestOptions(),
    ResponseOptions responseOptions = const ResponseOptions(),
  }) async {
    final url = tenantUrl.replace(
      pathSegments: [...tenantUrl.pathSegments.where((segment) => segment.isNotEmpty), ...pathSegments],
      queryParameters: queryParameters,
    );

    final xRequestId = requestId ?? RequestUtil.generate();

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

        _logger.info(
          ' ${method.toUpperCase()} request($requestAttempt) to $url with requestId: $xRequestId'
          '${isDebug ? ' headers: ${jsonEncode(httpRequest.headers)}' : ''}'
          '${isDebug && requestData != null ? ', request body: $requestData' : ''}',
        );

        final httpResponse = await http.Response.fromStream(await _httpClient.send(httpRequest));

        final responseData = httpResponse.body;
        final responseDataJson = responseData.isEmpty ? {} : jsonDecode(responseData);

        _logger.info(
          '${method.toUpperCase()} response with status code: ${httpResponse.statusCode} for requestId: $xRequestId, response body: ${httpResponse.body}',
        );

        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 204 || httpResponse.statusCode == 304) {
          // Return response in the requested format depending on the response type:
          // - JSON-decoded map for API data responses
          // - Raw bytes for binary downloads (e.g., files)
          // - Full http.Response object for advanced access (headers, status, etc.)
          return switch (responseOptions.responseType) {
            ResponseType.json => responseDataJson,
            ResponseType.bytes => httpResponse.bodyBytes,
            ResponseType.raw => httpResponse,
          };
        } else {
          final error = switch (responseDataJson) {
            Map(isEmpty: true) => null,
            {'errors': {'detail': _}} => null,
            _ => ErrorResponse.fromJson(responseDataJson),
          };

          // Handle session_missing specifically
          if (httpResponse.statusCode == 401 && error?.code == 'session_missing') {
            throw SessionMissingException(
              url: tenantUrl,
              requestId: xRequestId,
              statusCode: httpResponse.statusCode,
              token: token,
              error: error,
            );
          }

          // Map 422 with code="refresh_token_invalid" to UnauthorizedException.
          // This ensures higher layers can handle expired/invalid sessions in a unified way
          // (e.g., trigger global logout or token refresh).
          if (httpResponse.statusCode == 422 && error?.code == 'refresh_token_invalid') {
            throw UnauthorizedException(
              url: tenantUrl,
              requestId: xRequestId,
              statusCode: httpResponse.statusCode,
              token: token,
              error: error,
            );
          }

          // If the server responds with 404 or 501, it may indicate that a specific private endpoint
          // is not implemented by the current adapter (e.g., tenant-specific or backend version mismatch).
          // In such case, throw a dedicated exception to handle unsupported endpoint scenarios gracefully.
          if (httpResponse.statusCode == 404 || httpResponse.statusCode == 501) {
            throw EndpointNotSupportedException(
              url: tenantUrl,
              requestId: xRequestId,
              statusCode: httpResponse.statusCode,
              recognizedNotSupportedCodes: ['404', '501'],
            );
          }

          if (error?.code == 'voicemail_not_configured') {
            throw VoicemailNotConfiguredException(
              url: tenantUrl,
              requestId: xRequestId,
              statusCode: httpResponse.statusCode,
              // recognizedNotConfiguredCodes: ,
            );
          }

          throw RequestFailure(
            url: tenantUrl,
            statusCode: httpResponse.statusCode,
            requestId: xRequestId,
            token: token,
            error: error,
          );
        }
      } catch (e) {
        if (e is! VoicemailNotConfiguredException && e is! EndpointNotSupportedException) {
          _logger.severe('${method.toUpperCase()} failed for requestId: $requestId with error: $e');
        }

        // Do not retry for valid server responses with a defined HTTP status code.
        if (e is RequestFailure || requestAttempt >= requestOptions.retries) rethrow;

        requestAttempt++;
        await Future.delayed(requestOptions.retryDelay);
      }
    }
  }

  Future<dynamic> _httpClientExecuteGet(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token, {
    Map<String, String>? queryParameters,
    RequestOptions requestOptions = const RequestOptions(),
    ResponseOptions responseOptions = const ResponseOptions(),
  }) {
    return _httpClientExecute(
      'get',
      pathSegments,
      token,
      null,
      headers: headers,
      queryParameters: queryParameters,
      requestOptions: requestOptions,
      responseOptions: responseOptions,
    );
  }

  Future<dynamic> _httpClientExecutePost(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token,
    Object? requestDataJson, {
    Map<String, String>? queryParameters,
    RequestOptions requestOptions = const RequestOptions(),
    ResponseOptions responseOptions = const ResponseOptions(),
  }) {
    return _httpClientExecute(
      'post',
      pathSegments,
      token,
      requestDataJson,
      headers: headers,
      queryParameters: queryParameters,
      requestOptions: requestOptions,
      responseOptions: responseOptions,
    );
  }

  Future<dynamic> _httpClientExecutePatch(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token,
    Object? requestDataJson, {
    RequestOptions requestOptions = const RequestOptions(),
    ResponseOptions responseOptions = const ResponseOptions(),
  }) {
    return _httpClientExecute(
      'patch',
      pathSegments,
      token,
      requestDataJson,
      requestOptions: requestOptions,
      responseOptions: responseOptions,
    );
  }

  Future<dynamic> _httpClientExecuteDelete(
    List<String> pathSegments,
    Map<String, String>? headers,
    String? token, {
    RequestOptions requestOptions = const RequestOptions(),
    ResponseOptions responseOptions = const ResponseOptions(),
  }) {
    return _httpClientExecute(
      'delete',
      pathSegments,
      token,
      null,
      requestOptions: requestOptions,
      responseOptions: responseOptions,
    );
  }

  Future<bool> healthCheck({RequestOptions options = const RequestOptions()}) async {
    try {
      await _httpClientExecuteGet([_apiBasePath, 'health-check'], null, null, requestOptions: options);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<SystemInfo> getSystemInfo({RequestOptions options = const RequestOptions()}) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'system-info'],
      null,
      null,
      requestOptions: options,
    );

    return SystemInfo.fromJson(responseJson);
  }

  Future<SessionResult> createUser(
    SessionUserCredential sessionUserCredential, {
    Map<String, dynamic>? extraPayload,
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestPayload = {...sessionUserCredential.toJson(), if (extraPayload?.isNotEmpty == true) ...extraPayload!};

    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'user'],
      null,
      null,
      requestPayload,
      requestOptions: options,
    );

    return SessionResult.fromJson(responseJson);
  }

  Future<SessionOtpProvisional> createSessionOtp(
    SessionOtpCredential sessionOtpCredential, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = sessionOtpCredential.toJson();

    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'session', 'otp-create'],
      null,
      null,
      requestJson,
      requestOptions: options,
    );

    return SessionOtpProvisional.fromJson(responseJson);
  }

  Future<SessionToken> verifySessionOtp(
    SessionOtpProvisional sessionOtpProvisional,
    String code, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = {'otp_id': sessionOtpProvisional.otpId, 'code': code};

    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'session', 'otp-verify'],
      null,
      null,
      requestJson,
      requestOptions: options,
    );
    return SessionToken.fromJson(responseJson);
  }

  Future<SessionToken> createSession(
    SessionLoginCredential sessionLoginCredential, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = sessionLoginCredential.toJson();

    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'session'],
      null,
      null,
      requestJson,
      requestOptions: options,
    );

    return SessionToken.fromJson(responseJson);
  }

  Future<SessionToken> createSessionAutoProvision(
    SessionAutoProvisionCredential sessionAutoProvisionCredential, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = sessionAutoProvisionCredential.toJson();

    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'session', 'auto-provision'],
      null,
      null,
      requestJson,
      requestOptions: options,
    );

    return SessionToken.fromJson(responseJson);
  }

  Future<void> deleteSession(String token, {RequestOptions options = const RequestOptions()}) async {
    await _httpClientExecuteDelete([..._apiBasePathSegmentsV1, 'session'], null, token, requestOptions: options);
  }

  Future<UserInfo> getUserInfo(String token, {RequestOptions options = const RequestOptions()}) async {
    try {
      final responseJson = await _httpClientExecuteGet(
        [..._apiBasePathSegmentsV1, 'user'],
        null,
        token,
        requestOptions: options,
      );
      return UserInfo.fromJson(responseJson);
    } on RequestFailure catch (e) {
      if (e.statusCode == 404) {
        throw UserNotFoundException(url: e.url, requestId: e.requestId, statusCode: e.statusCode!);
      }
      rethrow;
    }
  }

  Future<List<UserContact>> getUserContactList(String token, {RequestOptions options = const RequestOptions()}) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'contacts'],
      null,
      token,
      requestOptions: options,
    );

    return (responseJson['items'] as List<dynamic>).map((e) {
      return UserContact.fromJson(e as Map<String, dynamic>);
    }).toList();
  }

  Future<UserContact> getUserContact(
    String userId,
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'contacts', userId],
      null,
      token,
      requestOptions: options,
    );
    return UserContact.fromJson(responseJson as Map<String, dynamic>);
  }

  Future<void> deleteUserInfo(String token, {RequestOptions options = const RequestOptions()}) async {
    await _httpClientExecuteDelete([..._apiBasePathSegmentsV1, 'user'], null, token, requestOptions: options);
  }

  Future<AppStatus> getAppStatus(String token, {RequestOptions options = const RequestOptions()}) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'app', 'status'],
      null,
      token,
      requestOptions: options,
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
      [..._apiBasePathSegmentsV1, 'app', 'status'],
      null,
      token,
      requestJson,
      requestOptions: options,
    );
  }

  Future<void> createAppContact(
    String token,
    List<AppContact> appContacts, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = appContacts.map((e) => e.toJson()).toList();

    await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'app', 'contacts'],
      null,
      token,
      requestJson,
      requestOptions: options,
    );
  }

  Future<List<AppSmartContact>> getAppSmartContactList(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'app', 'contacts', 'smart'],
      null,
      token,
      requestOptions: options,
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
      [..._apiBasePathSegmentsV1, 'app', 'push-tokens'],
      null,
      token,
      requestJson,
      requestOptions: options,
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
      [..._apiBasePathSegmentsV1, 'custom', 'private', 'call-to-actions'],
      {'Accept-Language': locale},
      token,
      requestJson,
      requestOptions: options,
    );

    return DemoCallToActionsResponse.fromJson(responseJson);
  }

  Future<SelfConfigResponse> getSelfConfig(String token, {RequestOptions options = const RequestOptions()}) async {
    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'custom', 'private', 'self-config-portal-url'],
      null,
      token,
      {},
      requestOptions: options,
    );

    return SelfConfigResponse.fromJson(responseJson);
  }

  Future<ExternalPageAccessToken> getExternalPageAccessToken(
    String token, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'custom', 'private', 'external-page-access-token'],
      null,
      token,
      {},
      requestOptions: options,
    );

    return ExternalPageAccessToken.fromJson(responseJson);
  }

  Future<UserVoicemailListResponse> getUserVoicemailList(
    String token, {
    String? locale,
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'voicemails'],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestOptions: options,
    );

    return UserVoicemailListResponse.fromJson(responseJson);
  }

  Future<UserVoicemail> getUserVoicemail(
    String token,
    String messageId, {
    String? locale,
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'voicemails', messageId],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestOptions: options,
    );

    return UserVoicemail.fromJson(responseJson);
  }

  Future<void> deleteUserVoicemail(
    String token,
    String messageId, {
    String? locale,
    RequestOptions options = const RequestOptions(),
  }) async {
    await _httpClientExecuteDelete(
      [..._apiBasePathSegmentsV1, 'user', 'voicemails', messageId],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestOptions: options,
    );
  }

  Future<void> updateUserVoicemail(
    String token,
    String messageId, {
    required bool seen,
    String? locale,
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = {'seen': seen};

    await _httpClientExecutePatch(
      [..._apiBasePathSegmentsV1, 'user', 'voicemails', messageId],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestJson,
      requestOptions: options,
    );
  }

  Future<Uint8List> getUserVoicemailAttachment(
    String token,
    String messageId, {
    String? locale,
    String? fileFormat,
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'voicemails', messageId, 'attachment'],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestOptions: options,
      responseOptions: ResponseOptions(responseType: ResponseType.bytes),
    );

    return responseJson;
  }

  String getVoicemailAttachmentUrl(String voicemailId, {String fileFormat = 'mp3'}) {
    final url = tenantUrl.replace(
      pathSegments: [
        ...tenantUrl.pathSegments.where((segment) => segment.isNotEmpty),
        ..._apiBasePathSegmentsV1,
        ...['user', 'voicemails', voicemailId, 'attachment'],
      ],
      queryParameters: fileFormat.isNotEmpty ? {'file_format': fileFormat} : null,
    );
    return url.toString();
  }

  Future<SystemNotificationResponce> getSystemNotificationsHistory(
    String token, {
    DateTime? since,
    int? limit,
    String? locale,
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'notifications'],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestOptions: options,
      queryParameters: {
        if (since != null) 'created_before': since.toUtc().toIso8601String(),
        if (limit != null) 'limit': limit.toString(),
      },
    );

    return SystemNotificationResponce.fromJson(responseJson as Map<String, dynamic>);
  }

  Future<SystemNotificationResponce> getSystemNotificationsUpdates(
    String token, {
    required DateTime since,
    int? limit,
    String? locale,
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'notifications', 'updates'],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestOptions: options,
      queryParameters: {'updated_after': since.toUtc().toIso8601String(), if (limit != null) 'limit': limit.toString()},
    );
    print('Response JSON: $responseJson');

    return SystemNotificationResponce.fromJson(responseJson as Map<String, dynamic>);
  }

  Future<void> markSystemNotificationAsSeen(
    String token,
    int notificationId, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = {'seen': true};

    await _httpClientExecutePatch(
      [..._apiBasePathSegmentsV1, 'user', 'notifications', notificationId.toString()],
      {},
      token,
      requestJson,
      requestOptions: options,
    );
  }

  Future<CdrHistoryResponse> getCdrHistory(
    String token, {
    DateTime? from,
    DateTime? to,
    int? limit,
    String? locale,
    RequestOptions options = const RequestOptions(),
  }) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'history'],
      locale != null ? {'Accept-Language': locale} : null,
      token,
      requestOptions: options,
      queryParameters: {
        if (from != null) 'time_from': from.toUtc().toIso8601String(),
        if (to != null) 'time_to': to.toUtc().toIso8601String(),
        if (limit != null) 'items_per_page': limit.toString(),
      },
    );

    return CdrHistoryResponse.fromJson(responseJson as Map<String, dynamic>);
  }

  Future<CallerIdSettings> getCallerIdSettings(String token, {RequestOptions options = const RequestOptions()}) async {
    final responseJson = await _httpClientExecuteGet(
      [..._apiBasePathSegmentsV1, 'user', 'preferences', 'caller-id'],
      null,
      token,
      requestOptions: options,
    );

    return CallerIdSettings.fromJson(responseJson as Map<String, dynamic>);
  }

  Future<CallerIdSettings> updateCallerIdSettings(
    String token,
    CallerIdSettings settings, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final requestJson = settings.toJson();

    final responseJson = await _httpClientExecutePost(
      [..._apiBasePathSegmentsV1, 'user', 'preferences', 'caller-id'],
      null,
      token,
      requestJson,
      requestOptions: options,
    );
    return CallerIdSettings.fromJson(responseJson as Map<String, dynamic>);
  }

  Future<FavoritesGetResult> getFavorites(
    String token, {
    String? ifNoneMatch,
    RequestOptions options = const RequestOptions(),
  }) async {
    final response =
        await _httpClientExecuteGet(
              [..._apiBasePathSegmentsV1, 'user', 'favorites'],
              ifNoneMatch != null ? {'If-None-Match': ifNoneMatch} : null,
              token,
              requestOptions: options,
              responseOptions: ResponseOptions(responseType: ResponseType.raw),
            )
            as http.Response;

    if (response.statusCode == 304) {
      return FavoritesGetResult(notModified: true, etag: response.headers['etag'] ?? '0');
    }

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    return FavoritesGetResult(
      notModified: false,
      etag: response.headers['etag'] ?? '0',
      data: FavoritesListResponse.fromJson(responseJson),
    );
  }

  Future<FavoriteBatchSyncResult> batchSyncFavorites(
    String token,
    List<FavoriteBatchAction> actions, {
    RequestOptions options = const RequestOptions(),
  }) async {
    final response =
        await _httpClientExecutePost(
              [..._apiBasePathSegmentsV1, 'user', 'favorites', 'batch_sync'],
              null,
              token,
              {'actions': actions.map((a) => a.toJson()).toList()},
              requestOptions: options,
              responseOptions: ResponseOptions(responseType: ResponseType.raw),
            )
            as http.Response;

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    return FavoriteBatchSyncResult(
      data: FavoriteBatchSyncResponse.fromJson(responseJson),
      etag: response.headers['etag'] ?? '0',
    );
  }
}
