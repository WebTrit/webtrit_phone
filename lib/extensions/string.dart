extension StringExtension on String {
  String get initialism {
    final trimmed = trim();
    if (trimmed.isEmpty) {
      return '';
    } else {
      return trimmed.split(' ').map((v) => v[0]).take(3).join();
    }
  }
}
