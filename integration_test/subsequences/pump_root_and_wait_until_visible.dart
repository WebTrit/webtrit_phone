import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/main.dart';
import 'package:webtrit_phone/utils/utils.dart';

Future<void> pumpRootAndWaitUntilVisible(InstanceRegistry instanceRegistry, PatrolIntegrationTester $) async {
  final appDocDir = await getApplicationDocumentsPath();
  final String baseLogDirectoryPath = '$appDocDir/logs';
  final String baseLogFilePath = '$baseLogDirectoryPath/app_logs.log';

  await $.pumpWidgetAndSettle(RootApp(instanceRegistry: instanceRegistry, baseLogFilePath: baseLogFilePath));
  await $.waitUntilVisible($(AppShell));
}
