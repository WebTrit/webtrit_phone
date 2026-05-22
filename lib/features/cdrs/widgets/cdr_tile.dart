import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/recents/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CdrTile extends StatelessWidget {
  const CdrTile({
    super.key,
    required this.cdr,
    this.contact,
    required this.callNumbers,
    this.onTap,
    this.onAudioCallPressed,
    this.onVideoCallPressed,
    this.onTransferPressed,
    this.onChatPressed,
    this.onSendSmsPressed,
    this.onViewContactPressed,
    this.onCallLogPressed,
    this.onCallFrom,
  });

  final CdrRecord cdr;
  final Contact? contact;
  final List<String> callNumbers;
  final Function()? onTap;
  final Function()? onAudioCallPressed;
  final Function()? onVideoCallPressed;
  final Function()? onTransferPressed;
  final Function()? onChatPressed;
  final Function()? onSendSmsPressed;
  final Function()? onViewContactPressed;
  final Function()? onCallLogPressed;
  final Function(String)? onCallFrom;

  String get participant => cdr.participant;
  String? get participantNumber => cdr.participantNumber;
  String get name => contact?.maybeName ?? participant;
  String get number => participantNumber ?? participant;
  bool get nameSameAsNumber => name == number;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Reasons suppressed from display (ITU-T Q.850):
    // - unknown: no meaningful info for the user
    // - normalCallClearing: expected happy-path ending (cause 16)
    // - validCauseCodeNotYetReceived: cause 0, written to CDR when no Reason header is present
    // - internetworkingUnspecified: cause 127, fallback for SIP responses without specific Q.850 mapping
    String? disconnectText;
    if (cdr.disconnectReasonEnum != null) {
      if (cdr.disconnectReasonEnum != CdrDisconnectReason.unknown &&
          cdr.disconnectReasonEnum != CdrDisconnectReason.normalCallClearing &&
          cdr.disconnectReasonEnum != CdrDisconnectReason.validCauseCodeNotYetReceived &&
          cdr.disconnectReasonEnum != CdrDisconnectReason.internetworkingUnspecified) {
        disconnectText = l10n.parseL10n(cdr.disconnectReasonEnum!.l10nKey) ?? cdr.disconnectReasonEnum!.rawValue;
      }
    } else if (cdr.disconnectReason.isNotEmpty) {
      disconnectText = cdr.disconnectReason;
    }

    return CallTile(
      leading: LeadingAvatar(
        username: name,
        thumbnail: contact?.thumbnail,
        thumbnailUrl: contact?.thumbnailUrl,
        registered: contact?.registered,
        presenceInfo: contact?.presenceInfo,
        dialogInfo: contact?.dialogInfo,
      ),
      name: name,
      subName: nameSameAsNumber ? null : number,
      subtitleLeading: Icon(
        cdr.direction.icon(cdr.status == CdrStatus.accepted),
        size: 14,
        color: cdr.direction == CallDirection.incoming ? Colors.blue : Colors.green,
      ),
      timeLabel: cdr.connectTime.toLocal().timeOrDate,
      durationLabel: cdr.duration.format(),
      disconnectReason: disconnectText,
      onTap: onTap,
      callNumbers: callNumbers,
      onAudioCallPressed: onAudioCallPressed,
      onVideoCallPressed: onVideoCallPressed,
      onTransferPressed: onTransferPressed,
      onChatPressed: onChatPressed,
      onSendSmsPressed: onSendSmsPressed,
      onViewContactPressed: onViewContactPressed,
      onCallLogPressed: onCallLogPressed,
      onCallFrom: onCallFrom,
      copyNumber: participantNumber,
      copyCallId: cdr.callId,
    );
  }
}
