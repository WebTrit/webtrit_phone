/// Formats a byte count into a short human-readable size.
String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';

  const units = ['KB', 'MB', 'GB'];
  var value = bytes.toDouble();
  var unit = -1;
  do {
    value /= 1024;
    unit++;
    // Sizes just below a boundary would round to a nonsensical '1024.0 KB';
    // roll them over to the next unit instead.
  } while (unit < units.length - 1 && double.parse(value.toStringAsFixed(1)) >= 1024);

  return '${value.toStringAsFixed(1)} ${units[unit]}';
}
