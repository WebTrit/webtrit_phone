import 'dart:async';

import 'package:webtrit_phone/data/data.dart';

import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/models/models.dart';

abstract interface class QueuedTerminationRequestsRepository {
  Map<String, QueuedTerminationRequest> get getAll;

  void put(QueuedTerminationRequest request);

  void remove(QueuedTerminationRequest request);

  Future<void> clear();
}

class QueuedTerminationRequestsRepositoryPrefsImpl
    with QueuedTerminationRequestJsonMapperMixin
    implements QueuedTerminationRequestsRepository {
  QueuedTerminationRequestsRepositoryPrefsImpl(this._appPreferences);

  static const _prefsKey = 'queued-termination-requests';

  final AppPreferences _appPreferences;

  Map<String, QueuedTerminationRequest>? _cache;

  @override
  Map<String, QueuedTerminationRequest> get getAll {
    return Map.unmodifiable(_getCachedRequests());
  }

  @override
  void put(QueuedTerminationRequest request) {
    final cache = _getCachedRequests();
    cache[request.key] = request;
    _persist(cache);
  }

  @override
  void remove(QueuedTerminationRequest request) {
    final cache = _getCachedRequests();
    cache.remove(request.key);
    _persist(cache);
  }

  @override
  Future<void> clear() async {
    _cache = {};
    await _appPreferences.remove(_prefsKey);
  }

  Map<String, QueuedTerminationRequest> _getCachedRequests() {
    final cached = _cache;
    if (cached != null) return cached;

    final raw = _appPreferences.getString(_prefsKey);
    if (raw == null) {
      _cache = {};
      return _cache!;
    }

    _cache = queuedTerminationRequestsFromJson(raw);
    return _cache!;
  }

  void _persist(Map<String, QueuedTerminationRequest> requests) {
    unawaited(_appPreferences.setString(_prefsKey, queuedTerminationRequestsToJson(requests)));
  }
}
