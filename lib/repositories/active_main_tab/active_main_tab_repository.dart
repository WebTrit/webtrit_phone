import 'package:webtrit_phone/data/app_preferences.dart';

/// Remembers which bottom-menu tab the user left open, as the tab's
/// `BottomMenuTab.routePath`.
///
/// The path - not the tab's kind - is what survives a restart: an install can
/// configure several embedded sections, and remembering only the kind would
/// make every one of them restore as the first.
abstract interface class ActiveMainTabRepository {
  /// The saved tab path, or null when nothing has been saved yet.
  String? getActiveTabPath();

  Future<void> setActiveTabPath(String value);

  Future<void> clear();
}

class ActiveMainTabRepositoryPrefsImpl implements ActiveMainTabRepository {
  ActiveMainTabRepositoryPrefsImpl(this._appPreferences);
  final AppPreferences _appPreferences;

  // The key predates the switch from flavor names to tab paths; keeping it
  // lets a value saved by an older build still pick the right fixed tab.
  final _prefsKey = 'active-main-flavor';

  @override
  String? getActiveTabPath() => _appPreferences.getString(_prefsKey);

  @override
  Future<void> setActiveTabPath(String value) => _appPreferences.setString(_prefsKey, value);

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
