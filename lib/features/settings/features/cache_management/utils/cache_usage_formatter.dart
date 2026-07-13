/// Formats a byte count into a short human-readable size.
String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';

  const units = ['KB', 'MB', 'GB'];
  var value = bytes.toDouble();
  var unit = -1;
  do {
    value /= 1024;
    unit++;
  } while (value >= 1024 && unit < units.length - 1);

  return '${value.toStringAsFixed(1)} ${units[unit]}';
}
