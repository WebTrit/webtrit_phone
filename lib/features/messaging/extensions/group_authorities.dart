import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/chat_member.dart';

extension GroupAuthoritiesL10n on GroupAuthorities {
  String nameL10n(BuildContext context) {
    switch (this) {
      case GroupAuthorities.owner:
        return context.l10n.chats_GroupAuthorities_owner;
      case GroupAuthorities.moderator:
        return context.l10n.chats_GroupAuthorities_moderator;
    }
  }
}
