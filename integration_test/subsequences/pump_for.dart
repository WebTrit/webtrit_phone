import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

Future pumpFor(Duration duration, PatrolIntegrationTester $) async {
  for (var i = 0; i < duration.inMilliseconds ~/ 100; i++) {
    await Future.delayed(const Duration(milliseconds: 100));
    await $.pump();
  }
}
