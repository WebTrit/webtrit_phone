import 'package:flutter/foundation.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

/// What a conversations tab is called, how it is addressed, and what it counts.
///
/// Which of the tabs a build shows comes from its configuration, so a flow can
/// only address one by the kind of conversation behind it - the captions are
/// translated and their positions move with that list. Answering all of it in
/// one place is also what keeps the answers together: a tab added later must
/// state every one of them or fail to compile.
///
/// All four live here, next to the state one of them needs, rather than half
/// here and half beside the enum: a tab is one thing, and a second entry into
/// the section should have one place to ask.
extension ConversationsTabX on ConversationsTab {
  /// Stable, non-localized automation id of this tab.
  String get tabId => switch (this) {
    ConversationsTab.chat => conversationsTabChatId,
    ConversationsTab.sms => conversationsTabSmsId,
  };

  /// Widget key of the same tab - built from the id, so the widget-test anchor
  /// and the accessibility anchor cannot drift apart.
  Key get tabKey => switch (this) {
    ConversationsTab.chat => conversationsTabChatKey,
    ConversationsTab.sms => conversationsTabSmsKey,
  };

  /// Caption of the tab, in the app's language.
  String l10n(AppLocalizations l10n) => switch (this) {
    ConversationsTab.chat => l10n.messaging_ConversationsScreen_messages_title,
    ConversationsTab.sms => l10n.messaging_ConversationsScreen_smses_title,
  };

  /// How many conversations of this kind are unread.
  int unreadCount(UnreadCountState state) => switch (this) {
    ConversationsTab.chat => state.chatsWithUnreadCount,
    ConversationsTab.sms => state.smsConversationsWithUnreadCount,
  };
}
