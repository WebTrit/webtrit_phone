import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:webtrit_phone/models/keypad_key.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';

Future<void> enterKeypadNumber(PatrolIntegrationTester $, String number) async {
  for (var i = 0; i < number.length; i++) {
    final key = KeypadKey.numbers.firstWhere((element) => element.text == number[i]);
    await $(KeypadKeyButton).at(KeypadKey.numbers.indexOf(key)).tap();
  }
  await $.pumpAndTrySettle();
}
