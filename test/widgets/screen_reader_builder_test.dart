import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

/// Renders the answer the builder handed down, so the assertions can read it
/// off the tree instead of out of a callback.
class _Probe extends StatelessWidget {
  const _Probe(this.screenReaderOn);

  final bool screenReaderOn;

  @override
  Widget build(BuildContext context) => const SizedBox();
}

void main() {
  Future<void> pumpWithReader(WidgetTester tester, {required bool platformSays}) {
    return tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(accessibleNavigation: platformSays),
        child: ScreenReaderBuilder(builder: (context, screenReaderOn) => _Probe(screenReaderOn)),
      ),
    );
  }

  bool reported(WidgetTester tester) => tester.widget<_Probe>(find.byType(_Probe)).screenReaderOn;

  group('ScreenReaderBuilder', () {
    testWidgets('passes on what the platform says while the app is in front', (tester) async {
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

      await pumpWithReader(tester, platformSays: false);
      expect(reported(tester), isFalse);

      await pumpWithReader(tester, platformSays: true);
      expect(reported(tester), isTrue);
    });

    testWidgets('takes the first reading even before the app is told it is in front', (tester) async {
      // A call answered from a push comes up before that word arrives; waiting
      // for it would report no screen reader for as long as the screen lives.
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);

      await pumpWithReader(tester, platformSays: true);
      expect(reported(tester), isTrue);
    });

    testWidgets('ignores the reading taken behind another window', (tester) async {
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await pumpWithReader(tester, platformSays: true);

      // A dialog of its own is enough for the platform to report the screen
      // reader as off - which says nothing about the reader.
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await pumpWithReader(tester, platformSays: false);
      expect(reported(tester), isTrue);
    });

    testWidgets('takes a fresh reading on the way back', (tester) async {
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await pumpWithReader(tester, platformSays: true);

      // Switched off elsewhere, so the screen is not the window in front.
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await pumpWithReader(tester, platformSays: false);
      expect(reported(tester), isTrue);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(reported(tester), isFalse);
    });
  });
}
