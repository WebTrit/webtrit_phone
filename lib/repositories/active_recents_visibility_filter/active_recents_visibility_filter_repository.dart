import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/models/recents_visibility_filter.dart';

abstract interface class ActiveRecentsVisibilityFilterRepository {
  RecentsVisibilityFilter getActiveRecentsVisibilityFilter({RecentsVisibilityFilter defaultValue});

  Future<void> setActiveRecentsVisibilityFilter(RecentsVisibilityFilter value);

  Future<void> clear();
}

class ActiveRecentsVisibilityFilterRepositoryPrefsImpl implements ActiveRecentsVisibilityFilterRepository {
  ActiveRecentsVisibilityFilterRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'active-recents-visibility-filter';

  @override
  RecentsVisibilityFilter getActiveRecentsVisibilityFilter({
    RecentsVisibilityFilter defaultValue = RecentsVisibilityFilter.all,
  }) {
    final activeRecentsVisibilityFilterString = _appPreferences.getString(_prefsKey);
    if (activeRecentsVisibilityFilterString != null) {
      try {
        return RecentsVisibilityFilter.values.byName(activeRecentsVisibilityFilterString);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  @override
  Future<void> setActiveRecentsVisibilityFilter(RecentsVisibilityFilter value) =>
      _appPreferences.setString(_prefsKey, value.name);

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
