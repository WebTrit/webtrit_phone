import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/models/main_flavor.dart';

abstract interface class ActiveMainFlavorRepository {
  MainFlavor getActiveMainFlavor({MainFlavor defaultValue = MainFlavor.contacts});

  Future<void> setActiveMainFlavor(MainFlavor value);

  Future<void> clear();
}

class ActiveMainFlavorRepositoryPrefsImpl implements ActiveMainFlavorRepository {
  ActiveMainFlavorRepositoryPrefsImpl(this._appPreferences);
  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'active-main-flavor';

  @override
  MainFlavor getActiveMainFlavor({MainFlavor defaultValue = MainFlavor.contacts}) {
    final activeMainFlavorString = _appPreferences.getString(_prefsKey);
    if (activeMainFlavorString != null) {
      try {
        return MainFlavor.values.byName(activeMainFlavorString);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  @override
  Future<void> setActiveMainFlavor(MainFlavor value) => _appPreferences.setString(_prefsKey, value.name);

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
