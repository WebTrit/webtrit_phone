import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/contact_source_type.dart';

abstract interface class ActiveContactSourceTypeRepository {
  ContactSourceType getActiveContactSourceType({ContactSourceType defaultValue});

  Future<void> setActiveContactSourceType(ContactSourceType value);

  Future<void> clear();
}

class ActiveContactSourceTypeRepositoryPrefsImpl implements ActiveContactSourceTypeRepository {
  ActiveContactSourceTypeRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'active-contact-source-type';

  @override
  ContactSourceType getActiveContactSourceType({ContactSourceType defaultValue = ContactSourceType.external}) {
    final activeContactSourceTypeString = _appPreferences.getString(_prefsKey);
    if (activeContactSourceTypeString != null) {
      try {
        return ContactSourceType.values.byName(activeContactSourceTypeString);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  @override
  Future<void> setActiveContactSourceType(ContactSourceType value) => _appPreferences.setString(_prefsKey, value.name);

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
