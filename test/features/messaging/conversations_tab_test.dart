import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/app_localizations_en.g.dart';
import 'package:webtrit_phone/models/models.dart';

void main() {
  test('every tab is addressed by the id it declares, and its key is that id', () {
    // A flow finds a tab by its id and a widget test by its key; the two are
    // the same string on purpose, so one cannot be changed without the other.
    final expectations = {ConversationsTab.chat: conversationsTabChatId, ConversationsTab.sms: conversationsTabSmsId};

    expect(expectations.keys, containsAll(ConversationsTab.values), reason: 'a tab added later must state its id');
    for (final MapEntry(key: tab, value: id) in expectations.entries) {
      expect(tab.tabId, id, reason: tab.name);
      expect(tab.tabKey, Key(id), reason: tab.name);
    }
  });

  test('a tab is captioned by the translations, not by its own name', () {
    final l10n = AppLocalizationsEn();

    expect(ConversationsTab.chat.l10n(l10n), l10n.messaging_ConversationsScreen_messages_title);
    expect(ConversationsTab.sms.l10n(l10n), l10n.messaging_ConversationsScreen_smses_title);
  });

  test('a tab counts only what belongs to it', () {
    // Two chats with something unread and one text conversation - the counts
    // are of conversations, so the message numbers differ deliberately.
    final state = UnreadCountState.fromCountPerChat({1: 3, 2: 1}, {7: 5});

    expect(ConversationsTab.chat.unreadCount(state), 2);
    expect(ConversationsTab.sms.unreadCount(state), 1);
  });
}
