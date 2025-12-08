import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../participant_name.dart';
import 'typing_icon_driver.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key, required this.userId, this.typingUsers = const {}, this.typingNumbers = const {}});

  final String userId;
  final Set<String> typingUsers;
  final Set<String> typingNumbers;

  @override
  Widget build(BuildContext context) {
    final anybodyTyping = typingUsers.isNotEmpty || typingNumbers.isNotEmpty;
    const textStyle = TextStyle(fontSize: 12, color: Colors.grey);

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 600),
      sizeCurve: Curves.elasticOut,
      firstChild: const SizedBox(),
      secondChild: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          children: [
            const TypingIconDriver(),
            for (final id in typingUsers) ...[ParticipantName(senderId: id, userId: userId, style: textStyle)],
            for (final number in typingNumbers) ...[Text(number, style: textStyle)],
            Text(context.l10n.messaging_MessageListView_typingTrail, style: textStyle),
          ],
        ),
      ),
      crossFadeState: anybodyTyping ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
