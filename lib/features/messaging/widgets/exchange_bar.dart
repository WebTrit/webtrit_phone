import 'package:flutter/material.dart';

class ExchangeBar extends StatelessWidget {
  const ExchangeBar({
    super.key,
    required this.text,
    required this.icon,
    required this.onCancel,
    this.onConfirm,
  });

  final String text;
  final IconData icon;
  final Function() onCancel;
  final Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
          if (onConfirm != null) ...[
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.check), onPressed: onConfirm, color: Colors.white),
          ],
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.close), onPressed: onCancel, color: Colors.white),
        ],
      ),
    );
  }
}
