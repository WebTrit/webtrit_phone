import 'package:logging/logging.dart';

import 'app.dart' as app;

void main() {
  Logger.root.level = Level.ALL;

  app.main();
}
