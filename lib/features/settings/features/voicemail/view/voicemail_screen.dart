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

enum _VoicemailMenuAction { transcriptionModel, cacheManagement }

class VoicemailScreen extends StatefulWidget {
  const VoicemailScreen({super.key});

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
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.voicemail_Widget_screenTitle),
            actions: [
              Badge(
                alignment: AlignmentDirectional.topCenter,
                isLabelVisible: state.isMultipleVoicemailsSelection,
                label: Text(state.selectedVoicemailsIds.length.toString()),
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: state.items.isNotEmpty
                      ? () => state.isMultipleVoicemailsSelection
                            ? _onDeleteSelectedVoicemails()
                            : _onDeleteAllVoicemails()
                      : null,
                ),
              ),
              if (context.read<VoicemailCubit>().canSelectTranscriptionModel ||
                  context.read<AppCacheManager>().sections.isNotEmpty)
                PopupMenuButton<_VoicemailMenuAction>(
                  onSelected: _onMenuAction,
                  itemBuilder: (context) => [
                    if (context.read<VoicemailCubit>().canSelectTranscriptionModel)
                      PopupMenuItem(
                        value: _VoicemailMenuAction.transcriptionModel,
                        child: ListTile(
                          leading: const Icon(Icons.tune),
                          title: Text(context.l10n.voicemail_TranscriptionModel_title),
                        ),
                      ),
                    if (context.read<AppCacheManager>().sections.isNotEmpty)
                      PopupMenuItem(
                        value: _VoicemailMenuAction.cacheManagement,
                        child: ListTile(
                          leading: const Icon(Icons.storage),
                          title: Text(context.l10n.cacheManagement_Widget_screenTitle),
                        ),
                      ),
                  ],
                ),
            ],
          ),
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

  void _onMenuAction(_VoicemailMenuAction action) {
    switch (action) {
      case _VoicemailMenuAction.transcriptionModel:
        _onSelectTranscriptionModel();
      case _VoicemailMenuAction.cacheManagement:
        _onOpenCacheManagement();
    }
  }

  /// Clearing the voicemail cache deletes files the player may hold open, so
  /// playback stops before the cache management screen opens on top.
  void _onOpenCacheManagement() {
    unawaited(context.read<VoicemailPlaybackController>().stop());
    context.router.navigate(const CacheManagementScreenPageRoute());
  }

  void _onSelectTranscriptionModel() {
    final cubit = context.read<VoicemailCubit>();

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) => TranscriptionModelSheet(
        defaultModel: cubit.defaultTranscriptionModel,
        selectedModel: cubit.selectedTranscriptionModel,
        onSelected: (model) => cubit.setTranscriptionModel(model),
      ),
    );
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
  });

  final List<Voicemail> items;
  final List<String> selectedVoicemailsIds;
  final bool isMultipleVoicemailsSelection;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VoicemailCubit>();
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
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
