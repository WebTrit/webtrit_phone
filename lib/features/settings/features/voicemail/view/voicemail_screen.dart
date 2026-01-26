import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/models/voicemail/user_voicemail.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/voicemail_cubit.dart';
import '../widgets/widgets.dart';

class VoicemailScreen extends StatefulWidget {
  const VoicemailScreen({super.key});

  @override
  State<VoicemailScreen> createState() => _VoicemailScreenState();
}

class _VoicemailScreenState extends State<VoicemailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoicemailCubit, VoicemailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.voicemail_Widget_screenTitle),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: state.items.isNotEmpty
                    ? state.isMultipleVoicemailsSelection
                          ? () => _onDeleteSelectedVoicemails()
                          : () => _onDeleteAllVoicemails()
                    : null,
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
                return FailureRetryView(errorNotification: state.error!, onRetry: _onRetryFetch);
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

  void _onRetryFetch() {
    context.read<VoicemailCubit>().fetchVoicemails();
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
