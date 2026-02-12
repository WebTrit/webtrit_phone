import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _logger = Logger('FirebaseRemoteConfigService');

/// Base interface for remote configuration.
abstract class RemoteConfigService {
  String? getString(String key);

  bool? getBool(String key);
}

/// Interface for caching remote configuration values locally.
abstract class RemoteCacheConfigService extends RemoteConfigService {
  Future<void> cacheString(String key, String value);

  Future<void> cacheBool(String key, bool value);
}

/// Implementation of [RemoteConfigService] using Firebase Remote Config.
class FirebaseRemoteConfigService implements RemoteConfigService {
  FirebaseRemoteConfigService(this._cacheService, this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;
  final RemoteCacheConfigService _cacheService;

  static Future<FirebaseRemoteConfigService> init(RemoteCacheConfigService cache) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(fetchTimeout: const Duration(seconds: 30), minimumFetchInterval: const Duration(hours: 24)),
    );

    await remoteConfig.fetchAndActivate().catchError(_handleFetchError);

    return FirebaseRemoteConfigService(cache, remoteConfig);
  }

  @override
  String? getString(String key) {
    final value = _remoteConfig.getString(key);

    if (value.isNotEmpty) {
      _cacheService.cacheString(key, value);
      return value;
    }

    return _cacheService.getString(key);
  }

  @override
  bool? getBool(String key) {
    final value = _remoteConfig.getBool(key);

    _cacheService.cacheBool(key, value);

    return value;
  }

  static bool _handleFetchError(Object error) {
    _logger.severe('Error fetching remote config: $error');
    return false;
  }
}

/// Implementation of [RemoteCacheConfigService] using SharedPreferences.
class DefaultRemoteCacheConfigService implements RemoteCacheConfigService {
  DefaultRemoteCacheConfigService(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static Future<RemoteCacheConfigService> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return DefaultRemoteCacheConfigService(sharedPreferences);
  }

  @override
  String? getString(String key) => _sharedPreferences.getString(key);

  @override
  bool? getBool(String key) => _sharedPreferences.getBool(key);

  @override
  Future<void> cacheString(String key, String value) async {
    if (_sharedPreferences.getString(key) == value) return;
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> cacheBool(String key, bool value) async {
    if (_sharedPreferences.getBool(key) == value) return;
    await _sharedPreferences.setBool(key, value);
  }
}
