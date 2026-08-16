import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/contact/contact.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../helpers/helpers.dart';
import 'contact_screen_harness.dart';

void main() {
  late ContactScreenHarness harness;

  setUp(() => harness = ContactScreenHarness());

  const email = ContactEmail(id: 1, address: 'anna@example.com', label: 'work');
  const secondEmail = ContactEmail(id: 2, address: 'anna@work.example', label: 'office');

  const twoNumbers = [
    ContactPhone(id: 1, number: '1001', label: 'ext', favorite: false),
    ContactPhone(id: 2, number: '2002', label: 'number', favorite: false),
  ];

  const presenceLabel = 'Subscribe to user status via SIP (Presence)';
  const dialogsLabel = 'Subscribe to active calls via SIP (BLF/Dialogs)';

  group('the phone row of the contact card', () {
    testWidgets('every action says what it does and can be reached by id', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withUserSmsNumbers(['2002']);

      await harness.pump(tester, contact: buildContact(number: '1001'));

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneTileFavIconId),
        label: 'Add 1001 to favorites',
        identifier: contactPhoneTileFavIconId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneVoiceCallId),
        label: 'Call 1001',
        identifier: contactPhoneVoiceCallId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneVideoCallId),
        label: 'Video call 1001',
        identifier: contactPhoneVideoCallId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneChatId),
        label: 'Send chat message',
        identifier: contactPhoneChatId,
      );
      // The stock name of a popup button ("Show menu") would otherwise be
      // spoken on top of this one.
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneMenuId),
        label: 'More',
        identifier: contactPhoneMenuId,
      );

      handle.dispose();
    });

    testWidgets('a second number gets ids of its own', (tester) async {
      final handle = tester.ensureSemantics();

      // Every row offers the same actions, so without numbering the card hands
      // out the same id several times and nothing can be addressed at all.
      await harness.pump(tester, contact: buildContact(numbers: twoNumbers));

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(numberedId(contactPhoneVoiceCallId, 1)),
        label: 'Call 2002',
        identifier: numberedId(contactPhoneVoiceCallId, 1),
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(numberedId(contactPhoneVideoCallId, 1)),
        label: 'Video call 2002',
        identifier: numberedId(contactPhoneVideoCallId, 1),
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(numberedId(contactPhoneTileFavIconId, 1)),
        label: 'Add 2002 to favorites',
        identifier: numberedId(contactPhoneTileFavIconId, 1),
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(numberedId(contactPhoneMenuId, 1)),
        label: 'More',
        identifier: numberedId(contactPhoneMenuId, 1),
      );

      // The first row keeps the plain id, and both rows stay separate nodes.
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneVoiceCallId),
        label: 'Call 1001',
        identifier: contactPhoneVoiceCallId,
      );

      handle.dispose();
    });

    testWidgets('the star says which way it will go', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact(favorite: true));

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneTileFavIconId),
        label: 'Remove 1001 from favorites',
        identifier: contactPhoneTileFavIconId,
      );

      handle.dispose();
    });

    testWidgets('the menu opens through the semantics node, not only under a finger', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact());

      await tapViaSemantics(tester, find.bySemanticsIdentifier(contactPhoneMenuId));
      await tester.pumpAndSettle();

      expect(find.text('Copy number'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('each transfer shortcut names the number it hands the call to', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withBlindTransferUnderWay();

      await harness.pump(tester, contact: buildContact(numbers: twoNumbers), enableTileTransfer: true);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneTransferId),
        label: 'Transfer current call to 1001',
        identifier: contactPhoneTransferId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(numberedId(contactPhoneTransferId, 1)),
        label: 'Transfer current call to 2002',
        identifier: numberedId(contactPhoneTransferId, 1),
      );

      handle.dispose();
    });
  });

  group('the rest of the contact card', () {
    testWidgets('the chat button of the header is named', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact());

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactChatId),
        label: 'Send chat message',
        identifier: contactChatId,
      );

      handle.dispose();
    });

    testWidgets('each address row offers a named way to write', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact(emails: const [email, secondEmail]));

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactEmailSendId),
        label: 'Send an email to anna@example.com',
        identifier: contactEmailSendId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(numberedId(contactEmailSendId, 1)),
        label: 'Send an email to anna@work.example',
        identifier: numberedId(contactEmailSendId, 1),
      );

      handle.dispose();
    });

    testWidgets('the card says which screen it is', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact());

      expect(find.bySemanticsIdentifier(contactScreenId), findsOneWidget);

      handle.dispose();
    });
  });

  group('the options of the contact card', () {
    testWidgets('an option is one node carrying its caption, its state and its press', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact(), dialogsViaSip: true, presenceViaSip: true);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPresenceSubscriptionId),
        label: presenceLabel,
        identifier: contactPresenceSubscriptionId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactDialogsSubscriptionId),
        label: dialogsLabel,
        identifier: contactDialogsSubscriptionId,
      );

      // The state of the switch is part of what is announced, so a screen
      // reader user knows whether pressing turns it on or off.
      expect(
        tester.getSemantics(find.bySemanticsIdentifier(contactDialogsSubscriptionId)),
        isSemantics(hasCheckedState: true, isChecked: false),
      );

      await tapViaSemantics(tester, find.bySemanticsIdentifier(contactDialogsSubscriptionId));
      verify(
        () => harness.contactBloc.add(const ContactSipSubscriptionToggled(true, SipSubscriptionType.blf)),
      ).called(1);

      await tapViaSemantics(tester, find.bySemanticsIdentifier(contactPresenceSubscriptionId));
      verify(
        () => harness.contactBloc.add(const ContactSipSubscriptionToggled(true, SipSubscriptionType.presence)),
      ).called(1);

      handle.dispose();
    });

    testWidgets('each explanation is a button that names the option it explains', (tester) async {
      final handle = tester.ensureSemantics();

      // Both buttons look the same and sit one under the other, so the caption
      // of the option is the only thing that tells them apart by ear.
      await harness.pump(tester, contact: buildContact(), dialogsViaSip: true, presenceViaSip: true);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPresenceSubscriptionInfoId),
        label: 'What $presenceLabel means',
        identifier: contactPresenceSubscriptionInfoId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactDialogsSubscriptionInfoId),
        label: 'What $dialogsLabel means',
        identifier: contactDialogsSubscriptionInfoId,
      );

      handle.dispose();
    });

    testWidgets('the explanation opens through the node and is there to be read', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact(), dialogsViaSip: true);

      await tapViaSemantics(tester, find.bySemanticsIdentifier(contactDialogsSubscriptionInfoId));
      await tester.pumpAndSettle();

      // The explanation is content now, not a tooltip: a screen reader reaches
      // the paragraph itself, and the way out of it is a named button.
      expect(find.textContaining('SIP-Dialogs'), findsOneWidget);
      expect(tester.getSemantics(find.textContaining('SIP-Dialogs')).getSemanticsData().label, contains('SIP-Dialogs'));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      await tapViaSemantics(tester, find.widgetWithText(TextButton, 'Ok'));
      await tester.pumpAndSettle();
      expect(find.textContaining('SIP-Dialogs'), findsNothing);

      handle.dispose();
    });
  });

  testWidgets('nothing on the card offers a press without saying what it is', (tester) async {
    final handle = tester.ensureSemantics();
    harness.withUserSmsNumbers(['2002']);

    await harness.pump(
      tester,
      contact: buildContact(numbers: twoNumbers, emails: const [email, secondEmail]),
      dialogsViaSip: true,
      presenceViaSip: true,
    );

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
