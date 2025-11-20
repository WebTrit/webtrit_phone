import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'subsequences/pump_root_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late InstanceRegistry instanceRegistry;

  setUpAll(() async {
    instanceRegistry = await bootstrap();
  });

  testWidgets('Should compile and run successfully', (tester) async {
    await pumpRootApp(instanceRegistry, tester);
    expect(find.byType(LoginModeSelectScreen), findsOneWidget);
  });
}
