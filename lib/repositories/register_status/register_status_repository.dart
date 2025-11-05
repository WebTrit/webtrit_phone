import 'package:webtrit_phone/data/data.dart';

abstract interface class RegisterStatusRepository {
  bool getRegisterStatus();
  Future<void> setRegisterStatus(bool value);
  Future<void> clear();
}

class RegisterStatusRepositoryPrefsImpl implements RegisterStatusRepository {
  RegisterStatusRepositoryPrefsImpl(this._appPreferences);
  final AppPreferencesPure _appPreferences;
  static const _preferenceKey = 'register-status';

  @override
  bool getRegisterStatus() {
    /// Default to true because user automatically registered after login
    return _appPreferences.getBool(_preferenceKey) ?? true;
  }

  @override
  Future<void> setRegisterStatus(bool value) async {
    await _appPreferences.setBool(_preferenceKey, value);
  }

  @override
  Future<void> clear() async {
    await _appPreferences.remove(_preferenceKey);
  }
}
