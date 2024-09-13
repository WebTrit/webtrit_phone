import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/utils/utils.dart';

final logger = Logger('QueueRequestWorker');

class QueueRequestWorker {
  static late QueueRequestWorker _instance;
  final RequestStorage _requestStorage = RequestStorage();

  QueueRequestWorker._() {
    _initConnectivityListener();
  }

  static Future<void> init() async {
    _instance = QueueRequestWorker._();
  }

  factory QueueRequestWorker() {
    return _instance;
  }

  void _initConnectivityListener() {
    final connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      await _handleConnectivityChange(result);
    });
  }

  Future<void> _handleConnectivityChange(List<ConnectivityResult> results) async {
    for (final result in results) {
      if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
        if ((await _requestStorage.getRequestKeys()).isNotEmpty) {
          await flushRequests();
        }
      }
    }
  }

  void storeRequest(
    HttpMethod method,
    Uri uri, {
    String? token,
    Duration? expiration,
    int? maxAttempts,
  }) {
    _requestStorage.storeRequest(method, uri, token: token, expiration: expiration, maxAttempts: maxAttempts);
  }

  Future<void> flushRequests() async {
    logger.info('Flushing requests');
    final keys = await _requestStorage.getRequestKeys();
    logger.info('Found ${keys.length} requests');

    for (final key in keys) {
      await _processRequest(key);
    }
  }

  Future<void> _processRequest(String key) async {
    final requestMap = await _requestStorage.getRequest(key);
    if (requestMap == null) return;

    final maxAttempts = requestMap[RequestStorage._maxAttemptsKey] as int;
    final attempts = requestMap[RequestStorage._attemptsKey] as int;

    if (_requestStorage.isRequestExpired(requestMap) || attempts >= maxAttempts) {
      await _requestStorage.removeRequest(key);
      return;
    }

    await _executeRequest(requestMap, key);
  }

  Future<void> _executeRequest(Map<String, dynamic> requestMap, String key) async {
    final method = HttpMethod.values.firstWhere((e) => e.toString() == requestMap[RequestStorage._methodKey]);
    final uri = Uri.parse(requestMap[RequestStorage._uriKey]);
    final token = requestMap[RequestStorage._tokenKey];

    try {
      await createApiClient().execute(method, uri, token: token);
      await _requestStorage.removeRequest(key);
    } catch (e) {
      logger.severe('Request failed: $e');
      requestMap[RequestStorage._attemptsKey] = (requestMap[RequestStorage._attemptsKey] as int) + 1;
      await _requestStorage.updateRequest(key, requestMap);
    }
  }
}

class RequestStorage {
  static const String _requestKeyPrefix = 'request_';
  static const String _methodKey = 'method';
  static const String _uriKey = 'uri';
  static const String _tokenKey = 'token';
  static const String _timestampKey = 'timestamp';
  static const String _attemptsKey = 'attempts';
  static const String _maxAttemptsKey = 'maxAttempts';
  static const String _expirationKey = 'expiration';

  Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> storeRequest(
    HttpMethod method,
    Uri uri, {
    String? token,
    Duration? expiration,
    int? maxAttempts,
    Duration defaultExpiration = const Duration(days: 7),
    int defaultMaxAttempts = 100,
  }) async {
    final prefs = await _getPreferences();
    final requestKey = '$_requestKeyPrefix${DateTime.now().millisecondsSinceEpoch}';
    final requestData = {
      _methodKey: method.toString(),
      _uriKey: uri.toString(),
      _tokenKey: token,
      _timestampKey: DateTime.now().toIso8601String(),
      _attemptsKey: 0,
      _maxAttemptsKey: maxAttempts ?? defaultMaxAttempts,
      _expirationKey: (expiration ?? defaultExpiration).inMilliseconds,
    };
    await prefs.setString(requestKey, jsonEncode(requestData));
  }

  Future<Map<String, dynamic>?> getRequest(String key) async {
    final prefs = await _getPreferences();
    final requestData = prefs.getString(key);
    if (requestData == null) return null;
    return Map<String, dynamic>.from(jsonDecode(requestData));
  }

  Future<void> removeRequest(String key) async {
    final prefs = await _getPreferences();
    await prefs.remove(key);
  }

  Future<Set<String>> getRequestKeys() async {
    final prefs = await _getPreferences();
    return prefs.getKeys().where((key) => key.startsWith(_requestKeyPrefix)).toSet();
  }

  Future<void> updateRequest(String key, Map<String, dynamic> requestData) async {
    final prefs = await _getPreferences();
    await prefs.setString(key, jsonEncode(requestData));
  }

  bool isRequestExpired(Map<String, dynamic> requestMap) {
    final timestamp = DateTime.parse(requestMap[_timestampKey]);
    final expiration = Duration(milliseconds: requestMap[_expirationKey]);
    return DateTime.now().isAfter(timestamp.add(expiration));
  }
}
