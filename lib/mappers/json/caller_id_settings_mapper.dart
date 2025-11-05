import 'dart:convert';

import 'package:webtrit_phone/models/caller_id_settings.dart';

mixin CallerIdSettingsJsonMapper {
  static const String prefixMatcherDescriminator = 'prefix_matcher';

  Map<String, dynamic> numberMatcherToMap(NumberMatcher matcher) {
    return switch (matcher) {
      PrefixMatcher prefixMatcher => <String, dynamic>{
        'type': prefixMatcherDescriminator,
        'prefix': prefixMatcher.prefix,
        'number': prefixMatcher.number,
      },
    };
  }

  NumberMatcher numberMatcherFromMap(Map<String, dynamic> map) {
    return switch (map['type']) {
      prefixMatcherDescriminator => PrefixMatcher(map['prefix'] as String, map['number'] as String),
      _ => throw Exception('Unknown matcher type: ${map['type']}'),
    };
  }

  Map<String, dynamic> callerIdSettingsToMap(CallerIdSettings settings) {
    return <String, dynamic>{
      'defaultNumber': settings.defaultNumber,
      'matchers': settings.matchers.map((matcher) => numberMatcherToMap(matcher)).toList(),
    };
  }

  CallerIdSettings callerIdSettingsFromMap(Map<String, dynamic> map) {
    return CallerIdSettings(
      defaultNumber: map['defaultNumber'],
      matchers: (map['matchers'] as List<dynamic>)
          .map((matcherMap) => numberMatcherFromMap(matcherMap as Map<String, dynamic>))
          .toList(),
    );
  }

  String callerIdSettingsToJson(CallerIdSettings settings) => json.encode(callerIdSettingsToMap(settings));

  CallerIdSettings callerIdSettingsFromJson(String source) => callerIdSettingsFromMap(json.decode(source));
}
