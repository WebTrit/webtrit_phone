import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

typedef FeatureResolver = bool Function(FeatureFlag);

extension FeatureAccessResolver on FeatureAccess {
  FeatureResolver _toResolver() {
    final map = <FeatureFlag, bool Function()>{FeatureFlag.voicemail: () => settingsFeature.isVoicemailsEnabled};

    return (FeatureFlag key) => map[key]?.call() ?? false;
  }

  FeatureChecker toChecker() {
    return FeatureChecker(_toResolver());
  }
}
