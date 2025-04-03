import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({
    required this.controller,
    required this.onSend,
    this.onChanged,
    this.onAddAttachment,
    super.key,
  });

  final TextEditingController controller;
  final void Function() onSend;
  final void Function(String)? onChanged;
  final void Function()? onAddAttachment;

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: theme.scaffoldBackgroundColor.withAlpha(100),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
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
                        fillColor: colorScheme.surface,
                        hintText: context.l10n.messaging_MessageField_hint,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0, maxWidth: 40, maxHeight: 40),
                        isDense: false,
                        isCollapsed: false,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffixIcon: widget.onAddAttachment != null
                            ? IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.attach_file, size: 16),
                                onPressed: () {
                                  widget.onAddAttachment?.call();
                                },
                              )
                            : null,
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
          ),
        ),
      ),
    );
  }
}
