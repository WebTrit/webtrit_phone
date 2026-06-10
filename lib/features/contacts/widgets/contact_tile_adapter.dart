import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/features/call_routing/cubit/call_routing_cubit.dart';
import 'package:webtrit_phone/features/messaging/extensions/contact.dart';
import 'package:webtrit_phone/models/models.dart';

import 'contact_tile.dart';

/// Wires a contacts-list [ContactTile] to the call/chat/history actions so the
/// local and external tabs share one behavior: tap expands the quick-actions
/// bar, the trailing phone icon dials, and blind-transfer mode turns tap into
/// the transfer submission (same semantics as the recents and favorites lists).
class ContactTileAdapter extends StatelessWidget {
  const ContactTileAdapter({
    super.key,
    required this.contact,
    required this.expanded,
    required this.onToggleExpanded,
    this.tileKey,
  });

  final Contact contact;
  final bool expanded;
  final VoidCallback onToggleExpanded;
  final Key? tileKey;

  @override
  Widget build(BuildContext context) {
    final callController = CallControllerScope.of(context);
    final featureAccess = context.read<FeatureAccess>();

    final transferEnabled = featureAccess.callConfig.capabilities.isBlindTransferEnabled;
    final videoEnabled = featureAccess.callConfig.capabilities.isVideoCallEnabled;
    final chatsEnabled = featureAccess.messagingConfig.chatsPresent;
    final cdrsEnabled = featureAccess.bottomMenuConfig.getTabEnabled<RecentsBottomMenuTab>()?.supportsCallHistory;

    final number =
        contact.extension ?? contact.mobileNumber ?? (contact.phones.isNotEmpty ? contact.phones.first.number : null);

    void submitTransfer(String destination) {
      callController.submitTransfer(destination);
      context.router.maybePop();
    }

    void openCallLog(String number) {
      if (cdrsEnabled == true) {
        context.router.navigate(NumberCdrsScreenPageRoute(number: number));
      } else {
        context.router.navigate(CallLogScreenPageRoute(number: number));
      }
    }

    return BlocBuilder<CallBloc, CallState>(
      buildWhen: (previous, current) =>
          previous.isBlingTransferInitiated != current.isBlingTransferInitiated ||
          previous.activeCalls != current.activeCalls,
      builder: (context, callState) {
        final transfer = callState.isBlingTransferInitiated;
        final hasActiveCall = callState.activeCalls.isNotEmpty;

        return BlocBuilder<CallRoutingCubit, CallRoutingState?>(
          builder: (context, callRoutingState) {
            return ContactTile(
              key: tileKey,
              displayName: contact.displayTitle,
              thumbnail: contact.thumbnail,
              thumbnailUrl: contact.thumbnailUrl,
              registered: contact.registered,
              presenceInfo: contact.presenceInfo,
              dialogInfo: contact.dialogInfo,
              onTap: transfer ? (number != null ? () => submitTransfer(number) : null) : onToggleExpanded,
              expanded: expanded && !transfer,
              onDialPressed: !transfer && number != null
                  ? () => callController.createCall(destination: number, displayName: contact.maybeName, video: false)
                  : null,
              callNumbers: callRoutingState?.allNumbers ?? [],
              onAudioCallPressed: number != null
                  ? () => callController.createCall(destination: number, displayName: contact.maybeName, video: false)
                  : null,
              onVideoCallPressed: number != null && videoEnabled
                  ? () => callController.createCall(destination: number, displayName: contact.maybeName, video: true)
                  : null,
              onTransferPressed: number != null && transferEnabled && hasActiveCall
                  ? () => submitTransfer(number)
                  : null,
              onChatPressed: chatsEnabled && contact.canMessage
                  ? () => context.router.navigate(ChatConversationScreenPageRoute(participantId: contact.sourceId!))
                  : null,
              onViewContactPressed: () => context.router.navigate(ContactScreenPageRoute(contactId: contact.id)),
              onCallLogPressed: number != null ? () => openCallLog(number) : null,
              onCallFrom: number != null
                  ? (fromNumber) => callController.createCall(
                      destination: number,
                      displayName: contact.maybeName,
                      fromNumber: fromNumber,
                      video: false,
                    )
                  : null,
              copyNumber: number,
            );
          },
        );
      },
    );
  }
}
