import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/models/models.dart';

import '../../../../../widgets/audio_view.dart';
import '../bloc/voicemail_cubit.dart';
import '../widgets/voicemail_tile.dart';

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

  Widget _buildList(List<Voicemail> items) {
    if (items.isEmpty) {
      return const Center(child: Text('No voicemails'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = items[index];
        return VoicemailTile(
          voicemail: item,
          onDeleted: (it) => context.read<VoicemailCubit>().deleteVoicemail(it.id.toString()),
        );
      },
    );
  }
}
