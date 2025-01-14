import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/messaging/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/widgets/widgets.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

class ParticipantName extends StatelessWidget {
  const ParticipantName({
    required this.senderId,
    required this.userId,
    this.style,
    this.textMap,
    super.key,
  }) : isMine = senderId == userId;

  final String senderId;
  final String userId;
  final bool isMine;
  final TextStyle? style;
  final String Function(String)? textMap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = style ?? theme.userNameStyle;

    if (isMine) {
      return Text(
        textMap?.call(context.l10n.messaging_ParticipantName_you) ?? context.l10n.messaging_ParticipantName_you,
        style: textStyle,
      );
    } else {
      return ContactInfoBuilder(
        sourceType: ContactSourceType.external,
        sourceId: senderId,
        builder: (context, contact, {required bool loading}) {
          if (loading) return const SizedBox.shrink();

          final name = contact?.displayTitle ?? context.l10n.messaging_ParticipantName_unknown;
          final mappedName = textMap?.call(name) ?? name;
          return Text(mappedName, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis);
        },
      );
    }
  }
}
