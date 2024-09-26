import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    required this.controller,
    required this.onSend,
    super.key,
  });

  final TextEditingController controller;
  final Function() onSend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              onFieldSubmitted: (_) => onSend(),
              onChanged: (_) {},
              decoration: InputDecoration(
                hintText: context.l10n.messaging_MessageField_hint,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                isDense: true,
                isCollapsed: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            child: Icon(Icons.send, size: 24, color: colorScheme.secondary),
            onTap: () => onSend(),
          ),
        ],
      ),
    );
  }
}
