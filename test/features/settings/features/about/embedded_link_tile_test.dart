import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/features/about/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../../../helpers/helpers.dart';

EmbeddedData _resource(String uri) =>
    EmbeddedData(id: uri, uri: Uri.parse(uri), reconnectStrategy: ReconnectStrategy.softReload);

void main() {
  Widget wrap(EmbeddedData resource, ValueChanged<EmbeddedData> onOpen) => MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: EmbeddedLinkTile(resource: resource, onOpen: onOpen),
    ),
  );

  TextStyle styleOf(WidgetTester tester, String address) => tester.widget<Text>(find.text(address)).style!;

  int copyActionId(WidgetTester tester) {
    final l10n = AppLocalizations.of(tester.element(find.byType(EmbeddedLinkTile)))!;
    return CustomSemanticsAction.getIdentifier(CustomSemanticsAction(label: l10n.copyToClipboard_popupMenuItem));
  }

  group('a resource the app can open', () {
    const address = 'https://webtrit.com/legal/privacy-policy-for-webtrit-app/';

    testWidgets('opens on tap', (tester) async {
      final opened = <EmbeddedData>[];
      final resource = _resource(address);

      await tester.pumpWidget(wrap(resource, opened.add));
      await tester.tap(find.text(address));
      await tester.pump();

      expect(opened, [resource]);
    });

    testWidgets('opens through the semantics tap action, the way a screen reader activates it', (tester) async {
      final handle = tester.ensureSemantics();
      final opened = <EmbeddedData>[];
      final resource = _resource(address);

      await tester.pumpWidget(wrap(resource, opened.add));
      await tapViaSemantics(tester, find.text(address));

      expect(opened, [resource]);
      handle.dispose();
    });

    testWidgets('reads as a link: underlined and painted in the scheme accent', (tester) async {
      await tester.pumpWidget(wrap(_resource(address), (_) {}));

      final style = styleOf(tester, address);
      final colorScheme = Theme.of(tester.element(find.text(address))).colorScheme;

      expect(style.decoration, TextDecoration.underline);
      expect(style.color, colorScheme.primary);
    });

    testWidgets('keeps the copy action on the very node that carries the address', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(wrap(_resource(address), (_) {}));

      final node = tester.getSemantics(find.text(address));

      expect(node.label, address);
      expect(node.getSemanticsData().customSemanticsActionIds, contains(copyActionId(tester)));
      handle.dispose();
    });
  });

  group('a resource the app cannot open', () {
    // No loader claims this scheme, and the screen that opens a resource
    // resolves its loader while building - so offering to open it would replace
    // "nothing happens" with a crash.
    const address = 'mailto:support@webtrit.com';

    testWidgets('does not open on tap', (tester) async {
      final opened = <EmbeddedData>[];

      await tester.pumpWidget(wrap(_resource(address), opened.add));
      await tester.tap(find.text(address));
      await tester.pump();

      expect(opened, isEmpty);
    });

    testWidgets('is not dressed as a link', (tester) async {
      await tester.pumpWidget(wrap(_resource(address), (_) {}));

      final style = styleOf(tester, address);
      final colorScheme = Theme.of(tester.element(find.text(address))).colorScheme;

      expect(style.decoration, isNot(TextDecoration.underline));
      expect(style.color, isNot(colorScheme.primary));
    });

    testWidgets('still shows its address and can still be copied', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(wrap(_resource(address), (_) {}));

      final node = tester.getSemantics(find.text(address));

      expect(find.text(address), findsOneWidget);
      expect(node.getSemanticsData().customSemanticsActionIds, contains(copyActionId(tester)));
      handle.dispose();
    });
  });

  testWidgets('a resource bundled with the app opens as well', (tester) async {
    // The scheme is written the way every bundled resource in the themes is
    // written; the single-colon spelling reaches the bundle with the scheme
    // still glued to the path and finds nothing.
    const address = 'asset://assets/themes/app.config.json';
    final opened = <EmbeddedData>[];
    final resource = _resource(address);

    await tester.pumpWidget(wrap(resource, opened.add));
    await tester.tap(find.text(address));
    await tester.pump();

    expect(opened, [resource]);
  });

  // A resource can name a scheme the app knows and still be unopenable, because
  // a loader may reject the rest of the address too. The row must go by whether
  // the resource can actually be loaded, not by the scheme alone.
  group('a resource that carries its content inside the address', () {
    // The row must go by whether the content can actually be read, not by the
    // scheme: both spellings below name a scheme the app knows, and only one of
    // them survives being read as an address.
    final readable = _resource('memory:SGVsbG8gd29ybGQ=');

    // What follows '//' is lowercased while the address is parsed, so the
    // content is already ruined by the time anything can act on it.
    final ruined = _resource('memory://SGVsbG8gd29ybGQ=');

    // The row shows the address as the URI renders it, which is not always what
    // the configuration spelled.
    String shown(EmbeddedData resource) => resource.uri.toString();

    testWidgets('opens when its content survived the address', (tester) async {
      final opened = <EmbeddedData>[];

      await tester.pumpWidget(wrap(readable, opened.add));
      await tester.tap(find.text(shown(readable)));
      await tester.pump();

      expect(opened, [readable]);
    });

    testWidgets('does not open when its content was ruined by the address', (tester) async {
      final opened = <EmbeddedData>[];

      await tester.pumpWidget(wrap(ruined, opened.add));
      await tester.tap(find.text(shown(ruined)));
      await tester.pump();

      expect(opened, isEmpty);
    });

    testWidgets('is dressed as a link only in the case that opens', (tester) async {
      await tester.pumpWidget(wrap(readable, (_) {}));
      expect(styleOf(tester, shown(readable)).decoration, TextDecoration.underline);

      await tester.pumpWidget(wrap(ruined, (_) {}));
      expect(styleOf(tester, shown(ruined)).decoration, isNot(TextDecoration.underline));
    });
  });
}
