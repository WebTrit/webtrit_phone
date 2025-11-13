import 'package:webtrit_phone/data/app_preferences_pure.dart';
import 'package:webtrit_phone/mappers/json/negotiation_settings_mapper.dart';
import 'package:webtrit_phone/models/negotiation_settings.dart';
import 'package:webtrit_phone/models/peer_connection_settings.dart';

abstract interface class PeerConnectionSettingsRepository {
  PeerConnectionSettings getPeerConnectionSettings({PeerConnectionSettings? defaultValue});

  Future<void> setPearConnectionSettings(PeerConnectionSettings settings);

  Future<void> clear();
}

class PeerConnectionSettingsRepositoryPrefsImpl
    with NegotiationSettingsJsonMapper
    implements PeerConnectionSettingsRepository {
  PeerConnectionSettingsRepositoryPrefsImpl(this._appPreferences);

  final AppPreferencesPure _appPreferences;
  final _prefsKey = 'negotiation-settings';

  @override
  PeerConnectionSettings getPeerConnectionSettings({PeerConnectionSettings? defaultValue}) {
    final defaultPeerConnectionSettings = defaultValue ?? PeerConnectionSettings.blank();
    final localNegotiationSettings = _getNegotiationSettings();

    return defaultPeerConnectionSettings.copyWith(
      negotiationSettings: defaultPeerConnectionSettings.negotiationSettings.copyWith(
        includeInactiveVideoInOfferAnswer: localNegotiationSettings?.includeInactiveVideoInOfferAnswer,
      ),
    );
  }

  NegotiationSettings? _getNegotiationSettings() {
    final negotiationSettingsString = _appPreferences.getString(_prefsKey);
    if (negotiationSettingsString != null) {
      return negotiationSettingsFromJson(negotiationSettingsString);
    } else {
      return null;
    }
  }

  @override
  Future<void> setPearConnectionSettings(PeerConnectionSettings settings) async {
    await _setNegotiationSettings(settings.negotiationSettings);
  }

  Future<void> _setNegotiationSettings(NegotiationSettings settings) {
    return _appPreferences.setString(_prefsKey, negotiationSettingsToJson(settings));
  }

  @override
  Future<void> clear() => _appPreferences.remove(_prefsKey);
}
