import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/incoming_call_type.dart';

abstract interface class IncomingCallTypeRepository {
  IncomingCallType getIncomingCallType({IncomingCallType defaultValue});

  Future<void> setIncomingCallType(IncomingCallType value);

  Future<void> clear();
}

class IncomingCallTypeRepositoryPrefsImpl implements IncomingCallTypeRepository {
  IncomingCallTypeRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'call-incoming-type';

  @override
  Future<void> setIncomingCallType(IncomingCallType value) => _appPreferences.setString(_prefsKey, value.name);

  @override
  IncomingCallType getIncomingCallType({IncomingCallType defaultValue = IncomingCallType.pushNotification}) {
    final incomingCallType = _appPreferences.getString(_prefsKey);
    if (incomingCallType != null) {
      try {
        return IncomingCallType.values.byName(incomingCallType);
      } catch (_) {
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
