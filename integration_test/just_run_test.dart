import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/main.dart';

main() {
  setUpAll(() async {
    await bootstrap();
  });

  testWidgets('Should compile and run succesfully', (tester) async {
    var rootApp = const RootApp();
    await tester.pumpWidget(rootApp);

    await tester.pumpAndSettle();

    expect(find.byWidget(rootApp), findsOneWidget);
  });
}
