import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/main.dart';
import 'package:webtrit_phone/utils/utils.dart';

Future<void> pumpRootApp(InstanceRegistry instanceRegistry, WidgetTester tester) async {
  final appDocDir = await getApplicationDocumentsPath();
  final String baseLogDirectoryPath = '$appDocDir/logs';
  final String baseLogFilePath = '$baseLogDirectoryPath/app_logs.log';

  RootApp rootApp = RootApp(instanceRegistry: instanceRegistry, baseLogFilePath: baseLogFilePath);
  await tester.pumpWidget(rootApp);
  await tester.pumpAndSettle();
}
