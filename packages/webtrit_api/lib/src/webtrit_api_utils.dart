import 'dart:math';

class ApiUtils {
  static final _requestIdRandom = Random();

  static String generateRequestId([int length = 32]) {
    return String.fromCharCodes(List.generate(length, (index) => _requestIdRandom.nextInt(26) + 97));
  }
}
