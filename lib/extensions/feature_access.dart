import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

typedef FeatureResolver = bool Function(FeatureFlag);

extension FeatureAccessResolver on FeatureAccess {
  FeatureChecker get checker => FeatureChecker(this);

  List<Permission> get excludedPermissions {
    final sourceTypes = bottomMenuConfig.getTabEnabled<ContactsBottomMenuTab>()?.contactSourceTypes;

    final hasLocalContacts = sourceTypes?.contains(ContactSourceType.local) ?? false;
    final isSmsFallbackEnabled = callConfig.triggerConfig.smsFallback.enabled;

    return [if (!hasLocalContacts) Permission.contacts, if (!isSmsFallbackEnabled) Permission.sms];
  }
}
