import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';

abstract interface class RegisterStatusRepository {
  bool getRegisterStatus();
  Future<void> setRegisterStatus(bool value);
  Future<void> removeRegisterStatus();
}

class RegisterStatusRepositoryPrefsImpl implements RegisterStatusRepository, Disposable {
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
  Future<void> removeRegisterStatus() async {
    await _appPreferences.remove(_preferenceKey);
  }

  @override
  Future<void> dispose() async {
    // Clean on logout
    await removeRegisterStatus();
  }
}
