import 'package:webtrit_phone/data/data.dart';

/// The feature configuration pinned for one authenticated session.
///
/// The shell snapshots it at mount and hands it to its provider layers, which
/// build from the snapshot - deliberately not from the reactive
/// [FeatureAccess], so a runtime configuration update cannot reshape the
/// provider graph under the live navigator (closing session blocs that open
/// screens still hold). Widgets that should follow runtime updates keep
/// reading the reactive [FeatureAccess] as before; configuration changes that
/// gate providers take effect on the next login.
class SessionFeatureAccess {
  const SessionFeatureAccess(this.value);

  final FeatureAccess value;
}
