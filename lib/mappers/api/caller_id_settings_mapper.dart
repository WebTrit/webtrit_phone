import 'package:webtrit_api/webtrit_api.dart' as api;

import 'package:webtrit_phone/models/models.dart';

mixin CallerIdSettingsApiMapper {
  SyncableCallerIdSettings syncableCallerIdSettingsFromApi(api.CallerIdSettings apiSettings) {
    final matchers = [...apiSettings.prefixMatchers.map(prefixMatcherFromApi)];
    return (
      CallerIdSettings(defaultNumber: apiSettings.defaultNumber, matchers: matchers),
      SettingsSyncMetadata(version: apiSettings.version, modifiedAt: apiSettings.modifiedAt, dirty: false),
    );
  }

  api.CallerIdSettings syncableCallerIdSettingsToApi(SyncableCallerIdSettings syncableSettings) {
    final (CallerIdSettings settings, SettingsSyncMetadata metadata) = syncableSettings;
    return api.CallerIdSettings(
      defaultNumber: settings.defaultNumber,
      prefixMatchers: settings.matchers.whereType<PrefixMatcher>().map(prefixMatcherToApi).toList(),
      version: metadata.version,
      modifiedAt: metadata.modifiedAt.toUtc(),
    );
  }

  NumberMatcher prefixMatcherFromApi(api.PrefixMatcher matcher) {
    return PrefixMatcher(matcher.prefix, matcher.number);
  }

  api.PrefixMatcher prefixMatcherToApi(PrefixMatcher matcher) {
    return api.PrefixMatcher(prefix: matcher.prefix, number: matcher.number);
  }
}
