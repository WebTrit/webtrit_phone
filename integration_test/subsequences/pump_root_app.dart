import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/app_dependencies.dart';
import 'package:webtrit_phone/main.dart';

Future<void> pumpRootApp(AppDependencies dependencies, WidgetTester tester) async {
  await tester.pumpWidget(RootApp(dependencies: dependencies));
  await tester.pumpAndSettle();
}
