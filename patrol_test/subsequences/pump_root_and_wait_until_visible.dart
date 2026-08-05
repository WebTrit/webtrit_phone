import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/main.dart';

Future<void> pumpRootAndWaitUntilVisible(InstanceRegistry instanceRegistry, PatrolIntegrationTester $) async {
  await $.pumpWidgetAndSettle(RootApp.standalone(instanceRegistry));
  await $.waitUntilVisible($(AppShell));
}
