import 'package:webtrit_phone/data/data.dart';

extension FeatureAccessResolver on FeatureAccess {
  FeatureResolver _toResolver() {
    final map = <AppFeature, bool Function()>{
      AppFeature.voicemail: () => settingsFeature.isVoicemailsEnabled,
    };

    return (AppFeature key) => map[key]?.call() ?? false;
  }

  FeatureChecker toChecker() {
    return FeatureChecker(_toResolver());
  }
}
