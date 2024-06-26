import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final nameformKey = GlobalKey<FormState>();
  final userNumberformKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final userMainNumberController = TextEditingController();
  Set<String> selectedUsers = {};
  bool busy = false;

  void onAddMember() {
    if (userNumberformKey.currentState!.validate()) {
      setState(() {
        selectedUsers.add(userMainNumberController.text);
        userMainNumberController.clear();
      });
    }
  }

  void onRemoveMember(String user) {
    setState(() => selectedUsers.remove(user));
  }

  Future<void> onSubmit() async {
    if (nameformKey.currentState!.validate()) {
      final chatsBloc = context.read<ChatsBloc>();
      final userChannel = chatsBloc.state.client.userChannel;
      if (userChannel == null) {
        context.showErrorSnackBar('Connection error, please try later');
        return;
      }
      setState(() => busy = true);
      try {
        final payload = {
          'name': nameController.text,
          'member_ids': selectedUsers.toList(),
        };
        final result = await userChannel.push('chat:create_group', payload).future;

        if (!mounted) return;
        setState(() => busy = false);

        if (result.isOk) Navigator.of(context).pop();
        if (result.isError) throw Exception(result.response.toString());
      } catch (_) {
        context.showErrorSnackBar('Error happened while creating group, please try again');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New group form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const Text('Group name'),
                    const SizedBox(height: 8),
                    Form(key: nameformKey, child: nameField()),
                    const SizedBox(height: 16),
                    const Text('Invite members'),
                    const SizedBox(height: 8),
                    ...membersList(),
                    const SizedBox(height: 8),
                    Form(key: userNumberformKey, child: memberField()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: onSubmit, child: const Text('Submit'))
          ],
        ),
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

  Widget memberField() {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a user main number';
            }

            if (value.length < 6) {
              return 'User main number must be at least 6 characters';
            }
            return null;
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.phone,
          controller: userMainNumberController,
          decoration: const InputDecoration(labelText: 'User main number'),
        ),
        Row(children: [TextButton(onPressed: onAddMember, child: const Text('Add'))])
      ],
    );
  }

  Widget nameField() {
    return TextFormField(
      controller: nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(labelText: 'Group Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a group name';
        }
        if (value.length < 3) {
          return 'Group name must be at least 3 characters';
        }
        return null;
      },
    );
  }
}
