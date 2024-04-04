import 'package:flutter/material.dart';

class ReloginDialog extends StatelessWidget {
  const ReloginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Relogin Confirmation'),
      content: Text('Do you want to replace the current session with a new one?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
      ],
    );
  }
}

// TODO: localize, use styles
