import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/utils/utils.dart';

final logger = Logger('SessionCleanupWorker');

class SessionCleanupWorker {
  static late SessionCleanupWorker _instance;

  static Future<void> init() async {
    final requestStorage = RequestStorage();
    _instance = SessionCleanupWorker._(requestStorage);
  }

  factory SessionCleanupWorker() {
    return _instance;
  }

  SessionCleanupWorker._(this._requestStorage) {
    _initConnectivityListener();
  }

  final RequestStorage _requestStorage;

  void _initConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) async {
      for (final result in results) {
        if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
          if ((await _requestStorage.getRequestKeys()).isNotEmpty) {
            await retryFailedSessions();
          }
        }
      }
    });
  }

  void saveFailedSession(Uri uri, {String? token, Duration? expiration, int? maxAttempts}) {
    _requestStorage.storeFailedSession(uri, token: token, expiration: expiration, maxAttempts: maxAttempts);
  }

  Future<void> retryFailedSessions() async {
    logger.info('Retrying failed sessions');
    final keys = await _requestStorage.getRequestKeys();
    logger.info('Found ${keys.length} failed sessions');

    for (final key in keys) {
      await _processFailedSession(key);
    }
  }

  Future<void> _processFailedSession(String key) async {
    final sessionData = await _requestStorage.getSessionData(key);
    if (sessionData == null) return;

    final maxAttempts = sessionData[RequestStorage.maxAttemptsKey] as int;
    final attempts = sessionData[RequestStorage.attemptsKey] as int;

    if (_requestStorage.isSessionExpired(sessionData) || attempts >= maxAttempts) {
      await _requestStorage.removeFailedSession(key);
    } else {
      await _retrySession(sessionData, key);
    }
  }

  Future<void> _retrySession(Map<String, dynamic> sessionData, String key) async {
    final uri = sessionData[RequestStorage.uriKey];
    final token = sessionData[RequestStorage.tokenKey];

    try {
      await defaultCreateWebtritApiClient(uri.toString(), '').deleteSession(token);
      await _requestStorage.removeFailedSession(key);
    } catch (e) {
      logger.severe('Session retry failed: $e');
      sessionData[RequestStorage.attemptsKey] = (sessionData[RequestStorage.attemptsKey] as int) + 1;
      await _requestStorage.updateFailedSession(key, sessionData);
    }
  }
}

class RequestStorage {
  static const String requestKeyPrefix = 'session_';
  static const String uriKey = 'uri';
  static const String tokenKey = 'token';
  static const String timestampKey = 'timestamp';
  static const String attemptsKey = 'attempts';
  static const String maxAttemptsKey = 'maxAttempts';
  static const String expirationKey = 'expiration';

  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  Future<void> storeFailedSession(
    Uri url, {
    String? token,
    Duration? expiration,
    int? maxAttempts,
    Duration defaultExpiration = const Duration(days: 7),
    int defaultMaxAttempts = 100,
  }) async {
    final prefs = await _prefs;
    final requestKey = '$requestKeyPrefix${DateTime.now().millisecondsSinceEpoch}';
    final sessionData = {
      uriKey: url.toString(),
      tokenKey: token,
      timestampKey: DateTime.now().toIso8601String(),
      attemptsKey: 0,
      maxAttemptsKey: maxAttempts ?? defaultMaxAttempts,
      expirationKey: (expiration ?? defaultExpiration).inMilliseconds,
    };
    await prefs.setString(requestKey, jsonEncode(sessionData));
  }

  Future<Map<String, dynamic>?> getSessionData(String key) async {
    final prefs = await _prefs;
    final sessionData = prefs.getString(key);
    return sessionData != null ? Map<String, dynamic>.from(jsonDecode(sessionData)) : null;
  }

  Future<void> removeFailedSession(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  Future<Set<String>> getRequestKeys() async {
    final prefs = await _prefs;
    return prefs.getKeys().where((key) => key.startsWith(requestKeyPrefix)).toSet();
  }

  Future<void> updateFailedSession(String key, Map<String, dynamic> sessionData) async {
    final prefs = await _prefs;
    await prefs.setString(key, jsonEncode(sessionData));
  }

  bool isSessionExpired(Map<String, dynamic> sessionData) {
    final timestamp = DateTime.parse(sessionData[timestampKey]);
    final expiration = Duration(milliseconds: sessionData[expirationKey]);
    return DateTime.now().isAfter(timestamp.add(expiration));
  }
}
