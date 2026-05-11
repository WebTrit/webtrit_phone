// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/recents/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CdrTile extends StatefulWidget {
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

  @override
  State<CdrTile> createState() => _CdrTileState();
}

class _CdrTileState extends State<CdrTile> {
  late final tileKey = GlobalKey();

  CdrRecord get cdr => widget.cdr;
  Contact? get contact => widget.contact;

  String get participant => widget.cdr.participant;
  String? get participantNumber => widget.cdr.participantNumber;

  String get name => contact?.maybeName ?? participant;
  String get number => participantNumber ?? participant;
  bool get nameSameAsNumber => name == number;

  void showMenuPopup() {
    showMenu(
      context: context,
      position: getPosition(),
      items: buildNumberActions(
        context,
        callNumbers: widget.callNumbers,
        onAudioCallPressed: widget.onAudioCallPressed,
        onVideoCallPressed: widget.onVideoCallPressed,
        onTransferPressed: widget.onTransferPressed,
        onChatPressed: widget.onChatPressed,
        onSendSmsPressed: widget.onSendSmsPressed,
        onViewContactPressed: widget.onViewContactPressed,
        onCallLogPressed: widget.onCallLogPressed,
        onCallFrom: widget.onCallFrom,
        copyNumber: participantNumber,
        copyCallId: cdr.callId,
      ),
    );
  }

  RelativeRect getPosition() {
    final RenderBox renderBox = tileKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final screenSize = MediaQuery.of(context).size;
    late Offset offset = Offset(screenSize.width - 16, 16);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(offset, ancestor: overlay),
        renderBox.localToGlobal(renderBox.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
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
      } else {
        disconnectText = null;
      }
    } else if (cdr.disconnectReason.isNotEmpty) {
      disconnectText = cdr.disconnectReason;
    }

    final directionIcon = Icon(
      cdr.direction.icon(cdr.status == CdrStatus.accepted),
      size: 14,
      color: cdr.direction == CallDirection.incoming ? Colors.blue : Colors.green,
    );

    final nameTitle = Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: themeData.textTheme.titleMedium);

    final phoneLabel = Text(
      number,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: themeData.textTheme.labelSmall,
      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false, applyHeightToLastDescent: false),
    );

    final disconnectReasonLabel = Text(
      disconnectText ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: themeData.textTheme.labelSmall,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Material(
        color: colorScheme.surface.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: colorScheme.secondary.withAlpha(50),
          key: tileKey,
          onTap: widget.onTap,
          onLongPress: showMenuPopup,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 0, top: 8, bottom: 8),
            child: Row(
              children: [
                LeadingAvatar(
                  username: name,
                  thumbnail: contact?.thumbnail,
                  thumbnailUrl: contact?.thumbnailUrl,
                  registered: contact?.registered,
                  presenceInfo: contact?.presenceInfo,
                  dialogInfo: contact?.dialogInfo,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!nameSameAsNumber) ...[
                        nameTitle,
                        Row(children: [directionIcon, const SizedBox(width: 4), phoneLabel]),
                        if (disconnectText != null) ...[SizedBox(height: 2), disconnectReasonLabel],
                      ],
                      if (nameSameAsNumber && disconnectText == null) ...[
                        Row(children: [directionIcon, const SizedBox(width: 4), nameTitle]),
                      ],
                      if (nameSameAsNumber && disconnectText != null) ...[
                        nameTitle,
                        Row(children: [directionIcon, const SizedBox(width: 4), disconnectReasonLabel]),
                      ],
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(cdr.connectTime.toLocal().timeOrDate, style: themeData.textTheme.labelSmall),
                    const SizedBox(width: 4),
                    Text(cdr.duration.format(), style: themeData.textTheme.labelSmall),
                  ],
                ),
                SizedBox(width: 4),
                TileMenuButton(onTap: showMenuPopup),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
