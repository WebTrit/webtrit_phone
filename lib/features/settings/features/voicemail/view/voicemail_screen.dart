import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/voicemail/user_voicemail.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/voicemail_cubit.dart';
import '../widgets/widgets.dart';

class VoicemailScreen extends StatelessWidget {
  const VoicemailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoicemailCubit, VoicemailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Voicemail'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: state.items.isNotEmpty ? () => _onDeleteAllVoicemails(context) : null,
              ),
            ],
          ),
          body: Stack(
            children: [
              // Show loading indicator when updating the items  available and updating item ot deleting
              if (state.status == VoicemailStatus.loading && state.items.isNotEmpty)
                const LinearProgressIndicator(minHeight: 2),
              // Show loading indicator when loading the items
              if (state.status == VoicemailStatus.loading && state.items.isEmpty)
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              // Show Placeholder when no items available
              if (state.status == VoicemailStatus.loaded && state.items.isEmpty)
                const Center(child: Text('No voicemails')),
              // Show the list of voicemails
              VoicemailListView(items: state.items, mediaHeaders: state.mediaHeaders),
            ],
          ),
        );
      },
    );
  }

  void _onDeleteAllVoicemails(BuildContext context) async {
    final confirmed = (await ConfirmDialog.showDangerous(
          context,
          title: 'Delete all voicemails?',
          content: 'This action will permanently delete all your voicemails. This cannot be undone.',
        )) ??
        false;

    if (confirmed && context.mounted) {
      context.read<VoicemailCubit>().removeAllVoicemails();
    }
  }
}

class VoicemailListView extends StatelessWidget {
  const VoicemailListView({
    super.key,
    required this.items,
    required this.mediaHeaders,
  });

  final List<Voicemail> items;
  final Map<String, String> mediaHeaders;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VoicemailCubit>();

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        return VoicemailTile(
          voicemail: item,
          mediaHeaders: mediaHeaders,
          displayName: item.displaySender,
          onDeleted: (it) => _onDeleteVoicemail(context, it),
          onToggleSeenStatus: (it) => cubit.toggleSeenStatus(it),
          onCall: (it) => cubit.startCall(it),
        );
      },
    );
  }

  void _onDeleteVoicemail(BuildContext context, Voicemail voicemail) async {
    final cubit = context.read<VoicemailCubit>();

    final confirmed = (await ConfirmDialog.showDangerous(
          context,
          title: 'Delete voicemail?',
          content: 'This voicemail will be permanently deleted. Do you want to continue?',
        )) ??
        false;

    if (confirmed) {
      cubit.deleteVoicemail(voicemail.id.toString());
    }
  }
}
