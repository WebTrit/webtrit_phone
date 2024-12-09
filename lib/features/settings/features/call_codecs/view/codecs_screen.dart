import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/media_codecs.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call_codecs.dart';

class CallCodecsScreen extends StatelessWidget {
  const CallCodecsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings_ListViewTileTitle_call_codecs),
        leading: const ExtBackButton(),
      ),
      body: BlocBuilder<CallCodecsCubit, CallCodecsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.settings_call_codecs_preferred_audio_title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tooltip(
                      message: context.l10n.settings_call_codecs_preferred_audio_tip,
                      triggerMode: TooltipTriggerMode.tap,
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.all(8.0),
                      showDuration: const Duration(seconds: 10),
                      child: const Icon(Icons.info_outline),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                ListTile(
                  selected: null == state.audioCodec,
                  title: Text(context.l10n.settings_call_codecs_preferred_audio_default),
                  onTap: () => context.read<CallCodecsCubit>().setAudioCodec(null),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  leading: const Icon(Icons.multitrack_audio),
                ),
                for (final audioCodec in AudioCodec.values)
                  ListTile(
                    selected: audioCodec == state.audioCodec,
                    title: Text(audioCodec.name),
                    onTap: () => context.read<CallCodecsCubit>().setAudioCodec(audioCodec),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    leading: const Icon(Icons.multitrack_audio),
                  ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.settings_call_codecs_preferred_video_title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tooltip(
                      message: context.l10n.settings_call_codecs_preferred_video_tip,
                      triggerMode: TooltipTriggerMode.tap,
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.all(8.0),
                      showDuration: const Duration(seconds: 10),
                      child: const Icon(Icons.info_outline),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                ListTile(
                  selected: null == state.videoCodec,
                  title: Text(context.l10n.settings_call_codecs_preferred_video_default),
                  onTap: () => context.read<CallCodecsCubit>().setVideoCodec(null),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  leading: const Icon(Icons.missed_video_call_outlined),
                ),
                for (final videoCodec in VideoCodec.values)
                  ListTile(
                    selected: videoCodec == state.videoCodec,
                    title: Text(videoCodec.name),
                    onTap: () => context.read<CallCodecsCubit>().setVideoCodec(videoCodec),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    leading: const Icon(Icons.missed_video_call_outlined),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
