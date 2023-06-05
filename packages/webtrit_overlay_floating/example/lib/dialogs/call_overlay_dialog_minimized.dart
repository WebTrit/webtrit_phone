import 'package:flutter/material.dart';

import 'package:gravatar_utils/gravatar_utils.dart';

class CallOverlayDialogMinimized extends StatefulWidget {
  const CallOverlayDialogMinimized({
    super.key,
    required this.createdTime,
    required this.name,
    required this.isVideoCall,
    required this.onEndCall,
  });

  final DateTime createdTime;
  final String name;
  final bool isVideoCall;
  final Function onEndCall;

  @override
  State<CallOverlayDialogMinimized> createState() => _CallOverlayDialogState();
}

class _CallOverlayDialogState extends State<CallOverlayDialogMinimized> {
  @override
  Widget build(BuildContext context) {
    final gravatar = Gravatar("example@gmail.com");

    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            CircleAvatar(
              maxRadius: 16,
              foregroundImage: Image.network(gravatar.image(scheme: 'https').toString()).image,
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "EL",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            const Spacer(),
            Text(
              "00:50",
              style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10),
            ),
            const Divider(),
            const Icon(
              Icons.phone,
              color: Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
