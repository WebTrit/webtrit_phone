import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/bootstrap.dart';

import 'subsequences/pump_root_and_wait_until_visible.dart';

main() {
  patrolTest(
    'Should compile and run succesfully',
    ($) async {
      await bootstrap();
      await pumpRootAndWaitUntilVisible($);
    },
  );
}
