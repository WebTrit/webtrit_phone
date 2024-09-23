import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/call/widgets/widgets.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart' hide ConfirmDialog;

class GroupInfo extends StatefulWidget {
  const GroupInfo({required this.userId, super.key});

  final String userId;
  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  late final groupCubit = context.read<GroupCubit>();
  late final contactsRepository = context.read<ContactsRepository>();

  onLeaveGroup() async {
    final askResult = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: context.l10n.messaging_GroupInfo_leaveAsk),
    );

    if (!mounted) return;
    if (askResult != true) return;

    final result = await groupCubit.leaveGroup();

    if (!mounted) return;
    const route = MessagingRouterPageRoute(children: [ConversationsScreenPageRoute()]);
    if (result) context.router.navigate(route);
  }

  onDeleteGroup() async {
    final askResult = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: context.l10n.messaging_GroupInfo_leaveAndDeleteAsk),
    );

    if (!mounted) return;
    if (askResult != true) return;

    final result = await groupCubit.deleteGroup();

    if (!mounted) return;
    const route = MessagingRouterPageRoute(children: [ConversationsScreenPageRoute()]);
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
    String askText = context.l10n.messaging_GroupInfo_removeUserAsk;

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
      askText = context.l10n.messaging_GroupInfo_makeModeratorAsk;
    } else {
      askText = context.l10n.messaging_GroupInfo_removeModeratorAsk;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: askText),
    );

    if (!mounted) return;
    if (result == true) await groupCubit.setModerator(userId, isModerator);
  }

  onNameSubmit(String value) {
    if (value.length > 3) groupCubit.setName(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        if (state is GroupStateReady) {
          final chat = state.chat;
          final name = chat.name ?? '${context.l10n.messaging_GroupInfo_titlePrefix}: ${groupCubit.state.chatId}';

          final groupAuthorities = chat.members.firstWhere((m) => m.userId == widget.userId).groupAuthorities;
          final amIOwner = groupAuthorities == GroupAuthorities.owner;
          final amIModerator = groupAuthorities == GroupAuthorities.moderator;
          final canInvite = amIOwner || amIModerator;
          final canChangeName = amIOwner || amIModerator;

          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(context.l10n.messaging_GroupInfo_title),
                  actions: [
                    CallPopupMenuButton(
                      items: [
                        if (amIOwner)
                          PopupMenuItem(
                            onTap: () => onDeleteGroup(),
                            child: ListTile(
                              title: Text(context.l10n.messaging_GroupInfo_deleteLeaveBtnText),
                              leading: const Icon(Icons.output_sharp),
                              dense: true,
                            ),
                          ),
                        if (!amIOwner)
                          PopupMenuItem(
                            onTap: () => onLeaveGroup(),
                            child: ListTile(
                              title: Text(context.l10n.messaging_GroupInfo_leaveBtnText),
                              leading: const Icon(Icons.output_sharp),
                              dense: true,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      avatar(name),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'id: ${chat.id}',
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 24),
                      nameField(chat, canChangeName),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          context.l10n.messaging_GroupInfo_groupMembersHeadline,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 18,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(0),
                          children: [
                            ...members(chat, amIOwner, amIModerator),
                            if (canInvite)
                              Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: onAddUser,
                                    label: Text(context.l10n.messaging_GroupInfo_addUserBtnText),
                                    icon: const Icon(Icons.person_add, size: 16),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
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
    );
  }

  Widget nameField(Chat chat, bool canChangeName) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      initialValue: chat.name,
      enabled: canChangeName,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: context.l10n.messaging_GroupBuilderScreen_nameFieldLabel,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondaryFixed, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondaryFixed, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.tertiary, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondaryFixed, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return context.l10n.messaging_GroupBuilderScreen_nameFieldEmpty;
        }
        if (value.length < 3) {
          return context.l10n.messaging_GroupBuilderScreen_nameFieldShort;
        }
        return null;
      },
      onFieldSubmitted: onNameSubmit,
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

      return ContactInfoBuilder(
          sourceType: ContactSourceType.external,
          sourceId: member.userId,
          builder: (context, contact, {required bool loading}) {
            if (loading) return const SizedBox();

            return ListTile(
              key: ObjectKey(member),
              minTileHeight: 0,
              contentPadding: EdgeInsets.zero,
              leading: LeadingAvatar(
                username: contact?.name ?? 'unknown user',
                thumbnail: contact?.thumbnail,
                thumbnailUrl: contact?.thumbnailUrl,
                registered: contact?.registered,
                radius: 20,
              ),
              title: Text(contact?.name ?? member.userId),
              subtitle: Text(
                member.groupAuthorities?.nameL10n(context) ?? context.l10n.messaging_GroupAuthorities_noauthorities,
                style: const TextStyle(fontSize: 12),
              ),
              trailing: ((canMakeModerator || canRemoveModerator || canRemove) && !isMe)
                  ? SizedBox(
                      width: 20,
                      child: CallPopupMenuButton(
                        items: [
                          if (canMakeModerator)
                            PopupMenuItem(
                              onTap: () => onSetModerator(member.userId, true),
                              child: ListTile(
                                title: Text(context.l10n.messaging_GroupInfo_makeModeratorBtnText),
                                leading: const Icon(Icons.add_moderator_outlined),
                                dense: true,
                              ),
                            ),
                          if (canRemoveModerator)
                            PopupMenuItem(
                              onTap: () => onSetModerator(member.userId, false),
                              child: ListTile(
                                title: Text(context.l10n.messaging_GroupInfo_unmakeModeratorBtnText),
                                leading: const Icon(Icons.remove_moderator_outlined),
                                dense: true,
                              ),
                            ),
                          if (canRemove)
                            PopupMenuItem(
                              onTap: () => onRemoveUser(member.userId),
                              child: ListTile(
                                title: Text(context.l10n.messaging_GroupInfo_removeUserBtnText),
                                leading: const Icon(Icons.person_remove_alt_1_outlined),
                                dense: true,
                              ),
                            ),
                        ],
                      ),
                    )
                  : null,
            );
          });
    }).toList();
  }

  Widget avatar(String name) {
    var text = name.split(' ').first;

    final colorScheme = Theme.of(context).colorScheme;

    if (text.length > 8) text = text.substring(text.length - 8);
    return CircleAvatar(
      radius: 50,
      backgroundColor: colorScheme.secondaryContainer,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text.toUpperCase(),
            softWrap: true,
            style: TextStyle(
              color: colorScheme.onSecondaryContainer,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
