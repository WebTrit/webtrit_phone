import 'package:flutter/material.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

/// The message input with the send arrow that appears next to it.
///
/// The arrow follows what is in the field, whoever put it there: typing shows
/// it, choosing to edit a message shows it, sending takes it away.
class MessageTextField extends StatefulWidget {
  const MessageTextField({required this.controller, required this.onSend, this.onChanged, this.maxLength, super.key});

  final TextEditingController controller;
  final Function() onSend;
  final void Function(String)? onChanged;
  final int? maxLength;

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

/// Side of the send arrow, and with it the height of the whole row.
const double _sendSide = 48;

class _MessageTextFieldState extends State<MessageTextField> {
  late bool _hasMessage = _fieldHasMessage;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_syncSendArrow);
  }

  @override
  void didUpdateWidget(MessageTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_syncSendArrow);
      widget.controller.addListener(_syncSendArrow);
      _syncSendArrow();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncSendArrow);
    super.dispose();
  }

  /// Whitespace alone is nothing to send - the conversation trims it away
  /// before it goes out, so the arrow must not promise otherwise.
  bool get _fieldHasMessage => widget.controller.text.trim().isNotEmpty;

  void _syncSendArrow() {
    if (_hasMessage == _fieldHasMessage) return;
    setState(() => _hasMessage = _fieldHasMessage);
  }

  void _send() {
    if (_fieldHasMessage) widget.onSend();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ClipRRect(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: colorScheme.surface.withAlpha(200),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                maxLength: widget.maxLength,
                textInputAction: .newline,
                controller: widget.controller,
                onFieldSubmitted: (_) => _send(),
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  hintText: context.l10n.messaging_MessageField_hint,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  isDense: true,
                  isCollapsed: true,
                  counterText: '',
                  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 600),
              sizeCurve: Curves.elasticOut,
              // The empty side keeps the height of the arrow, so the bar does
              // not jump on the first letter typed and back down when the
              // message goes out - only the width changes.
              firstChild: const SizedBox(width: 8, height: _sendSide),
              secondChild: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  onPressed: _send,
                  // A bare arrow was a target of half this.
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: _sendSide, minHeight: _sendSide),
                  icon: Icon(Icons.send, size: 24, color: colorScheme.primary),
                ),
              ),
              crossFadeState: _hasMessage ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            ),
          ],
        ),
      ),
    );
  }
}
