import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_phone/main.dart';

Future<void> pumpRootApp(WidgetTester tester) async {
  const rootApp = RootApp();
  await tester.pumpWidget(rootApp);
  await tester.pumpAndSettle();
}
