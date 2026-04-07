// Master test runner -- used for web testing:
//   flutter drive \
//     --driver=test_driver/integration_test.dart \
//     --target=integration_test/all_tests.dart \
//     -d chrome
//
// On Android/iOS run individual files directly:
//   flutter test integration_test/<file>_test.dart --device-id <device-id>

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'signaling_service_events_test.dart' as events;
import 'signaling_service_execute_test.dart' as execute;
import 'signaling_service_lifecycle_test.dart' as lifecycle;
import 'signaling_service_stress_test.dart' as stress;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('lifecycle', lifecycle.main);
  group('events', events.main);
  group('execute', execute.main);
  group('stress', stress.main);
}
