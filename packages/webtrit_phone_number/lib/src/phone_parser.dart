import 'constants.dart';

abstract class PhoneParser {
  static String normalize(String unformattedPhoneNumber) {
    return unformattedPhoneNumber.split('').map((char) => Constants.allNormalizationMappings[char] ?? '').join('');
  }
}
