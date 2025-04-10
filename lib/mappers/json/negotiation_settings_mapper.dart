import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

const _kCalleeVideoOfferPolicyKey = 'calleeVideoOfferPolicy';

mixin NegotiationSettingsJsonMapper {
  NegotiationSettings negotiationSettingsFromJson(String json) {
    return negotiationSettingsFromMap(jsonDecode(json));
  }

  String negotiationSettingsToJson(NegotiationSettings settings) {
    return jsonEncode(negotiationSettingsToMap(settings));
  }

  NegotiationSettings negotiationSettingsFromMap(Map<String, dynamic> map) {
    return NegotiationSettings(
      calleeVideoOfferPolicy: map[_kCalleeVideoOfferPolicyKey] != null
          ? CalleeVideoOfferPolicy.values.byName(map[_kCalleeVideoOfferPolicyKey])
          : null,
    );
  }

  Map<String, dynamic> negotiationSettingsToMap(NegotiationSettings settings) {
    return {
      _kCalleeVideoOfferPolicyKey: settings.calleeVideoOfferPolicy?.name,
    };
  }
}
