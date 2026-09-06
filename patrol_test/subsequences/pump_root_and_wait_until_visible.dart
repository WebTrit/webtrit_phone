import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/app_dependencies.dart';
import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/main.dart';

import '../components/allow_test_font_fetching.dart';

Future<void> pumpRootAndWaitUntilVisible(AppDependencies dependencies, PatrolIntegrationTester $) async {
  // Every patrol test enters through here; give them all the bench font
  // shim uniformly - it swallows the offline fetch failure - now that
  // bootstrap has locked runtime fetching off.
  allowTestFontFetching();
  await $.pumpWidgetAndSettle(RootApp(dependencies: dependencies));
  await $.waitUntilVisible($(AppShell));
}
