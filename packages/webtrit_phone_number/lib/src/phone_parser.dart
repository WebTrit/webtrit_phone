import 'constants.dart';

/// A utility class responsible for normalizing phone numbers by replacing
/// visually similar Unicode digits with their ASCII equivalents.
///
/// This is required because phone numbers may contain characters such as
/// mathematical bold digits (e.g., 𝟗, 𝟠, 𝟟) when copied from messaging apps,
/// web pages, or documents. These characters:
///   - look like digits,
///   - but are encoded as different Unicode code points,
///   - and cannot be matched using simple `split('')` or ASCII-only logic.
///
/// The normalization process ensures predictable and safe handling of such
/// inputs across SIP, CallKeep, and dialing logic.
abstract class PhoneParser {
  /// Normalizes a phone number by iterating over Unicode *code points*
  /// rather than UTF-16 code units.
  ///
  /// ### Iterate by *code points*
  /// Certain Unicode characters—especially mathematical or styled digits
  /// such as **𝟗 (U+1D7D7)**—are represented using *surrogate pairs* in UTF-16.
  ///
  /// - Using `string.split('')` splits by *code units*, not characters.
  /// - This breaks surrogate pairs into two unrelated values.
  /// - As a result, `'𝟗'` would never match any key in
  ///   `Constants.allNormalizationMappings`, and normalization would fail.
  ///
  /// By iterating through `string.runes`, we work with actual Unicode
  /// code points, guaranteeing:
  ///   - correct recognition of extended Unicode digits,
  ///   - accurate mapping to ASCII equivalents,
  ///   - and full preservation of characters that do not require normalization.
  ///
  /// Characters that are not present in the mapping table are returned intact.
  static String normalize(String unformattedPhoneNumber) {
    final buffer = StringBuffer();

    for (final codePoint in unformattedPhoneNumber.runes) {
      final char = String.fromCharCodes([codePoint]);
      buffer.write(Constants.allNormalizationMappings[char] ?? char);
    }

    return buffer.toString();
  }
}
