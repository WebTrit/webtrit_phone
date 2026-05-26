import 'package:webtrit_phone/models/models.dart';

extension CallerIdSettingsX on CallerIdSettings {
  /// Resolves the SIP `from` number for an outgoing call to [destination].
  ///
  /// Returns the number of the highest-priority matcher whose pattern matches
  /// [destination]; falls back to [CallerIdSettings.defaultNumber]; returns
  /// `null` when no matcher applies and no default is configured (caller
  /// should then use the main line).
  ///
  /// Side-effect-free and synchronous so it can run inside a bloc handler.
  String? resolveFromNumber(String destination) {
    final matched = matchers.where((m) => m.match(destination)).toList();
    if (matched.isNotEmpty) {
      // Longest match wins (e.g. +126812345678 matches +1268 over +1).
      matched.sort((a, b) => b.matchIndex.compareTo(a.matchIndex));
      return matched.first.number;
    }
    return defaultNumber;
  }
}
