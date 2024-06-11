import 'package:flutter/material.dart';

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
      body: const Placeholder(),
    );
  }
}
