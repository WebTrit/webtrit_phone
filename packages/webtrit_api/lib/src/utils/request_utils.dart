import 'dart:math';

class RequestUtil {
  static final _random = Random();

  static String generate([int length = 32]) {
    return String.fromCharCodes(List.generate(length, (_) => _random.nextInt(26) + 97));
  }
}
