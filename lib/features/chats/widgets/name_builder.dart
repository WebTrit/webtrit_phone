import 'package:flutter/material.dart';

class NameBuilder extends StatelessWidget {
  const NameBuilder({
    super.key,
    required this.senderId,
    required this.userId,
  });

  final String senderId;
  final String userId;

  bool get isMine => senderId == userId;

  @override
  Widget build(BuildContext context) {
    return Text(
      isMine ? 'You' : senderId,
      style: TextStyle(color: Colors.lightBlue.shade200, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}

// TODO: load contact name from contacts
