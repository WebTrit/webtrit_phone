import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/messaging/widgets/group_avatar.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/leading_avatar.dart';

import '../../chat_conversation_builder.dart';

class GroupFillInfoView extends StatefulWidget {
  const GroupFillInfoView(this.state, {super.key});

  final ChatCBGroupFillInfo state;

  @override
  State<GroupFillInfoView> createState() => _GroupFillInfoViewState();
}

class _GroupFillInfoViewState extends State<GroupFillInfoView> {
  late final builderCubit = context.read<ChatConversationBuilderCubit>();
  late final groupInfoFormKey = GlobalKey<FormState>();
  late final groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: groupInfoFormKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    GroupAvatar(name: groupNameController.text, size: 50),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: groupNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: context.l10n.messaging_ConversationBuilders_nameFieldLabel,
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
                          return context.l10n.messaging_ConversationBuilders_nameFieldEmpty;
                        }
                        if (value.length < 3) {
                          return context.l10n.messaging_ConversationBuilders_nameFieldShort;
                        }
                        return null;
                      },
                      onChanged: (value) => builderCubit.onGroupNameChange(value),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        context.l10n.messaging_ConversationBuilders_membersHeadline,
                        textAlign: TextAlign.left,
                        style: TextStyle(color: colorScheme.secondary.withOpacity(0.7), fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...widget.state.selectedContacts.map(
                      (contact) => ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                        leading: LeadingAvatar(
                          username: contact.name,
                          thumbnail: contact.thumbnail,
                          thumbnailUrl: contact.thumbnailUrl,
                          registered: contact.registered,
                          radius: 24,
                        ),
                        title: Text(contact.name ?? contact.mobileNumber ?? contact.sourceId.toString()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
