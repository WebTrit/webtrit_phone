import 'package:flutter/material.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

class StateBar extends StatelessWidget {
  const StateBar({required this.status, super.key});

  final ConnectionStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String text = '';
    if (status == ConnectionStatus.initial) text = context.l10n.messaging_StateBar_initializing;
    if (status == ConnectionStatus.connecting) text = context.l10n.messaging_StateBar_connecting;
    if (status == ConnectionStatus.error) text = context.l10n.messaging_StateBar_error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 10, color: colorScheme.onSurface)),
        ],
      ),
    );
  }
}
