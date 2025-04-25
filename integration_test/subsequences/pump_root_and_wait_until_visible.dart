import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';
import 'package:webtrit_phone/main.dart';

Future<void> pumpRootAndWaitUntilVisible(PatrolIntegrationTester $) async {
  await $.pumpWidgetAndSettle(const RootApp());
  await $.waitUntilVisible($(LoginModeSelectScreen));
}
