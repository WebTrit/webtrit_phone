extension StringExtension on String {
  String get capitalize {
    if (isEmpty) {
      return this;
    } else {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
  }

  String get initialism {
    final trimmed = trim();
    if (trimmed.isEmpty) {
      return '';
    } else {
      return trimmed.split(' ').map((v) => v[0]).take(3).join();
    }
  }
}
