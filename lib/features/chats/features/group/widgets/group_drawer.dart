import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/widgets/widgets.dart';
import 'package:webtrit_phone/features/chats/features/group/group.dart';
import 'package:webtrit_phone/models/models.dart';

class GroupDrawer extends StatefulWidget {
  const GroupDrawer({required this.userId, super.key});

  final String userId;
  @override
  State<GroupDrawer> createState() => _GroupDrawerState();
}

class _GroupDrawerState extends State<GroupDrawer> {
  late final groupCubit = context.read<GroupCubit>();

  onLeaveGroup() async {
    final result = await groupCubit.leaveGroup();

    if (!mounted) return;
    const route = ChatsRouterPageRoute(children: [ChatListScreenPageRoute()]);
    if (result) context.router.navigate(route);
  }

  onAddUser() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const AddUserDialog(),
    );

    if (result != null) {
      await groupCubit.addUser(result);
    }
  }

  onRemoveUser(String userId) async {
    await groupCubit.removeUser(userId);
  }

  onSetModerator(String userId, bool isModerator) async {
    await groupCubit.setModerator(userId, isModerator);
  }

  onSetName(String? currentName) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => GroupNameDialog(initialName: currentName),
    );

    if (result != null) {
      await groupCubit.setName(result);
    }
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
              final name = chat.name ?? 'Group: ${groupCubit.state.chatId}';

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
                        'Group members',
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
                              label: const Text('Add user'),
                              icon: const Icon(Icons.person_add_alt, size: 16),
                            ),
                        ],
                      )),
                      ElevatedButton(
                          onPressed: onLeaveGroup,
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [Icon(Icons.output_sharp, size: 16), SizedBox(width: 4), Text('Leave group')],
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
        title: Text(member.userId),
        subtitle: Text(member.groupAuthorities?.name ?? 'member'),
        trailing: ((canMakeModerator || canRemoveModerator || canRemove) && !isMe)
            ? SizedBox(
                width: 20,
                child: CallPopupMenuButton(
                  items: [
                    if (canMakeModerator)
                      CallPopupMenuItem(
                        icon: const Icon(Icons.add_moderator_outlined),
                        text: 'Make moderator',
                        onTap: () => onSetModerator(member.userId, true),
                      ),
                    if (canRemoveModerator)
                      CallPopupMenuItem(
                        icon: const Icon(Icons.remove_moderator_outlined),
                        text: 'Unmake moderator',
                        onTap: () => onSetModerator(member.userId, false),
                      ),
                    if (canRemove)
                      CallPopupMenuItem(
                        icon: const Icon(Icons.person_remove_alt_1_outlined),
                        text: 'Remove',
                        onTap: () => onRemoveUser(member.userId),
                      ),
                  ],
                ),
              )
            : null,
      );
    }).toList();
  }
}
