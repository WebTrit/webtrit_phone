import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/main.dart';

Future<void> pumpRootApp(InstanceRegistry instanceRegistry, WidgetTester tester) async {
  final rootApp = RootApp(instanceRegistry: instanceRegistry);
  await tester.pumpWidget(rootApp);
  await tester.pumpAndSettle();
}
