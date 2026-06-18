import 'package:pub_semver/pub_semver.dart';

/// Parses [raw] into a semver [Version], tolerating null, non-String, empty or
/// malformed input by returning null. pub_semver has no built-in tryParse, so
/// this is the shared safe-parse used wherever a version comes from an
/// untrusted source (backend payload, persisted cache).
Version? tryParseVersion(Object? raw) {
  if (raw is! String || raw.isEmpty) return null;
  try {
    return Version.parse(raw);
  } on FormatException {
    return null;
  }
}
