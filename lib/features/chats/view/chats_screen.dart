import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key, this.title});
  final Widget? title;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.title),
      body: const Placeholder(),
    );
  }
}
