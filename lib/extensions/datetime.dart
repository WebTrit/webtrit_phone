import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  /// Returns time in HH:mm format (e.g. 14:30)
  String get toHHmm => DateFormat('HH:mm').format(toLocal());

  /// Returns date in d MMM format (e.g. 20 Aug)
  String get toDayOfMonth => DateFormat('d MMM').format(toLocal());

  /// Returns time in HH:mm(14:30) format if the date is today, otherwise returns date in d MMM(20 Aug) format
  String get timeOrDate {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    if (midnight.isBefore(toLocal())) {
      return toHHmm;
    } else {
      return toDayOfMonth;
    }
  }
}
