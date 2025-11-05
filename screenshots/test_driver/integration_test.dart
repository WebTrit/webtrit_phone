import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  await integrationDriver(
    onScreenshot: (String screenshotName, List<int> screenshotBytes,
        [args]) async {
      final screenshotFile = File('output/$screenshotName.png');
      await screenshotFile.create(recursive: true);
      await screenshotFile.writeAsBytes(screenshotBytes);
      return true;
    },
  );
}
