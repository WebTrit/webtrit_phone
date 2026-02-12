import 'package:logging/logging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _logger = Logger('FirebaseRemoteConfigService');

abstract class RemoteConfigService {
  String? getString(String key);

  bool? getBool(String key);
}

abstract class RemoteCacheConfigService extends RemoteConfigService {
  Future<void> cacheString(String key, String value);

  Future<void> cacheBool(String key, bool value);
}

class FirebaseRemoteConfigService implements RemoteConfigService {
  FirebaseRemoteConfigService(this._cacheService, this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;
  final RemoteCacheConfigService _cacheService;

  static Future<FirebaseRemoteConfigService> init(RemoteCacheConfigService cache) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(fetchTimeout: const Duration(seconds: 30), minimumFetchInterval: const Duration(hours: 24)),
    );

    await remoteConfig.fetchAndActivate().catchError((error) {
      _logger.severe('Error fetching remote config: $error');
      return false;
    });

    return FirebaseRemoteConfigService(cache, remoteConfig);
  }

  @override
  String? getString(String key) {
    final value = _remoteConfig.getString(key);
    _cacheService.cacheString(key, value);
    return value;
  }

  @override
  bool? getBool(String key) {
    final value = _remoteConfig.getBool(key);
    _cacheService.cacheBool(key, value);
    return value;
  }
}

class DefaultRemoteCacheConfigService implements RemoteCacheConfigService {
  final SharedPreferences _sharedPreferences;

  DefaultRemoteCacheConfigService(this._sharedPreferences);

  static Future<RemoteCacheConfigService> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return DefaultRemoteCacheConfigService(sharedPreferences);
  }

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  @override
  Future<void> cacheString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> cacheBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }
}
