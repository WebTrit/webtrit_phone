import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ChatsScreen();

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
