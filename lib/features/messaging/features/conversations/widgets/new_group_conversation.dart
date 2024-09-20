// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

// TODO:
//  - extract logic to cubit
//  - handle business errors
//  - use notificationBloc

abstract class NewGroupState {
  const NewGroupState();
}

class Initializing extends NewGroupState {
  const Initializing();
}

class ContactSelection extends NewGroupState {
  const ContactSelection(
    this.contacts, {
    this.selectedContacts = const [],
    this.searchFilter = '',
  });

  final List<Contact> contacts;
  final List<Contact> selectedContacts;
  final String searchFilter;

  List<Contact> get afterFilter {
    return searchFilter.isEmpty
        ? contacts
        : contacts.where((contact) => contact.name.toLowerCase().contains(searchFilter)).toList();
  }

  ContactSelection copyWith({List<Contact>? contacts, List<Contact>? selectedContacts, String? searchFilter}) {
    return ContactSelection(contacts ?? this.contacts,
        selectedContacts: selectedContacts ?? this.selectedContacts, searchFilter: searchFilter ?? this.searchFilter);
  }
}

class FillInfo extends NewGroupState {
  const FillInfo(
    this.members, {
    this.name = '',
    this.busy = false,
  });

  final List<Contact> members;
  final String name;
  final bool busy;

  FillInfo copyWith({List<Contact>? members, String? name, bool? busy}) {
    return FillInfo(members ?? this.members, name: name ?? this.name, busy: busy ?? this.busy);
  }
}

class NewGroupConversation extends StatefulWidget {
  const NewGroupConversation({
    super.key,
    required this.contactsRepository,
    required this.messagingBloc,
  });

  final ContactsRepository contactsRepository;
  final MessagingBloc messagingBloc;

  @override
  State<NewGroupConversation> createState() => _NewGroupConversationState();
}

class _NewGroupConversationState extends State<NewGroupConversation> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  late final StreamSubscription contactsSub;

  NewGroupState state = const Initializing();

  @override
  void initState() {
    super.initState();
    contactsSub = widget.contactsRepository.watchContacts('', ContactSourceType.external).listen((contacts) {
      setState(() {
        final filtered = contacts.where((c) => c.canMessage).toList();
        state = ContactSelection(filtered);
      });
    });
  }

  @override
  void dispose() {
    contactsSub.cancel();
    super.dispose();
  }

  bool get isNameValid => formKey.currentState?.validate() == true;

  Future<void> onSubmit() async {
    if (!isNameValid) return;

    final state = this.state;
    if (state is! FillInfo) return;

    final userChannel = widget.messagingBloc.state.client.userChannel;
    if (userChannel == null || userChannel.state != PhoenixChannelState.joined) {
      context.showErrorSnackBar(context.l10n.chats_GroupBuilderScreen_connectionError);
      return;
    }

    try {
      setState(() => state.copyWith(busy: true));
      final payload = {
        'name': nameController.text,
        'member_ids': state.members.map((contact) => contact.sourceId).toList(),
      };
      final result = await userChannel.push('chat:new', payload).future;

      if (!mounted) return;
      if (result.isOk) Navigator.of(context).pop();
      if (result.isError) throw Exception(result.response.toString());
    } catch (_) {
      context.showErrorSnackBar(context.l10n.chats_GroupBuilderScreen_submitError);
    } finally {
      setState(() => state.copyWith(busy: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = this.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.chats_GroupBuilderScreen_screenTitle),
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.chats_NewConversation_cancel),
        ),
        leadingWidth: 100,
        actions: [
          if (state is ContactSelection)
            TextButton(
              onPressed: () => setState(() => this.state = FillInfo(state.selectedContacts)),
              child: Text(context.l10n.chats_NewConversation_next_action),
            ),
          if (state is FillInfo && isNameValid)
            TextButton(
              onPressed: onSubmit,
              child: Text(context.l10n.chats_NewConversation_create),
            ),
        ],
      ),
      body: Stack(
        children: [
          if (state is Initializing)
            const Positioned.fill(
              child: Center(child: CircularProgressIndicator()),
            ),
          if (state is ContactSelection)
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          context.l10n.chats_NewConversation_invite_heading,
                          style: TextStyle(color: colorScheme.secondary.withOpacity(0.7), fontSize: 16),
                        ),
                      ),
                      ...state.selectedContacts.map((contact) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorScheme.secondary.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              LeadingAvatar(
                                username: contact.name,
                                thumbnail: contact.thumbnail,
                                thumbnailUrl: contact.thumbnailUrl,
                                registered: contact.registered,
                                radius: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(contact.name, style: TextStyle(color: colorScheme.secondary, fontSize: 12)),
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        context.l10n.chats_NewConversation_externalContacts_heading,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: context.l10n.chats_NewConversation_contactSearch_hint,
                      fillColor: colorScheme.surface,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) => setState(() {
                      this.state = state.copyWith(searchFilter: value.toLowerCase());
                    }),
                  ),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: ListView(
                    children: state.afterFilter.map((Contact contact) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (state.selectedContacts.contains(contact)) {
                            this.state = state.copyWith(
                                selectedContacts: state.selectedContacts.where((c) => c != contact).toList());
                          } else {
                            this.state = state.copyWith(selectedContacts: [...state.selectedContacts, contact]);
                          }
                        }),
                        child: Row(
                          children: [
                            Checkbox(
                              value: state.selectedContacts.contains(contact),
                              shape: const CircleBorder(),
                              onChanged: (_) {},
                            ),
                            Expanded(
                              child: ListTile(
                                leading: LeadingAvatar(
                                  username: contact.name,
                                  thumbnail: contact.thumbnail,
                                  thumbnailUrl: contact.thumbnailUrl,
                                  registered: contact.registered,
                                  radius: 24,
                                ),
                                title: Text(contact.name),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          if (state is FillInfo)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            avatar(),
                            const SizedBox(height: 32),
                            nameField(),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                context.l10n.chats_GroupBuilderScreen_membersHeadline,
                                textAlign: TextAlign.left,
                                style: TextStyle(color: colorScheme.secondary.withOpacity(0.7), fontSize: 16),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...state.members.map(
                              (contact) => ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                leading: LeadingAvatar(
                                  username: contact.name,
                                  thumbnail: contact.thumbnail,
                                  thumbnailUrl: contact.thumbnailUrl,
                                  registered: contact.registered,
                                  radius: 24,
                                ),
                                title: Text(contact.name),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (state is FillInfo && state.busy)
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

  Widget nameField() {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: context.l10n.chats_GroupBuilderScreen_nameFieldLabel,
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
