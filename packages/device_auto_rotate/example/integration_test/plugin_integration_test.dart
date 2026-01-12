import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:device_auto_rotate/device_auto_rotate.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('isEnabled returns a valid boolean', (tester) async {
    expect(await DeviceAutoRotate.isEnabled, isA<bool>());
  });

  testWidgets('stream emits initial value', (tester) async {
    expect(await DeviceAutoRotate.stream.first, isA<bool>());
  });
}
