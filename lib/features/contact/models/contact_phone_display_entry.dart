import 'package:webtrit_phone/models/models.dart';

/// Pairs display-only overrides with the canonical [ContactPhone].
///
/// [displayLabel] is a merged label (e.g. "main / sms") shown in the UI when
/// multiple phones share the same number. [displayFavorite] is true when any
/// phone in the merged group is marked as favorite.
/// [canonical] is the original highest-priority phone used for all actions
/// (calls, favorites, SMS, etc.).
class ContactPhoneDisplayEntry {
  const ContactPhoneDisplayEntry({required this.displayLabel, required this.displayFavorite, required this.phone});

  /// Merged label for UI rendering; may contain multiple role labels joined by " / ".
  final String displayLabel;

  /// True if any phone in the merged group is marked as favorite.
  final bool displayFavorite;

  /// The original highest-priority phone; used for all actions (calls, favorites, SMS, etc.).
  final ContactPhone phone;
}
