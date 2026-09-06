import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/app/app_dependencies.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'subsequences/pump_root_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AppDependencies dependencies;

  setUpAll(() async {
    dependencies = await bootstrap();
  });

  testWidgets('Should compile and run successfully', (tester) async {
    await pumpRootApp(dependencies, tester);
    expect(find.byType(LoginModeSelectScreen), findsOneWidget);
  });
}
