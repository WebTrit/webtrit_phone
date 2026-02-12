import 'package:webtrit_phone/services/services.dart';

class MockCacheConfigService implements RemoteCacheConfigService {
  @override
  Future<void> cacheBool(String key, bool value) {
    return Future.value();
  }

  @override
  Future<void> cacheString(String key, String value) {
    return Future.value();
  }

  @override
  bool? getBool(String key) {
    return null;
  }

  @override
  String? getString(String key) {
    return null;
  }

  @override
  Stream<void> get onConfigUpdated => const Stream.empty();
}
