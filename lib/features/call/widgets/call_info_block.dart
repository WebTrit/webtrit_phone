import 'package:flutter/material.dart';

import '../bloc/call_bloc.dart';
import '../models/models.dart';
import '../view/call_screen_styles.dart';
import 'call_info.dart';
import 'call_list.dart';

/// Who the screen is about: with several calls - the tappable roster (every
/// call a row, the focused one highlighted), with a single call - its central
/// info block.
///
/// The block is shared by the orientation layouts: each of them decides where
/// it stands, none of them what is inside.
class CallInfoBlock extends StatelessWidget {
  const CallInfoBlock({super.key, required this.activeCalls, required this.focusedCall, required this.onCallSelected});

  final List<ActiveCall> activeCalls;

  /// The call the info block describes; the roster highlights its row.
  final ActiveCall focusedCall;

  final ValueChanged<String> onCallSelected;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).extension<CallScreenStyles>()?.primary;

    // List-based call screen: with more than one call every call is a
    // tappable row, and the info block + action area act on the focused call.
    if (activeCalls.length > 1) {
      return CallList(
        calls: activeCalls,
        focusedCallId: focusedCall.callId,
        style: style?.callInfo,
        listStyle: style?.list,
        onCallTap: onCallSelected,
      );
    }

    // With multiple calls the list rows carry the per-call info, so the
    // central info block is single-call only.
    final focusedTransfer = focusedCall.transfer;
    return CallInfo(
      transfering: focusedTransfer is Transfering,
      requestToAttendedTransfer: false,
      inviteToAttendedTransfer: focusedTransfer is InviteToAttendedTransfer,
      isIncoming: focusedCall.isIncoming,
      held: focusedCall.held,
      number: focusedCall.handle.value,
      username: focusedCall.displayName,
      acceptedTime: focusedCall.acceptedTime,
      style: style?.callInfo,
      processingStatus: focusedCall.processingStatus,
    );
  }
}
