import 'package:webtrit_phone/data/data.dart';

class MockAppPreferences implements AppPreferences {
  final Map<String, dynamic> _storage;

  MockAppPreferences({Map<String, dynamic>? initialData}) : _storage = initialData ?? {};

  @override
  String? getString(String key) => _storage[key] as String?;

  @override
  Future<void> setString(String key, String value) async {
    _storage[key] = value;
  }

  @override
  bool? getBool(String key) => _storage[key] as bool?;

  @override
  Future<void> setBool(String key, bool value) async {
    _storage[key] = value;
  }

  @override
  List<String>? getStringList(String key) {
    final value = _storage[key];
    if (value is List) {
      return List<String>.from(value);
    }
    return null;
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    _storage[key] = List<String>.from(value);
  }

  @override
  Future<void> remove(String key) async {
    _storage.remove(key);
  }
}
