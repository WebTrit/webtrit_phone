import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/app_localizations.g.mapper.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../bloc/bloc.dart';

/// The header's delete control: what is picked, or - where the header offers it
/// - the whole mailbox.
class VoicemailDeleteAction extends StatefulWidget {
  const VoicemailDeleteAction({super.key, required this.offersDeleteAll});

  /// Whether pressing this with nothing picked deletes every message.
  ///
  /// Emptying the mailbox belongs where the feature is managed, so a header
  /// that does not offer it shows this control only while something is picked:
  /// with nothing picked it would have nothing to do.
  final bool offersDeleteAll;

  @override
  State<VoicemailDeleteAction> createState() => _VoicemailDeleteActionState();
}

class _VoicemailDeleteActionState extends State<VoicemailDeleteAction> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoicemailCubit, VoicemailState>(
      builder: (context, state) {
        final selecting = state.isMultipleVoicemailsSelection;
        if (!widget.offersDeleteAll && !selecting) return const SizedBox.shrink();

        // The button names itself, so while selecting it says how much it would
        // delete as part of that name - a count of its own would become a
        // second, nameless stop next to it. The badge draws the number and
        // stays silent.
        return SemanticAction(
          label: selecting
              ? '${context.l10n.voicemail_Label_delete}, '
                    '${context.l10n.common_SemanticsValue_selectedCount(state.selectedVoicemailsIds.length)}'
              : context.l10n.voicemail_Label_delete,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: state.items.isNotEmpty ? () => selecting ? _onDeleteSelected() : _onDeleteAll() : null,
              ),
              if (selecting)
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
        );
      },
    );
  }

  void _onDeleteAll() async {
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

  void _onDeleteSelected() async {
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
