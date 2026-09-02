import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/models/voicemail/user_voicemail.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/bloc.dart';
import 'empty_mailbox_view.dart';
import 'failure_retry_view.dart';
import 'feature_not_supported_view.dart';
import 'voicemail_tile.dart';

/// The list of voicemails and everything it shows in place of one: the feature
/// being unavailable, the first load, an empty mailbox, a failed fetch.
///
/// Only the body, so a screen can put whatever header it belongs under above
/// it - the settings sub-screen its own, a section of the bottom menu the bar
/// every section carries.
class VoicemailBody extends StatelessWidget {
  const VoicemailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoicemailCubit, VoicemailState>(
      listenWhen: (previous, current) => previous.items != current.items,
      listener: _stopPlaybackOfRemovedVoicemail,
      builder: (context, state) {
        if (state.isFeatureNotSupported) {
          return const FeatureNotSupportedView();
        }
        if (state.isInitializing) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }
        if (state.isLoadedWithError) {
          return FailureRetryView(onRetry: () => context.read<VoicemailCubit>().fetchVoicemails());
        }

        return RefreshIndicator(
          // The bottom-menu section runs its body behind the bar, so without an
          // offset the spinner settles a bar's height out of sight and the pull
          // looks like it did nothing. A host that keeps its body below an app
          // bar hands this a top padding of zero, so the one figure serves both.
          edgeOffset: MediaQuery.of(context).padding.top,
          onRefresh: () => context.read<VoicemailCubit>().fetchVoicemails(),
          child: Stack(
            children: [
              if (state.isRefreshing) const LinearProgressIndicator(minHeight: 1),
              if (state.isVoicemailsExists)
                VoicemailListView(
                  items: state.items,
                  selectedVoicemailsIds: state.selectedVoicemailsIds,
                  isMultipleVoicemailsSelection: state.isMultipleVoicemailsSelection,
                )
              else
                const EmptyMailboxView(),
            ],
          ),
        );
      },
    );
  }

  // The player is screen-scoped and not owned by the tiles, so when the active
  // voicemail leaves the list (deleted on this device or remotely) nothing else
  // stops the audio.
  void _stopPlaybackOfRemovedVoicemail(BuildContext context, VoicemailState state) {
    final controller = context.read<VoicemailPlaybackController>();
    final activeId = controller.activeId;
    if (activeId != null && !state.items.any((it) => it.id == activeId)) {
      unawaited(controller.stop());
    }
  }
}

class VoicemailListView extends StatelessWidget {
  const VoicemailListView({
    super.key,
    required this.items,
    required this.selectedVoicemailsIds,
    required this.isMultipleVoicemailsSelection,
  });

  final List<Voicemail> items;
  final List<String> selectedVoicemailsIds;
  final bool isMultipleVoicemailsSelection;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VoicemailCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      // A mailbox with a message or two has nothing to scroll, and a list that
      // cannot scroll swallows the drag instead of passing it to the refresh
      // indicator above it.
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) => Divider(color: colorScheme.surfaceContainerHigh, height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return VoicemailTile(
          voicemail: item,
          displayName: item.displaySender,
          selected: selectedVoicemailsIds.contains(item.id),
          onDeleted: (it) => _onDeleteVoicemail(context, it),
          onToggleSeenStatus: (it) => cubit.toggleSeenStatus(it),
          onCall: (it) => cubit.startCall(it),
          onLongPress: (it) => cubit.saveSelectedVoicemail(it),
          onTap: isMultipleVoicemailsSelection ? (it) => cubit.saveSelectedVoicemail(it) : null,
        );
      },
    );
  }

  void _onDeleteVoicemail(BuildContext context, Voicemail voicemail) async {
    final cubit = context.read<VoicemailCubit>();

    final confirmed =
        (await ConfirmDialog.showDangerous(
          context,
          title: context.l10n.voicemail_Dialog_deleteSingleTitle,
          content: context.l10n.voicemail_Dialog_deleteSingleContent,
        )) ??
        false;

    if (confirmed) {
      cubit.removeVoicemail(voicemail.id.toString());
    }
  }
}
