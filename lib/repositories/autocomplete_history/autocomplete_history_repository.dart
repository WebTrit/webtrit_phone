import 'package:webtrit_phone/data/app_preferences.dart';

abstract interface class AutocompleteHistoryRepository {
  List<String> getHistory(String key);
  Future<void> addToHistory(String key, String value, {int maxItems = 8});
}

class AutocompleteHistoryRepositoryPrefsImpl implements AutocompleteHistoryRepository {
  AutocompleteHistoryRepositoryPrefsImpl(this._appPreferences);
  final AppPreferences _appPreferences;
  final _prefsKeyPrefix = 'autocomplete_history_';

  @override
  List<String> getHistory(String key) {
    final valueKey = _prefsKeyPrefix + key;
    return _appPreferences.getStringList(valueKey) ?? [];
  }

  @override
  Future<void> addToHistory(String key, String value, {int maxItems = 8}) async {
    if (value.isEmpty) return;

    final currentHistory = getHistory(key);

    // Remove case-insensitive duplicates, and re add instead of skipping
    // to add last used value to the top
    if (currentHistory.any((item) => item.toLowerCase() == value.toLowerCase())) {
      currentHistory.removeWhere((item) => item.toLowerCase() == value.toLowerCase());
    }

    final List<String> history = [value, ...currentHistory].take(maxItems).toList();

    final valueKey = _prefsKeyPrefix + key;
    await _appPreferences.setStringList(valueKey, history);
  }
}
