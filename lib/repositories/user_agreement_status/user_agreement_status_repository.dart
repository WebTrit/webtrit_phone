import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/models/agreement_status.dart';

abstract interface class UserAgreementStatusRepository {
  Future<void> setUserAgreementStatus(AgreementStatus value);

  AgreementStatus getUserAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending});

  Future<void> clear();
}

class UserAgreementStatusRepositoryPrefsImpl implements UserAgreementStatusRepository {
  UserAgreementStatusRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'user-agreement-status';

  @override
  Future<void> setUserAgreementStatus(AgreementStatus value) => _appPreferences.setString(_prefsKey, value.name);

  @override
  AgreementStatus getUserAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending}) {
    final agreementStatusString = _appPreferences.getString(_prefsKey);
    if (agreementStatusString != null) {
      try {
        return AgreementStatus.values.byName(agreementStatusString);
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
