import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

// TODO:
//  - extract logic to cubit
//  - handle business errors
//  - use notificationBloc

class GroupBuilderScreen extends StatefulWidget {
  const GroupBuilderScreen({super.key});

  @override
  State<GroupBuilderScreen> createState() => _GroupBuilderScreenState();
}

class _GroupBuilderScreenState extends State<GroupBuilderScreen> {
  late final contactsRepository = context.read<ContactsRepository>();
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  Set<Contact> selectedUsers = {};
  bool busy = false;

  bool get isValid => formKey.currentState?.validate() == true;

  onAddUser() async {
    final result = await showDialog<Contact>(
      context: context,
      builder: (context) => AddContactDialog(
        contactsRepository: contactsRepository,
        filter: (contact) => !selectedUsers.contains(contact) && contact.canMessage,
      ),
    );

    if (result != null) {
      setState(() => selectedUsers.add(result));
    }
  }

  void onRemoveMember(Contact user) {
    setState(() => selectedUsers.remove(user));
  }

  Future<void> onSubmit() async {
    if (isValid) return;
    final chatsBloc = context.read<ChatsBloc>();
    final userChannel = chatsBloc.state.client.userChannel;
    if (userChannel == null || userChannel.state != PhoenixChannelState.joined) {
      context.showErrorSnackBar(context.l10n.chats_GroupBuilderScreen_connectionError);
      return;
    }

    try {
      setState(() => busy = true);
      final payload = {
        'name': nameController.text,
        'member_ids': selectedUsers.map((contact) => contact.sourceId).toList(),
      };
      final result = await userChannel.push('chat:create_group', payload).future;

      if (!mounted) return;
      if (result.isOk) Navigator.of(context).pop();
      if (result.isError) throw Exception(result.response.toString());
    } catch (_) {
      context.showErrorSnackBar(context.l10n.chats_GroupBuilderScreen_submitError);
    } finally {
      setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.chats_GroupBuilderScreen_screenTitle)),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          avatar(),
                          const SizedBox(height: 16),
                          Text(context.l10n.chats_GroupBuilderScreen_groupNameHeadline),
                          const SizedBox(height: 8),
                          nameField(),
                          const SizedBox(height: 16),
                          Text(context.l10n.chats_GroupBuilderScreen_membersHeadline),
                          const SizedBox(height: 8),
                          ...membersList(),
                          const SizedBox(height: 8),
                          Row(children: [
                            TextButton(
                              onPressed: onAddUser,
                              child: Text(context.l10n.chats_GroupBuilderScreen_addUserBtnText),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: isValid ? onSubmit : null,
                    child: Text(context.l10n.chats_GroupBuilderScreen_submitBtnText),
                  ),
                ],
              ),
            ),
          ),
          if (busy)
            Container(
              color: Colors.black.withOpacity(0.1),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }

  Iterable<Widget> membersList() {
    return selectedUsers.map((contact) {
      return ContactTile(
        displayName: contact.name,
        thumbnail: contact.thumbnail,
        registered: contact.registered,
      );
    });
  }

  Widget nameField() {
    return TextFormField(
      controller: nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(labelText: context.l10n.chats_GroupBuilderScreen_nameFieldLabel),
      validator: (value) {
        if (value == null || value.isEmpty) return context.l10n.chats_GroupBuilderScreen_nameFieldEmpty;
        if (value.length < 3) return context.l10n.chats_GroupBuilderScreen_nameFieldShort;
        return null;
      },
      onChanged: (value) => setState(() {}),
    );
  }

  Widget avatar() {
    String text = nameController.text;

    text = text.split(' ').first;

    if (text.length > 8) text = text.substring(text.length - 8);
    return CircleAvatar(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text.toUpperCase(),
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
