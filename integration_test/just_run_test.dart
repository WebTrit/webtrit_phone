import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/features/login/view/login_mode_select_screen.dart';

import 'subsequences/pump_root_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await bootstrap();
  });

  testWidgets('Should compile and run succesfully', (tester) async {
    await pumpRootApp(tester);
    expect(find.byType(LoginModeSelectScreen), findsOneWidget);
  });
}
