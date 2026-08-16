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

    testWidgets('the star says which way it will go', (tester) async {
      final handle = tester.ensureSemantics();

      final favorite = Contact(
        id: 1,
        sourceType: ContactSourceType.external,
        kind: ContactKind.visible,
        sourceId: 'user-1',
        userRegistered: true,
        isCurrentUser: false,
        firstName: 'Anna',
        phones: const [ContactPhone(id: 1, number: '1001', label: 'ext', favorite: true)],
      );

      await harness.pump(tester, contact: favorite);

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

    testWidgets('the transfer shortcut is named while a call is being transferred', (tester) async {
      final handle = tester.ensureSemantics();
      harness.withBlindTransferUnderWay();

      await harness.pump(tester, contact: buildContact(), enableTileTransfer: true);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactPhoneTransferId),
        label: 'Transfer current call',
        identifier: contactPhoneTransferId,
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

    testWidgets('the address row offers a named way to write', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact(emails: const [email]));

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactEmailSendId),
        label: 'Send an email to anna@example.com',
        identifier: contactEmailSendId,
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
        label: 'Subscribe to user status via SIP (Presence)',
        identifier: contactPresenceSubscriptionId,
      );
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactDialogsSubscriptionId),
        label: 'Subscribe to active calls via SIP (BLF/Dialogs)',
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

      handle.dispose();
    });

    testWidgets('the explanation is a named button of its own', (tester) async {
      final handle = tester.ensureSemantics();

      await harness.pump(tester, contact: buildContact(), dialogsViaSip: true);

      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier(contactDialogsSubscriptionInfoId),
        label: 'What this option does',
        identifier: contactDialogsSubscriptionInfoId,
      );

      await tapViaSemantics(tester, find.bySemanticsIdentifier(contactDialogsSubscriptionInfoId));
      await tester.pumpAndSettle();

      expect(find.textContaining('SIP-Dialogs'), findsOneWidget);

      handle.dispose();
    });
  });

  testWidgets('nothing on the card offers a press without saying what it is', (tester) async {
    final handle = tester.ensureSemantics();
    harness.withUserSmsNumbers(['2002']);

    await harness.pump(tester, contact: buildContact(emails: const [email]), dialogsViaSip: true, presenceViaSip: true);

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
