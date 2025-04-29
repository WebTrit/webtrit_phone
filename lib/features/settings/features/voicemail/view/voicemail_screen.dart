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
        final cubit = context.read<VoicemailCubit>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Voicemail'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: cubit.cleanDb,
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
              VoicemailListView(items: state.items, mediaHeaders: state.mediaHeaders, cubit: cubit),
            ],
          ),
        );
      },
    );
  }
}

class VoicemailListView extends StatelessWidget {
  const VoicemailListView({
    super.key,
    required this.items,
    required this.mediaHeaders,
    required this.cubit,
  });

  final List<Voicemail> items;
  final Map<String, String> mediaHeaders;
  final VoicemailCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        return VoicemailTile(
          voicemail: item,
          mediaHeaders: mediaHeaders,
          onDeleted: (it) => cubit.deleteVoicemail(it.id.toString()),
          onToggleSeenStatus: (it) => cubit.toggleSeenStatus(it),
          displayName: item.displaySender,
          smart: false,
          onCall: (it) => cubit.startCall(it),
        );
      },
    );
  }
}
