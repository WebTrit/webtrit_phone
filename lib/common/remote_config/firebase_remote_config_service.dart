import 'package:logging/logging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'remote_config_service.dart';

final _logger = Logger('FirebaseRemoteConfigService');

class FirebaseRemoteConfigService implements RemoteConfigService {
  FirebaseRemoteConfigService(this._cacheService, this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;
  final RemoteCacheConfigService _cacheService;

  static Future<FirebaseRemoteConfigService> init(RemoteCacheConfigService cache) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(hours: 24),
      ),
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
