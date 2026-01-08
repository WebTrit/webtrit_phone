import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/models/models.dart';

extension ContactDisplayExtension on Contact {
  List<ContactPhone> get displayPhones {
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

    return sortedPhones;
  }

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
