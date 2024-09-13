import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key, this.title});
  final Widget? title;

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  late final contactsRepository = context.read<ContactsRepository>();

  showBottomSheet() async {
    final result = await showModalBottomSheet(
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) => NewConversationPage(
            contactsRepository: contactsRepository,
            filter: (contact) {
              if (chatFeatureEnabled && !smsFetureEnabled) return contact.canMessage;
              if (!chatFeatureEnabled && smsFetureEnabled) return contact.phones.isNotEmpty;
              if (chatFeatureEnabled && smsFetureEnabled) return contact.canMessage || contact.phones.isNotEmpty;
              return false;
            }),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // If the user selected a contact, navigate to the new conversation screen
    if (result is Contact) {
      context.router.navigate(MessagingRouterPageRoute(
        children: [
          const ChatListScreenPageRoute(),
          ConversationScreenPageRoute(participantId: result.sourceId),
        ],
      ));
    }

    // If the user selected the group option, navigate to the group builder screen
    if (result == kGroupResult) {
      context.router.navigate(const MessagingRouterPageRoute(
        children: [
          ChatListScreenPageRoute(),
          GroupBuilderScreenPageRoute(),
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: MainAppBar(title: widget.title),
      body: BlocBuilder<ChatListCubit, ChatListState>(builder: (context, state) {
        if (state.initialising) return const Center(child: CircularProgressIndicator());
        return ChatsList(chatlist: state.chats, smsChatlist: state.smsChats);
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
        onPressed: showBottomSheet,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
    );
  }
}

class NewConversationPage extends StatefulWidget {
  const NewConversationPage({
    required this.contactsRepository,
    this.filter = _defaultFilter,
    super.key,
  });

  final ContactsRepository contactsRepository;
  final bool Function(Contact) filter;

  @override
  State<NewConversationPage> createState() => _NewConversationPageState();
}

class _NewConversationPageState extends State<NewConversationPage> {
  late final StreamSubscription contactsSub;
  List<Contact> contacts = [];
  String contactsSearchFilter = '';

  @override
  void initState() {
    super.initState();
    contactsSub = widget.contactsRepository.watchContacts('', ContactSourceType.external).listen((contacts) {
      setState(() => this.contacts = contacts.where(widget.filter).toList());
    });
  }

  @override
  void dispose() {
    contactsSub.cancel();
    super.dispose();
  }

  onContactConfirm(Contact contact) {
    Navigator.of(context).pop(contact);
  }

  onNewGroupConfirm() {
    Navigator.of(context).pop(kGroupResult);
  }

  onCancel() {
    Navigator.of(context).pop();
  }

  List<Contact> get contactsFiltered {
    return contactsSearchFilter.isEmpty
        ? contacts
        : contacts.where((contact) => contact.name.toLowerCase().contains(contactsSearchFilter)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Write to')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                title: Text(context.l10n.chats_ChatListScreen_createGroup),
                leading: Icon(
                  Icons.group_add_rounded,
                  color: colorScheme.onSurface.withOpacity(0.75),
                ),
                onTap: onNewGroupConfirm,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Cloud PBX contacts', style: Theme.of(context).textTheme.headlineSmall),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search contacts',
                  fillColor: colorScheme.surface,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) => setState(() => contactsSearchFilter = value.toLowerCase()),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView(
                children: contactsFiltered.map((Contact contact) {
                  return Theme(
                    data: theme.copyWith(
                      dividerColor: Colors.transparent,
                      highlightColor: colorScheme.primary.withOpacity(0.1),
                    ),
                    child: ExpansionTile(
                      leading: LeadingAvatar(
                        username: contact.name,
                        thumbnail: contact.thumbnail,
                        thumbnailUrl: contact.thumbnailUrl,
                        registered: contact.registered,
                        radius: 24,
                      ),
                      title: Text(contact.name),
                      children: [
                        if (chatFeatureEnabled)
                          ListTile(
                            title: const Text('Send in-app message'),
                            onTap: () => onContactConfirm(contact),
                          ),
                        if (smsFetureEnabled)
                          for (final phone in contact.phones)
                            ListTile(
                              title: Text('Send sms to ${phone.number}'),
                              onTap: () => {},
                            ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool _defaultFilter(Contact contact) => true;
const kGroupResult = 'new_group';
const smsFetureEnabled = EnvironmentConfig.SMS_FEATURE_ENABLE;
const chatFeatureEnabled = EnvironmentConfig.CHAT_FEATURE_ENABLE;
