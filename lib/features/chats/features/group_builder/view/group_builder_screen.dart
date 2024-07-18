import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import 'package:webtrit_phone/features/features.dart';

// TODO:
//  - extract logic to cubit
//  - handle business errors

class GroupBuilderScreen extends StatefulWidget {
  const GroupBuilderScreen({super.key});

  @override
  State<GroupBuilderScreen> createState() => _GroupBuilderScreenState();
}

class _GroupBuilderScreenState extends State<GroupBuilderScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  Set<String> selectedUsers = {};
  bool busy = false;

  bool get isValid => formKey.currentState?.validate() == true;

  onAddUser() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const AddUserDialog(),
    );

    if (result != null) {
      setState(() => selectedUsers.add(result));
    }
  }

  void onRemoveMember(String user) {
    setState(() => selectedUsers.remove(user));
  }

  Future<void> onSubmit() async {
    if (isValid) {
      final chatsBloc = context.read<ChatsBloc>();
      final userChannel = chatsBloc.state.client.userChannel;
      if (userChannel == null) {
        context.showErrorSnackBar('Connection error, please try later');
        return;
      }
      try {
        setState(() => busy = true);
        final payload = {
          'name': nameController.text,
          'member_ids': selectedUsers.toList(),
        };
        final result = await userChannel.push('chat:create_group', payload).future;

        if (!mounted) return;
        if (result.isOk) Navigator.of(context).pop();
        if (result.isError) throw Exception(result.response.toString());
      } catch (_) {
        context.showErrorSnackBar('Error happened while creating group, please try again');
      } finally {
        setState(() => busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New group form')),
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
                          const Text('Group name'),
                          const SizedBox(height: 8),
                          nameField(),
                          const SizedBox(height: 16),
                          const Text('Members'),
                          const SizedBox(height: 8),
                          ...membersList(),
                          const SizedBox(height: 8),
                          Row(children: [
                            TextButton(onPressed: onAddUser, child: const Text('Add user')),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: isValid ? onSubmit : null, child: const Text('Submit'))
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
    return selectedUsers.map((user) {
      return ListTile(
        title: Text(user),
        trailing: IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => onRemoveMember(user),
        ),
      );
    });
  }

  Widget nameField() {
    return TextFormField(
      controller: nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(labelText: 'Group Name'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter a group name';
        if (value.length < 3) return 'Group name must be at least 3 characters';
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
