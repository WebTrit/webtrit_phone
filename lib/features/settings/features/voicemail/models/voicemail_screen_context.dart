import 'package:intl/intl.dart';

/// Provides shared configuration for the voicemail screen,
/// avoiding the need to pass values through constructors.
///
/// Bundles common dependencies like media cache path, date formatter,
/// and media request headers to simplify access and avoid repetitive context reads.
///
/// - [mediaCacheBasePath]: Local path for caching voicemail audio files.
/// - [dateFormat]: Formatter for displaying timestamps.
/// - [mediaHeaders]: Headers for authenticated media requests.
///
class VoicemailScreenContext {
  VoicemailScreenContext({required this.mediaCacheBasePath, required this.dateFormat, required this.mediaHeaders});

  final String mediaCacheBasePath;
  final DateFormat dateFormat;
  final Map<String, String> mediaHeaders;
}
