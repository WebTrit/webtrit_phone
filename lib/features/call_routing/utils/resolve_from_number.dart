import 'package:webtrit_phone/models/models.dart';

/// Resolves the SIP `from` number for an outgoing call to [destination] based
/// on the caller-ID [settings].
///
/// Returns the number of the highest-priority matcher whose pattern matches
/// [destination]; falls back to [CallerIdSettings.defaultNumber]; returns
/// `null` when no matcher applies and no default is configured (the caller
/// will use the main line).
///
/// The resolution is intentionally side-effect-free and synchronous so it can
/// run inside a bloc handler without awaiting any repository.
String? resolveFromNumber(String destination, CallerIdSettings settings) {
  final matched = settings.matchers.where((m) => m.match(destination)).toList();
  if (matched.isNotEmpty) {
    // Longest match wins (e.g. +126812345678 matches +1268 over +1).
    matched.sort((a, b) => b.matchIndex.compareTo(a.matchIndex));
    return matched.first.number;
  }
  return settings.defaultNumber;
}
