import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/main.dart';

Future<void> pumpRootAndWaitUntilVisible(PatrolIntegrationTester $) async {
  await $.pumpWidgetAndSettle(const RootApp());
  await $.waitUntilVisible($(AppShell));
}
