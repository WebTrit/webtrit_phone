import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/app_preferences.dart';

/// Remembers which optional special permissions the user has already been walked
/// through, so a permission they chose to skip is not explained again on every
/// pass through the permissions flow.
abstract interface class SpecialPermissionsRepository {
  Set<CallkeepSpecialPermissions> getAcknowledged();

  Future<void> acknowledge(CallkeepSpecialPermissions permission);

  Future<void> clear();
}

class SpecialPermissionsRepositoryPrefsImpl implements SpecialPermissionsRepository {
  SpecialPermissionsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'special-permissions-acknowledged';

  @override
  Set<CallkeepSpecialPermissions> getAcknowledged() {
    final names = _appPreferences.getStringList(_prefsKey) ?? const [];
    final byName = CallkeepSpecialPermissions.values.asNameMap();
    // An unknown name means the entry was written by a build that knew a permission
    // this one does not; dropping it is harmless - the flow simply explains again.
    return names.map((name) => byName[name]).nonNulls.toSet();
  }

  @override
  Future<void> acknowledge(CallkeepSpecialPermissions permission) {
    final acknowledged = getAcknowledged()..add(permission);
    return _appPreferences.setStringList(_prefsKey, acknowledged.map((p) => p.name).toList());
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
