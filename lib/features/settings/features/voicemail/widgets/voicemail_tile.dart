import 'package:flutter/material.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/audio_view.dart';

class VoicemailTile extends StatelessWidget {
  const VoicemailTile({
    super.key,
    required this.voicemail,
    this.onDeleted,
    this.onTap,
  });

  final Voicemail voicemail;
  final VoidCallback? onTap;
  final void Function(Voicemail)? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(voicemail.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Voicemail?'),
            content: Text('Are you sure you want to delete voicemail from ${voicemail.sender}?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
            ],
          ),
        );
      },
      onDismissed: onDeleted == null ? null : (_) => onDeleted!(voicemail),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('Voicemail from ${voicemail.sender}'),
            subtitle: Text('${voicemail.date} • ${voicemail.duration.toStringAsFixed(1)} sec'),
            onTap: onTap,
          ),
          // AudioView(voicemail.attachments.first),
        ],
      ),
    );
  }
}
