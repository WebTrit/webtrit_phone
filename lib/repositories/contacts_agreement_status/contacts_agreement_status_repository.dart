import 'package:webtrit_phone/data/app_preferences.dart';
import 'package:webtrit_phone/models/agreement_status.dart';

abstract interface class ContactsAgreementStatusRepository {
  Future<void> setContactsAgreementStatus(AgreementStatus value);

  AgreementStatus getContactsAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending});

  Future<void> clear();
}

class ContactsAgreementStatusRepositoryPrefsImpl implements ContactsAgreementStatusRepository {
  ContactsAgreementStatusRepositoryPrefsImpl(this._appPreferences);

  final AppPreferences _appPreferences;
  final _prefsKey = 'contacts-agreement-status';

  @override
  Future<void> setContactsAgreementStatus(AgreementStatus value) => _appPreferences.setString(_prefsKey, value.name);

  @override
  AgreementStatus getContactsAgreementStatus({AgreementStatus defaultValue = AgreementStatus.pending}) {
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
