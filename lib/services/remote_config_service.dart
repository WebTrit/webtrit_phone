import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

final _logger = Logger('RemoteConfigService');

/// Read-only snapshot of the configuration values at a specific moment.
///
/// This class is decoupled from the Firebase SDK and can be safely used
/// in any part of the application, including background isolates and tests.
class RemoteConfigSnapshot {
  final Map<String, String> _values;
  final RemoteCacheConfigService _localCache;

  RemoteConfigSnapshot(this._values, this._localCache);

  /// Returns the configuration value for the given [key] as a [String].
  ///
  /// It prioritizes the value from the remote configuration. If the remote value
  /// is not available or empty, it falls back to the local cache.
  String? getString(String key) {
    final remoteValue = _values[key];
    if (remoteValue != null && remoteValue.isNotEmpty) {
      return remoteValue;
    }
    return _localCache.getString(key);
  }

  /// Returns the configuration value for the given [key] as a [bool].
  ///
  /// It prioritizes the value from the remote configuration. If the remote value
  /// is not available, it falls back to the local cache.
  bool? getBool(String key) {
    final remoteValue = _values[key];
    if (remoteValue != null) {
      return remoteValue.toBool();
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

  /// Refreshes the configuration by fetching from the remote source.
  Future<void> refresh();
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
  CachedRemoteConfigService(this._cacheService, this._remoteConfig) {
    _onConfigUpdatedSubscription = _remoteConfig.onConfigUpdated.listen((event) async {
      _logger.info('Remote config update signal received. Updated keys: ${event.updatedKeys}');
      try {
        await _remoteConfig.activate();
        final snapshot = _createSnapshot();
        _controller.add(snapshot);
        unawaited(_updateCache(snapshot));
      } catch (e, stackTrace) {
        _logger.warning('Failed to activate remote config update', e, stackTrace);
      }
    });
  }

  final FirebaseRemoteConfig _remoteConfig;
  final RemoteCacheConfigService _cacheService;

  final _controller = StreamController<RemoteConfigSnapshot>.broadcast();
  StreamSubscription? _onConfigUpdatedSubscription;

  static Future<CachedRemoteConfigService> init(RemoteCacheConfigService cache) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 30),
        minimumFetchInterval: kDebugMode ? const Duration(seconds: 10) : const Duration(hours: 12),
      ),
    );

    await remoteConfig.fetchAndActivate().catchError(_handleFetchError);

    final service = CachedRemoteConfigService(cache, remoteConfig);
    // Initial cache synchronization
    unawaited(service._updateCache(service.snapshot));

    return service;
  }

  @override
  RemoteConfigSnapshot get snapshot => _createSnapshot();

  @override
  Stream<RemoteConfigSnapshot> get onConfigUpdated => _controller.stream;

  @override
  Future<void> refresh() async {
    try {
      final updated = await _remoteConfig.fetchAndActivate();
      if (updated) {
        final snapshot = _createSnapshot();
        _controller.add(snapshot);
        await _updateCache(snapshot);
      }
    } catch (e, stackTrace) {
      _logger.warning('Failed to refresh remote config', e, stackTrace);
    }
  }

  RemoteConfigSnapshot _createSnapshot() {
    final remoteValues = _remoteConfig.getAll();
    final Map<String, String> plainValues = {};

    for (final entry in remoteValues.entries) {
      final value = entry.value.asString();
      if (value.isNotEmpty) {
        plainValues[entry.key] = value;
      }
    }

    return RemoteConfigSnapshot(plainValues, _cacheService);
  }

  /// Synchronizes the provided [snapshot] with the local cache storage.
  Future<void> _updateCache(RemoteConfigSnapshot snapshot) async {
    try {
      final futures = snapshot._values.entries.map((entry) {
        return _cacheService.cacheString(entry.key, entry.value);
      });
      await Future.wait(futures);
      _logger.fine('Local cache synchronized successfully.');
    } catch (e, stackTrace) {
      _logger.warning('Failed to synchronize local cache', e, stackTrace);
    }
  }

  void dispose() {
    _onConfigUpdatedSubscription?.cancel();
    _controller.close();
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
  Future<void> refresh() async {}

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
    if (value is bool) return value;
    if (value is String) return value.toBool();
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
