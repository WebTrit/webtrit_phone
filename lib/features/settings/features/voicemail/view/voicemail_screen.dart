import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/models/models.dart';

import '../bloc/voicemail_cubit.dart';

class VoicemailScreen extends StatelessWidget {
  const VoicemailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoicemailCubit, VoicemailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Voicemail')),
          body: _buildList(state.items),
        );
      },
    );
  }

  Widget _buildList(List<UserVoicemailItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('No voicemails'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text('Voicemail from ${item.id}'),
          subtitle: Text('${item.date} • ${item.duration.toStringAsFixed(1)} sec'),
          trailing: Icon(item.seen ? Icons.mark_email_read : Icons.mark_email_unread),
          onTap: () {
            // TODO: show details or play
          },
        );
      },
    );
  }
}
