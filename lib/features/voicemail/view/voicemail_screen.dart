import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/models/voicemail/user_voicemail.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class VoicemailScreen extends StatefulWidget {
  const VoicemailScreen({super.key, this.title});

  /// The title a host that owns the header supplies.
  ///
  /// A main-screen tab hands its own - the app name - and gets the bar every
  /// tab carries, with the controls the whole session needs. The settings
  /// sub-screen hands none: it keeps this screen's own name and the back
  /// button that leads out of it.
  final Widget? title;

  @override
  State<VoicemailScreen> createState() => _VoicemailScreenState();
}

class _VoicemailScreenState extends State<VoicemailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoicemailCubit, VoicemailState>(
      listenWhen: (previous, current) => previous.items != current.items,
      listener: _stopPlaybackOfRemovedVoicemail,
      builder: (context, state) {
        final isTab = widget.title != null;

        final actions = <Widget>[
          // Clearing the cache is a settings errand, and from the settings
          // sub-screen it is one step away. Offered from a main-screen tab the
          // same button would throw the user across into the settings branch,
          // so the tab does without it - the screen it opens is still reachable
          // from settings, where it belongs.
          if (!isTab && context.read<AppCacheManager>().sections.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.storage),
              tooltip: context.l10n.cacheManagement_Widget_screenTitle,
              onPressed: _onOpenCacheManagement,
            ),
          // The button names itself, so in selection mode it says how much
          // it would delete as part of that name - a count of its own would
          // become a second, nameless stop next to it. The badge draws the
          // number and stays silent.
          SemanticAction(
            label: state.isMultipleVoicemailsSelection
                ? '${context.l10n.voicemail_Label_delete}, '
                      '${context.l10n.common_SemanticsValue_selectedCount(state.selectedVoicemailsIds.length)}'
                : context.l10n.voicemail_Label_delete,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: state.items.isNotEmpty
                      ? () => state.isMultipleVoicemailsSelection
                            ? _onDeleteSelectedVoicemails()
                            : _onDeleteAllVoicemails()
                      : null,
                ),
                if (state.isMultipleVoicemailsSelection)
                  CountBadge(
                    count: state.selectedVoicemailsIds.length,
                    size: 16,
                    // The count belongs to a destructive action, not to the
                    // accent every other badge carries.
                    color: Theme.of(context).colorScheme.error,
                    onColor: Theme.of(context).colorScheme.onError,
                  ),
              ],
            ),
          ),
        ];

        return Scaffold(
          appBar: isTab
              ? MainAppBar(title: widget.title, context: context, actions: actions)
              : AppBar(title: Text(context.l10n.voicemail_Widget_screenTitle), actions: actions),
          body: Builder(
            builder: (context) {
              // Check if the feature is not supported
              if (state.isFeatureNotSupported) {
                return const FeatureNotSupportedView();
              }
              // Check if the user is loading the list of voicemails
              if (state.isInitializing) {
                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
              }
              // Check if the user is loading the list of voicemails and there are no items available
              if (state.isLoadedWithEmptyResult) {
                return Center(child: Text(context.l10n.voicemail_Label_empty));
              }
              // Check if the user is loading the list of voicemails and there is an error
              if (state.isLoadedWithError) {
                return FailureRetryView(onRetry: _onRetryFetch);
              }
              // Check if the user is loading the list of voicemails and there are items available
              return Stack(
                children: [
                  if (state.isRefreshing) const LinearProgressIndicator(minHeight: 1),
                  if (state.isVoicemailsExists)
                    VoicemailListView(
                      items: state.items,
                      selectedVoicemailsIds: state.selectedVoicemailsIds,
                      isMultipleVoicemailsSelection: state.isMultipleVoicemailsSelection,
                      // The main screen draws its navigation bar over the tab
                      // body, so the last row needs room to clear it.
                      bottomInset: isTab ? kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom : 0,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // The player is screen-scoped and not owned by the tiles, so when the
  // active voicemail leaves the list (deleted on this device or remotely)
  // nothing else stops the audio.
  void _stopPlaybackOfRemovedVoicemail(BuildContext context, VoicemailState state) {
    final controller = context.read<VoicemailPlaybackController>();
    final activeId = controller.activeId;
    if (activeId != null && !state.items.any((it) => it.id == activeId)) {
      unawaited(controller.stop());
    }
  }

  void _onRetryFetch() {
    context.read<VoicemailCubit>().fetchVoicemails();
  }

  /// Clearing the voicemail cache deletes files the player may hold open, so
  /// playback stops before the cache management screen opens on top.
  void _onOpenCacheManagement() {
    unawaited(context.read<VoicemailPlaybackController>().stop());
    context.router.navigate(const CacheManagementScreenPageRoute());
  }

  void _onDeleteAllVoicemails() async {
    final confirmed =
        (await ConfirmDialog.showDangerous(
          context,
          title: context.l10n.voicemail_Label_deleteAll,
          content: context.l10n.voicemail_Label_deleteAllDescription,
        )) ??
        false;

    if (confirmed && mounted) {
      context.read<VoicemailCubit>().removeAllVoicemails();
    }
  }

  void _onDeleteSelectedVoicemails() async {
    final confirmed =
        (await ConfirmDialog.showDangerous(
          context,
          title: context.l10n.voicemail_Dialog_deleteSelectedTitle,
          content: context.l10n.voicemail_Dialog_deleteSelectedContent,
        )) ??
        false;

    if (confirmed && mounted) {
      context.read<VoicemailCubit>().removeSelectedVoicemails();
    }
  }
}

class VoicemailListView extends StatelessWidget {
  const VoicemailListView({
    super.key,
    required this.items,
    required this.selectedVoicemailsIds,
    required this.isMultipleVoicemailsSelection,
    this.bottomInset = 0,
  });

  final List<Voicemail> items;
  final List<String> selectedVoicemailsIds;
  final bool isMultipleVoicemailsSelection;

  /// Room left under the last row for whatever the host draws over the body.
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VoicemailCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: EdgeInsets.only(bottom: bottomInset),
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
