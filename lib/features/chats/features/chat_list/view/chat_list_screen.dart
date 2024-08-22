import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
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
  final actionButtonKey = GlobalKey();

  late final popupItems = [
    PopupMenuItem(
      child: ListTile(
        title: const Text('Start dialog'),
        leading: const Icon(Icons.person_add_alt),
        onTap: onStartDialog,
      ),
    ),
    PopupMenuItem(
      child: ListTile(
        title: const Text('Create group'),
        leading: const Icon(Icons.group_add_outlined),
        onTap: onCreateGroup,
      ),
    ),
  ];

  RelativeRect get actionButtonPosition {
    final widgetContext = actionButtonKey.currentContext!;
    final RenderBox button = widgetContext.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    late Offset offset = const Offset(0, -96);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomCenter(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  void onStartDialog() async {
    final result = await showDialog<Contact>(
      context: context,
      builder: (context) => AddContactDialog(
        contactsRepository: contactsRepository,
        filter: (contact) => contact.canMessage,
      ),
    );
    if (result == null) return;
    if (!mounted) return;

    context.router.navigate(ChatsRouterPageRoute(
      children: [
        const ChatListScreenPageRoute(),
        ConversationScreenPageRoute(participantId: result.sourceId),
      ],
    ));
  }

  void onCreateGroup() {
    context.router.navigate(const ChatsRouterPageRoute(
      children: [
        ChatListScreenPageRoute(),
        GroupBuilderScreenPageRoute(),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.title),
      body: BlocBuilder<ChatListCubit, ChatListState>(builder: (context, state) {
        if (state.initialising) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.chats.isEmpty) {
          return const Center(child: Text('No conversations started yet'));
        }
        return ChatsList(chatlist: state.chats);
      }),
      floatingActionButton: FloatingActionButton(
        key: actionButtonKey,
        onPressed: () => showMenu(context: context, position: actionButtonPosition, items: popupItems),
        child: const Icon(Icons.edit_note_outlined),
      ),
    );
  }
}
