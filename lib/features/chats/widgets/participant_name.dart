import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/chats/widgets/widgets.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ParticipantName extends StatelessWidget {
  const ParticipantName({
    required this.senderId,
    required this.userId,
    this.style,
    super.key,
  }) : isMine = senderId == userId;

  final String senderId;
  final String userId;
  final bool isMine;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final textStyle = style ?? TextStyle(color: scheme.secondaryFixed, fontSize: 12, fontWeight: FontWeight.bold);

    if (isMine) {
      return Text('You', style: textStyle);
    } else {
      return ContactInfoBuilder(
        sourceType: ContactSourceType.external,
        sourceId: senderId,
        builder: (context, contact) {
          if (contact != null) {
            return FadeIn(child: Text(contact.name, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis));
          } else {
            return FadeIn(child: Text(senderId, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis));
          }
        },
      );
    }
  }
}
