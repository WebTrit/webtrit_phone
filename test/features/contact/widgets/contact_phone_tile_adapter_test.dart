import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/contact/widgets/contact_phone_tile_adapter.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.dart';

void main() {
  Widget buildTestable(ContactPhoneTileAdapter adapter) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(body: adapter),
    );
  }

  ContactPhoneTileAdapter buildAdapter({
    String number = '1001',
    String displayLabel = 'ext',
    bool favorite = false,
    List<String> callNumbers = const [],
    bool isSmsEnabled = false,
    bool isMessageEnabled = false,
    bool enableTileFavorite = false,
    bool enableTileVoiceCall = false,
    bool enableTileVideoCall = false,
    bool enableTileTransfer = false,
    bool enableTileCallLog = false,
    bool hasActiveCall = false,
    bool isBlingTransferInitiated = false,
    void Function(bool)? onFavoriteChanged,
    VoidCallback? onAudioPressed,
    VoidCallback? onVideoPressed,
    VoidCallback? onTransferPressed,
    VoidCallback? onSmsPressed,
    VoidCallback? onCallLogPressed,
    VoidCallback? onMessagePressed,
    void Function(String)? onCallFromPressed,
  }) {
    return ContactPhoneTileAdapter(
      number: number,
      displayLabel: displayLabel,
      favorite: favorite,
      callNumbers: callNumbers,
      isSmsEnabled: isSmsEnabled,
      isMessageEnabled: isMessageEnabled,
      enableTileFavorite: enableTileFavorite,
      enableTileVoiceCall: enableTileVoiceCall,
      enableTileVideoCall: enableTileVideoCall,
      enableTileTransfer: enableTileTransfer,
      enableTileCallLog: enableTileCallLog,
      hasActiveCall: hasActiveCall,
      isBlingTransferInitiated: isBlingTransferInitiated,
      onFavoriteChanged: onFavoriteChanged ?? (_) {},
      onAudioPressed: onAudioPressed ?? () {},
      onVideoPressed: onVideoPressed ?? () {},
      onTransferPressed: onTransferPressed ?? () {},
      onSmsPressed: onSmsPressed ?? () {},
      onCallLogPressed: onCallLogPressed ?? () {},
      onMessagePressed: onMessagePressed ?? () {},
      onCallFromPressed: onCallFromPressed ?? (_) {},
    );
  }

  group('ContactPhoneTileAdapter', () {
    testWidgets('renders number and displayLabel', (tester) async {
      await tester.pumpWidget(buildTestable(buildAdapter(number: '2002', displayLabel: 'main / sms')));

      expect(find.text('2002'), findsOneWidget);
      expect(find.text('main / sms'), findsOneWidget);
    });

    testWidgets('uses number as SizedBox key', (tester) async {
      await tester.pumpWidget(buildTestable(buildAdapter(number: '3003')));

      expect(find.byKey(const ValueKey('3003')), findsOneWidget);
    });

    group('favorite icon', () {
      testWidgets('shown when enableTileFavorite is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileFavorite: true)));

        expect(find.byKey(contactPhoneTileFavIconKey), findsOneWidget);
      });

      testWidgets('hidden when enableTileFavorite is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileFavorite: false)));

        expect(find.byKey(contactPhoneTileFavIconKey), findsNothing);
      });

      testWidgets('shows filled star when favorite is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileFavorite: true, favorite: true)));

        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.byIcon(Icons.star_border), findsNothing);
      });

      testWidgets('shows border star when favorite is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileFavorite: true, favorite: false)));

        expect(find.byIcon(Icons.star_border), findsOneWidget);
        expect(find.byIcon(Icons.star), findsNothing);
      });

      testWidgets('tapping star triggers onFavoriteChanged with toggled value', (tester) async {
        bool? receivedValue;
        await tester.pumpWidget(
          buildTestable(
            buildAdapter(enableTileFavorite: true, favorite: false, onFavoriteChanged: (v) => receivedValue = v),
          ),
        );

        await tester.tap(find.byKey(contactPhoneTileFavIconKey));
        expect(receivedValue, isTrue);
      });
    });

    group('audio call icon', () {
      testWidgets('shown when enableTileVoiceCall is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileVoiceCall: true)));

        expect(find.byIcon(Icons.call), findsOneWidget);
      });

      testWidgets('hidden when enableTileVoiceCall is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileVoiceCall: false)));

        expect(find.byIcon(Icons.call), findsNothing);
      });

      testWidgets('tapping audio icon triggers onAudioPressed', (tester) async {
        var called = false;
        await tester.pumpWidget(
          buildTestable(buildAdapter(enableTileVoiceCall: true, onAudioPressed: () => called = true)),
        );

        await tester.tap(find.byIcon(Icons.call));
        expect(called, isTrue);
      });
    });

    group('video call icon', () {
      testWidgets('shown when enableTileVideoCall is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileVideoCall: true)));

        expect(find.byIcon(Icons.videocam), findsOneWidget);
      });

      testWidgets('hidden when enableTileVideoCall is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileVideoCall: false)));

        expect(find.byIcon(Icons.videocam), findsNothing);
      });

      testWidgets('tapping video icon triggers onVideoPressed', (tester) async {
        var called = false;
        await tester.pumpWidget(
          buildTestable(buildAdapter(enableTileVideoCall: true, onVideoPressed: () => called = true)),
        );

        await tester.tap(find.byIcon(Icons.videocam));
        expect(called, isTrue);
      });
    });

    group('message icon', () {
      testWidgets('shown when isMessageEnabled is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(isMessageEnabled: true)));

        expect(find.byIcon(Icons.message), findsOneWidget);
      });

      testWidgets('hidden when isMessageEnabled is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(isMessageEnabled: false)));

        expect(find.byIcon(Icons.message), findsNothing);
      });

      testWidgets('tapping message icon triggers onMessagePressed', (tester) async {
        var called = false;
        await tester.pumpWidget(
          buildTestable(buildAdapter(isMessageEnabled: true, onMessagePressed: () => called = true)),
        );

        await tester.tap(find.byIcon(Icons.message));
        expect(called, isTrue);
      });
    });

    group('initiated transfer icon', () {
      testWidgets('shown when enableTileTransfer and isBlingTransferInitiated are true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileTransfer: true, isBlingTransferInitiated: true)));

        expect(find.byIcon(Icons.phone_forwarded), findsOneWidget);
      });

      testWidgets('hidden when enableTileTransfer is false even if isBlingTransferInitiated is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileTransfer: false, isBlingTransferInitiated: true)));

        expect(find.byIcon(Icons.phone_forwarded), findsNothing);
      });

      testWidgets('audio and video icons hidden when isBlingTransferInitiated shows transfer icon', (tester) async {
        await tester.pumpWidget(
          buildTestable(
            buildAdapter(
              enableTileVoiceCall: true,
              enableTileVideoCall: true,
              enableTileTransfer: true,
              isBlingTransferInitiated: true,
            ),
          ),
        );

        expect(find.byIcon(Icons.phone_forwarded), findsOneWidget);
        expect(find.byIcon(Icons.call), findsNothing);
        expect(find.byIcon(Icons.videocam), findsNothing);
      });

      testWidgets('tapping transfer icon triggers onTransferPressed', (tester) async {
        var called = false;
        await tester.pumpWidget(
          buildTestable(
            buildAdapter(
              enableTileTransfer: true,
              isBlingTransferInitiated: true,
              onTransferPressed: () => called = true,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.phone_forwarded));
        expect(called, isTrue);
      });
    });

    group('popup menu — transfer entry', () {
      testWidgets('shown when enableTileTransfer and hasActiveCall are true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileTransfer: true, hasActiveCall: true)));

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        expect(find.text('Transfer current call'), findsOneWidget);
      });

      testWidgets('hidden when enableTileTransfer is true but hasActiveCall is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileTransfer: true, hasActiveCall: false)));

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        expect(find.text('Transfer current call'), findsNothing);
      });

      testWidgets('tapping transfer menu entry triggers onTransferPressed', (tester) async {
        var called = false;
        await tester.pumpWidget(
          buildTestable(
            buildAdapter(enableTileTransfer: true, hasActiveCall: true, onTransferPressed: () => called = true),
          ),
        );

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Transfer current call'));
        await tester.pumpAndSettle();

        expect(called, isTrue);
      });
    });

    group('popup menu — SMS entry', () {
      testWidgets('shown when isSmsEnabled is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(isSmsEnabled: true)));

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        expect(find.text('Send sms message'), findsOneWidget);
      });

      testWidgets('hidden when isSmsEnabled is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(isSmsEnabled: false)));

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        expect(find.text('Send sms message'), findsNothing);
      });

      testWidgets('tapping SMS menu entry triggers onSmsPressed', (tester) async {
        var called = false;
        await tester.pumpWidget(buildTestable(buildAdapter(isSmsEnabled: true, onSmsPressed: () => called = true)));

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Send sms message'));
        await tester.pumpAndSettle();

        expect(called, isTrue);
      });
    });

    group('popup menu — call log entry', () {
      testWidgets('shown when enableTileCallLog is true', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileCallLog: true)));

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        expect(find.text('View call history'), findsOneWidget);
      });

      testWidgets('hidden when enableTileCallLog is false', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter(enableTileCallLog: false)));

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();

        expect(find.text('View call history'), findsNothing);
      });

      testWidgets('tapping call log entry triggers onCallLogPressed', (tester) async {
        var called = false;
        await tester.pumpWidget(
          buildTestable(buildAdapter(enableTileCallLog: true, onCallLogPressed: () => called = true)),
        );

        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pumpAndSettle();
        await tester.tap(find.text('View call history'));
        await tester.pumpAndSettle();

        expect(called, isTrue);
      });
    });

    group('ContactPhoneTile key', () {
      testWidgets('ContactPhoneTile is rendered with contactPhoneTileKey', (tester) async {
        await tester.pumpWidget(buildTestable(buildAdapter()));

        expect(find.byKey(contactPhoneTileKey), findsOneWidget);
      });
    });
  });
}
