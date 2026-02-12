import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _logger = Logger('FirebaseRemoteConfigService');

/// Read-only interface representing the state of configuration at a specific moment.
class RemoteConfigSnapshot {
  final Map<String, RemoteConfigValue> _remoteValues;
  final RemoteCacheConfigService _localCache;

  RemoteConfigSnapshot(this._remoteValues, this._localCache);

  /// Returns the configuration value for the given [key] as a [String].
  ///
  /// It prioritizes the value from the remote configuration. If the remote value
  /// is not available or empty, it falls back to the local cache.
  String? getString(String key) {
    if (_remoteValues.containsKey(key)) {
      final value = _remoteValues[key]!.asString();
      if (value.isNotEmpty) return value;
    }
    return _localCache.getString(key);
  }

  /// Returns the configuration value for the given [key] as a [bool].
  ///
  /// It prioritizes the value from the remote configuration. If the remote value
  /// is not available, it falls back to the local cache.
  bool? getBool(String key) {
    if (_remoteValues.containsKey(key)) {
      return _remoteValues[key]!.asBool();
    }
    return _localCache.getBool(key);
  }
}

/// Base interface for remote configuration service.
abstract class RemoteConfigService {
  /// Returns the current snapshot of the configuration.
  RemoteConfigSnapshot get snapshot;

  /// Emits an event with a new snapshot when the configuration is updated and activated.
  Stream<RemoteConfigSnapshot> get onConfigUpdated;
}

/// Interface for caching remote configuration values locally.
abstract class RemoteCacheConfigService {
  String? getString(String key);

  bool? getBool(String key);

  Future<void> cacheString(String key, String value);

  Future<void> cacheBool(String key, bool value);
}

/// Implementation of [RemoteConfigService] using Firebase Remote Config.
class CachedRemoteConfigService implements RemoteConfigService {
  CachedRemoteConfigService(this._cacheService, this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;
  final RemoteCacheConfigService _cacheService;

  static Future<CachedRemoteConfigService> init(RemoteCacheConfigService cache) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );

    await remoteConfig.fetchAndActivate().catchError(_handleFetchError);

    return CachedRemoteConfigService(cache, remoteConfig);
  }

  @override
  RemoteConfigSnapshot get snapshot => _createSnapshot();

  @override
  Stream<RemoteConfigSnapshot> get onConfigUpdated {
    return _remoteConfig.onConfigUpdated.asyncMap((newSnapshot) async {
      _logger.fine('Remote config updated: $newSnapshot');

      try {
        await _remoteConfig.activate();
        return _createSnapshot();
      } catch (e, stackTrace) {
        _logger.warning('Failed to activate remote config update', e, stackTrace);
        // Return current snapshot in case of error to keep the stream alive
        return snapshot;
      }
    });
  }

  RemoteConfigSnapshot _createSnapshot() {
    final remoteValues = _remoteConfig.getAll();

    // Eagerly update local cache with fresh remote values
    for (final entry in remoteValues.entries) {
      final value = entry.value.asString();
      if (value.isNotEmpty) {
        _cacheService.cacheString(entry.key, value);
      }
    }

    return RemoteConfigSnapshot(remoteValues, _cacheService);
  }

  static bool _handleFetchError(Object error) {
    _logger.severe('Error fetching remote config: $error');
    return false;
  }
}

/// Implementation of [RemoteCacheConfigService] using SharedPreferences.
///
/// It implements [RemoteConfigService] as well, allowing it to be used
/// as a standalone configuration source (e.g. in background isolates)
/// where Firebase might not be available or needed.
class DefaultRemoteCacheConfigService implements RemoteCacheConfigService, RemoteConfigService {
  DefaultRemoteCacheConfigService(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static Future<DefaultRemoteCacheConfigService> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    return DefaultRemoteCacheConfigService(sharedPreferences);
  }

  @override
  RemoteConfigSnapshot get snapshot => RemoteConfigSnapshot(const {}, this);

  @override
  Stream<RemoteConfigSnapshot> get onConfigUpdated => const Stream.empty();

  @override
  String? getString(String key) {
    // Avoids TypeError if the key was previously stored as a bool/int.
    try {
      return _sharedPreferences.getString(key);
    } catch (_) {
      return null;
    }
  }

  @override
  bool? getBool(String key) {
    final value = _sharedPreferences.get(key);

    // Handle true booleans
    if (value is bool) return value;

    // Handle "true"/"false" strings (since CachedRemoteConfigService stores everything as strings)
    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    return null;
  }

  @override
  Future<void> cacheString(String key, String value) async {
    // Directly write the value without reading first to prevent TypeErrors
    // if the key previously held a different type (e.g., bool).
    await _sharedPreferences.setString(key, value);
  }

  @override
  Future<void> cacheBool(String key, bool value) async {
    // Directly write the value without reading first to prevent TypeErrors.
    await _sharedPreferences.setBool(key, value);
  }
}
