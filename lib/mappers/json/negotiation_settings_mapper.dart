import 'dart:convert';

import 'package:webtrit_phone/models/models.dart';

const _kIncludeInactiveVideoInOfferAnswerKey = 'includeInactiveVideoInOfferAnswer';

mixin NegotiationSettingsJsonMapper {
  NegotiationSettings negotiationSettingsFromJson(String json) {
    return negotiationSettingsFromMap(jsonDecode(json));
  }

  String negotiationSettingsToJson(NegotiationSettings settings) {
    return jsonEncode(negotiationSettingsToMap(settings));
  }

  NegotiationSettings negotiationSettingsFromMap(Map<String, dynamic> map) {
    return NegotiationSettings(
      includeInactiveVideoInOfferAnswer: map[_kIncludeInactiveVideoInOfferAnswerKey] ?? false,
    );
  }

  Map<String, dynamic> negotiationSettingsToMap(NegotiationSettings settings) {
    return {
      _kIncludeInactiveVideoInOfferAnswerKey: settings.includeInactiveVideoInOfferAnswer,
    };
  }
}
