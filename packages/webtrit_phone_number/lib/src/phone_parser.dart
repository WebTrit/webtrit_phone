import 'constants.dart';

abstract class PhoneParser {
  static String normalize(String unformatedPhoneNumber) {
    return unformatedPhoneNumber.split('').map((char) => Constants.allNormalizationMappings[char] ?? '').join('');
  }
}
