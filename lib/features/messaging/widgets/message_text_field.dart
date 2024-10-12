import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({
    required this.controller,
    required this.onSend,
    this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final Function() onSend;
  final void Function(String)? onChanged;

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  String value = '';

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
              controller: widget.controller,
              onFieldSubmitted: (_) {
                if (value.isNotEmpty) widget.onSend();
              },
              onChanged: (v) {
                setState(() => value = v);
                widget.onChanged?.call(v);
              },
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
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 600),
            sizeCurve: Curves.elasticOut,
            firstChild: const SizedBox(width: 8, height: 8),
            secondChild: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.send, size: 24, color: colorScheme.primary),
              ),
              onTap: () {
                if (value.isNotEmpty) widget.onSend();
              },
            ),
            crossFadeState: value.isNotEmpty ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}
