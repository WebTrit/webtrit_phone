import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/features.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key, this.title});
  final Widget? title;

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.title),
      body: BlocBuilder<ChatListCubit, ChatListState>(builder: (context, state) {
        if (state.initialising == false) {
          return ChatsList(chatlist: state.chats);
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
