import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:webtrit_phone/features/contact/models/models.dart';

extension ContactDisplayExtension on Contact {
  /// Returns display-ready entries for rendering the phone list.
  ///
  /// Each entry exposes [ContactPhoneDisplayEntry.displayLabel] which may be a
  /// merged string (e.g. "main / sms") when multiple phones share the same number,
  /// and [ContactPhoneDisplayEntry.phone] - the original highest-priority phone
  /// used for all actions such as calls and favorites.
  List<ContactPhoneDisplayEntry> get displayPhoneEntries {
    // Create a copy of the list to avoid mutating the original data
    final sortedPhones = List<ContactPhone>.from(phones);

    // Sort using a comparator that combines priority weight and alphabetical order
    sortedPhones.sort((a, b) {
      final priorityA = _getPhonePriority(a.label);
      final priorityB = _getPhonePriority(b.label);

      // Primary sorting: by Priority Weight (lower number = higher importance)
      if (priorityA != priorityB) {
        return priorityA.compareTo(priorityB);
      }

      // Secondary sorting: Alphabetical (for labels with the same priority)
      // For example, if both are "home" or "work" (priority 3), sort by name
      return a.label.compareTo(b.label);
    });

    // Group phones sharing the same number into a single display entry.
    // Insertion order is preserved because [sortedPhones] is already priority-sorted,
    // so the first phone in each group carries the highest-priority label.
    // Labels from all duplicates are joined with ' / ' for display (e.g. "number / sms").
    // When saving to favorites the highest-priority label is stored
    // (e.g. "additional" for "additional / sms"). This is intentional;
    // per-label favorites can be refined later if needed.
    final grouped = <String, List<ContactPhone>>{};
    for (final phone in sortedPhones) {
      (grouped[phone.number] ??= []).add(phone);
    }

    return grouped.values.map((group) {
      final first = group.first;
      final mergedLabel = group.map((p) => p.label).join(' / ');
      final isFavorite = group.any((p) => p.favorite);
      return ContactPhoneDisplayEntry(displayLabel: mergedLabel, displayFavorite: isFavorite, phone: first);
    }).toList();
  }

  /// Convenience getter that returns display-oriented [ContactPhone] objects.
  ///
  /// Each phone carries the merged label and combined favorite flag from its group,
  /// while id and number are taken from the highest-priority phone.
  List<ContactPhone> get displayPhones => displayPhoneEntries
      .map(
        (e) => ContactPhone(id: e.phone.id, number: e.phone.number, label: e.displayLabel, favorite: e.displayFavorite),
      )
      .toList();

  /// Helper function to assign "weight" to labels.
  /// 0 - Highest priority (Top of the list)
  /// 3 - Lowest priority (Bottom of the list)
  int _getPhonePriority(String label) {
    if (label == kContactExtLabel) return 0;
    if (label == kContactMainLabel) return 1;
    if (label == kContactAdditionalLabel) return 2;

    // Any other label goes to the bottom bucket
    return 3;
  }
}
