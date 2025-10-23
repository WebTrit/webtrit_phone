import 'package:dlibphonenumber/dlibphonenumber.dart';

extension PhoneUtilExtension on String {
  bool get isValidPhone {
    final u = PhoneNumberUtil.instance;
    try {
      final parsed = u.parse(startsWith('+') ? this : '+$this', '');
      return u.isValidNumber(parsed);
    } catch (_) {
      return false;
    }
  }

  String? get e164Phone {
    final u = PhoneNumberUtil.instance;
    try {
      final parsed = u.parse(startsWith('+') ? this : '+$this', '');
      return u.format(parsed, PhoneNumberFormat.e164);
    } catch (_) {
      return null;
    }
  }

  bool comparePhoneNSN(String number) {
    final u = PhoneNumberUtil.instance;
    try {
      final match = u.isNumberMatch(this, number);
      return match == MatchType.exactMatch || match == MatchType.nsnMatch;
    } catch (_) {
      return false;
    }
  }

  /// Returns the national significant number (NSN) part if the phone number is valid full phone number
  /// ex: +001234567890 -> 1234567890, 001234567890 -> 1234567890, 123123 > null
  String? get nationalPhoneIfValid {
    final u = PhoneNumberUtil.instance;
    try {
      final parsed = u.parse(startsWith('+') ? this : '+$this', '');
      if (u.isValidNumber(parsed)) {
        // ignore: no_leading_underscores_for_local_identifiers
        final _nationalNumber = parsed.nationalNumber.toString();
        if (_nationalNumber != this) return _nationalNumber;
      }
    } on Exception catch (_) {}
    return null;
  }
}
