import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/widgets/widgets.dart';
import 'package:webtrit_phone/features/chats/chats.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class GroupDrawer extends StatefulWidget {
  const GroupDrawer({required this.userId, super.key});

  final String userId;
  @override
  State<GroupDrawer> createState() => _GroupDrawerState();
}

class _GroupDrawerState extends State<GroupDrawer> {
  late final groupCubit = context.read<GroupCubit>();
  late final contactsRepository = context.read<ContactsRepository>();

  onLeaveGroup(bool amIOwner) async {
    String askText;
    if (amIOwner) {
      askText = context.l10n.chats_GroupDrawer_leaveAndDeleteAsk;
    } else {
      askText = context.l10n.chats_GroupDrawer_leaveAsk;
    }

    final askResult = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: askText),
    );

    if (!mounted) return;
    if (askResult != true) return;

    final result = await groupCubit.leaveGroup();

    if (!mounted) return;
    const route = ChatsRouterPageRoute(children: [ChatListScreenPageRoute()]);
    if (result) context.router.navigate(route);
  }

  onAddUser() async {
    final result = await showDialog<Contact>(
      context: context,
      builder: (context) => AddContactDialog(
        contactsRepository: contactsRepository,
        filter: (contact) {
          final state = groupCubit.state;
          if (state is GroupStateReady) {
            final chat = state.chat;
            final members = chat.members.map((m) => m.userId).toSet();
            final isMe = contact.sourceId == widget.userId;
            final isMember = members.contains(contact.sourceId);
            final canMessage = contact.canMessage;
            return !isMe && !isMember && canMessage;
          }
          return false;
        },
      ),
    );
    if (!mounted) return;
    if (result != null) await groupCubit.addUser(result.sourceId);
  }

  onRemoveUser(String userId) async {
    String askText = context.l10n.chats_GroupDrawer_removeUserAsk;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: askText),
    );
    if (!mounted) return;
    if (result == true) await groupCubit.removeUser(userId);
  }

  onSetModerator(String userId, bool isModerator) async {
    String askText;
    if (isModerator) {
      askText = context.l10n.chats_GroupDrawer_makeModeratorAsk;
    } else {
      askText = context.l10n.chats_GroupDrawer_removeModeratorAsk;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: askText),
    );

    if (!mounted) return;
    if (result == true) await groupCubit.setModerator(userId, isModerator);
  }

  onSetName(String? currentName) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => GroupNameDialog(initialName: currentName),
    );
    if (!mounted) return;
    if (result != null) await groupCubit.setName(result);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: Drawer(
        child: BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) {
            if (state is GroupStateReady) {
              final chat = state.chat;
              final name = chat.name ?? '${context.l10n.chats_GroupDrawer_titlePrefix}: ${groupCubit.state.chatId}';

              final groupAuthorities = chat.members.firstWhere((m) => m.userId == widget.userId).groupAuthorities;
              final amIOwner = groupAuthorities == GroupAuthorities.owner;
              final amIModerator = groupAuthorities == GroupAuthorities.moderator;
              final canInvite = amIOwner || amIModerator;

              return Stack(
                children: [
                  Column(
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      name,
                                      style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (amIOwner || amIModerator)
                                    IconButton(
                                      onPressed: () => onSetName(chat.name),
                                      icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'id: ${chat.id}',
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        context.l10n.chats_GroupDrawer_groupMembersHeadline,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 18,
                          color: theme.primaryColor,
                        ),
                      ),
                      Expanded(
                          child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: [
                          ...members(chat, amIOwner, amIModerator),
                          if (canInvite)
                            TextButton.icon(
                              onPressed: onAddUser,
                              label: Text(context.l10n.chats_GroupDrawer_addUserBtnText),
                              icon: const Icon(Icons.person_add_alt, size: 16),
                            ),
                        ],
                      )),
                      ElevatedButton(
                          onPressed: () => onLeaveGroup(amIOwner),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.output_sharp, size: 16),
                              const SizedBox(width: 4),
                              if (amIOwner) Text(context.l10n.chats_GroupDrawer_deleteLeaveBtnText),
                              if (!amIOwner) Text(context.l10n.chats_GroupDrawer_leaveBtnText),
                            ],
                          )),
                      const SizedBox(height: 8),
                    ],
                  ),
                  if (state.busy)
                    Container(
                      color: Colors.black.withOpacity(0.1),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  List<Widget> members(Chat chat, bool amIOwner, bool amIModerator) {
    return chat.members.map((member) {
      final isMe = member.userId == widget.userId;
      final isModerator = member.groupAuthorities == GroupAuthorities.moderator;
      final isRegular = member.groupAuthorities == null;

      final canRemoveUsers = amIOwner || amIModerator && isRegular;
      final canRemoveModerators = amIOwner && isModerator;
      final canRemove = canRemoveUsers || canRemoveModerators;
      final canMakeModerator = amIOwner && isRegular;
      final canRemoveModerator = amIOwner && isModerator;

      return ListTile(
        minTileHeight: 0,
        title: ParticipantName(senderId: member.userId, userId: widget.userId),
        subtitle: Text(
          member.groupAuthorities?.nameL10n(context) ?? context.l10n.chats_GroupAuthorities_noauthorities,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: ((canMakeModerator || canRemoveModerator || canRemove) && !isMe)
            ? SizedBox(
                width: 20,
                child: CallPopupMenuButton(
                  items: [
                    if (canMakeModerator)
                      PopupMenuItem(
                        child: ListTile(
                          title: Text(context.l10n.chats_GroupDrawer_makeModeratorBtnText),
                          leading: const Icon(Icons.add_moderator_outlined),
                          onTap: () => onSetModerator(member.userId, true),
                          dense: true,
                        ),
                      ),
                    if (canRemoveModerator)
                      PopupMenuItem(
                        child: ListTile(
                          title: Text(context.l10n.chats_GroupDrawer_unmakeModeratorBtnText),
                          leading: const Icon(Icons.remove_moderator_outlined),
                          onTap: () => onSetModerator(member.userId, false),
                          dense: true,
                        ),
                      ),
                    if (canRemove)
                      PopupMenuItem(
                        child: ListTile(
                          title: Text(context.l10n.chats_GroupDrawer_removeUserBtnText),
                          leading: const Icon(Icons.person_remove_alt_1_outlined),
                          onTap: () => onRemoveUser(member.userId),
                          dense: true,
                        ),
                      ),
                  ],
                ),
              )
            : null,
      );
    }).toList();
  }
}
