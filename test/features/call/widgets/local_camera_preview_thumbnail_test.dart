import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

import '../../../helpers/helpers.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: child),
    );
  }

  group('LocalCameraPreviewThumbnail', () {
    testWidgets('the self-view is a named button that switches the camera', (tester) async {
      final semantics = tester.ensureSemantics();
      var switches = 0;
      await tester.pumpWidget(
        wrap(
          LocalCameraPreviewThumbnail(
            orientation: Orientation.portrait,
            frontCamera: true,
            localStream: null,
            onSwitchCameraPressed: () => switches++,
          ),
        ),
      );

      final preview = find.bySemanticsIdentifier(callFrontCameraPreviewId);
      expectTapTargetSemantics(
        tester,
        preview,
        label: 'Switch camera',
        identifier: callFrontCameraPreviewId,
        isButton: true,
      );

      await tapViaSemantics(tester, preview);
      expect(switches, 1);
      semantics.dispose();
    });

    testWidgets('while the camera state is still unknown it stays silent', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        wrap(
          const LocalCameraPreviewThumbnail(
            orientation: Orientation.portrait,
            frontCamera: null,
            localStream: null,
            onSwitchCameraPressed: null,
          ),
        ),
      );

      // Switching is not possible yet, and a button that answers nothing is
      // worse than no button at all.
      expect(find.bySemanticsIdentifier(callFrontCameraPreviewId), findsNothing);
      semantics.dispose();
    });
  });
}
