import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'builder_stages/dialog_contact_selection_view.dart';
import 'builder_stages/group_contacts_selection_view.dart';
import 'builder_stages/group_fill_info_view.dart';

class ChatConversationBuilderView extends StatefulWidget {
  const ChatConversationBuilderView({super.key});

  @override
  State<ChatConversationBuilderView> createState() => _ChatConversationBuilderViewState();
}

class _ChatConversationBuilderViewState extends State<ChatConversationBuilderView> {
  late final builderCubit = context.read<ChatConversationBuilderCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatConversationBuilderCubit, ChatCBState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Stack(
            children: [
              Scaffold(
                appBar: buildAppBar(state),
                body: Builder(
                  builder: (context) {
                    if (state is ChatCBCommon) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 0),
                        switchInCurve: Curves.easeOutExpo,
                        switchOutCurve: Curves.easeInExpo,
                        child: switch (state) {
                          ChatCBDialogContactSelection() => DialogContactSelectionView(state),
                          ChatCBGroupContactsSelection() => GroupContactsSelectionView(state),
                          ChatCBGroupFillInfo() => GroupFillInfoView(state),
                        },
                        transitionBuilder: (child, animation) {
                          final reverse = state.cameBack;

                          final begin = Offset(reverse ? -1.0 : 1.0, 0);
                          const end = Offset(0, 0);

                          return SlideTransition(
                            position: animation.drive(Tween(begin: begin, end: end)),
                            child: child,
                          );
                        },
                      );
                    }

                    if (state is ChatCBInitializingError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(state.error.toString())],
                        ),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                    // return widget;
                  },
                ),
              ),
              if (state is ChatCBGroupFillInfo && state.processing)
                Container(
                  color: Colors.black.withValues(alpha: 0.1),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  AppBar buildAppBar(ChatCBState state) {
    if (state is ChatCBGroupContactsSelection || state is ChatCBGroupFillInfo) {
      return AppBar(
        title: Text(context.l10n.messaging_ConversationBuilders_title_group),
        leading: TextButton(
          onPressed: builderCubit.onBackToPrevStage,
          child: Text(context.l10n.messaging_ConversationBuilders_back),
        ),
        leadingWidth: 100,
        actions: [
          if (state is ChatCBGroupContactsSelection && state.selectedContacts.isNotEmpty)
            TextButton(
              onPressed: builderCubit.onGroupFillInfoStageChoosen,
              child: Text(context.l10n.messaging_ConversationBuilders_next_action),
            ),
          if (state is ChatCBGroupFillInfo && state.name.length >= 3)
            TextButton(
              onPressed: builderCubit.onGroupCreateConfirm,
              child: Text(context.l10n.messaging_ConversationBuilders_create),
            ),
        ],
      );
    }
    return AppBar(
      title: Text(context.l10n.messaging_ConversationBuilders_title_new),
      leadingWidth: 100,
      leading: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(context.l10n.messaging_ConversationBuilders_cancel),
      ),
    );
  }
}
