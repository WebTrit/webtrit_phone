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
}
