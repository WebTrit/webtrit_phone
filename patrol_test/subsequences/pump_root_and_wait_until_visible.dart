import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/app_dependencies.dart';
import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/main.dart';

Future<void> pumpRootAndWaitUntilVisible(AppDependencies dependencies, PatrolIntegrationTester $) async {
  await $.pumpWidgetAndSettle(RootApp(dependencies: dependencies));
  await $.waitUntilVisible($(AppShell));
}
