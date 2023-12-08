import 'package:flutter/material.dart';

class ContactEmailTile extends StatelessWidget {
  const ContactEmailTile({
    super.key,
    required this.address,
    required this.label,
    this.onTap,
    this.onLongPress,
    this.onEmailPressed,
  });

  final String address;
  final String label;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final VoidCallback? onEmailPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16.0),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashRadius: 24,
            icon: const Icon(Icons.email),
            onPressed: onEmailPressed,
          ),
        ],
      ),
      title: Text(address),
      subtitle: label.isEmpty ? null : Text(label),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
