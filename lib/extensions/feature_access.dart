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

  List<Permission> get excludedPermissions {
    final sourceTypes = bottomMenuFeature.getTabEnabled<ContactsBottomMenuTab>()?.contactSourceTypes;

    final hasLocalContacts = sourceTypes?.contains(ContactSourceType.local) ?? false;
    final isSmsFallbackEnabled = callFeature.callTriggerConfig.smsFallback.enabled;

    return [if (!hasLocalContacts) Permission.contacts, if (!isSmsFallbackEnabled) Permission.sms];
  }
}
