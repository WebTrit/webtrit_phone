import 'package:patrol/patrol.dart';
import 'package:webtrit_phone/bootstrap.dart';

import 'subsequences/pump_root_and_wait_until_visible.dart';

void main() {
  patrolTest('Should compile and run successfully', ($) async {
    final instanceRegistry = await bootstrap();
    await pumpRootAndWaitUntilVisible(instanceRegistry, $);
  });
}
