import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart' hide ConfirmDialog;

class DialogInfo extends StatefulWidget {
  const DialogInfo(
    this.userId,
    this.participantId, {
    required this.isAudioCallEnabled,
    required this.isVideoCallEnabled,
    super.key,
  });

  final String userId;
  final String participantId;
  final bool isAudioCallEnabled;
  final bool isVideoCallEnabled;

  @override
  State<DialogInfo> createState() => _DialogInfoState();
}

class _DialogInfoState extends State<DialogInfo> {
  late final conversationCubit = context.read<ConversationCubit>();
  late final CallController _callController = CallController(
    callBloc: context.read<CallBloc>(),
    callRoutingCubit: context.read<CallRoutingCubit>(),
    notificationsBloc: context.read<NotificationsBloc>(),
  );

  Future<void> onDeleteDialog() async {
    final askResult = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: context.l10n.messaging_DialogInfo_deleteAsk),
    );

    if (!mounted) return;
    if (askResult != true) return;

    await conversationCubit.deleteChat();
  }

  void _onCall(ContactPhone phone, Contact contact, bool video) {
    _callController.createCall(destination: phone.number, displayName: contact.maybeName, video: video);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final participant = widget.participantId;

    return BlocBuilder<ConversationCubit, ConversationState>(
      builder: (context, state) {
        if (state is CVSReady) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(context.l10n.messaging_DialogInfo_title),
                  centerTitle: true,
                  actions: [
                    if (state.chat != null)
                      PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            onTap: () => onDeleteDialog(),
                            child: ListTile(
                              title: Text(context.l10n.messaging_DialogInfo_deleteBtn),
                              leading: const Icon(Icons.output_sharp),
                              dense: true,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                body: ContactInfoBuilder(
                  source: ContactSourceId(ContactSourceType.external, participant),
                  builder: (context, contact) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          LeadingAvatar(
                            username: contact?.displayTitle,
                            thumbnail: contact?.thumbnail,
                            thumbnailUrl: contact?.thumbnailUrl,
                            registered: contact?.registered,
                            presenceInfo: contact?.presenceInfo,
                            radius: 50,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            contact?.displayTitle ?? context.l10n.messaging_ParticipantName_unknown,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: theme.primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'id: ${state.credentials.chatId ?? "n/a"}',
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (contact != null && contact.kind == ContactKind.visible) ...[
                            const Divider(),
                            Expanded(
                              child: ListView(
                                children: [
                                  for (ContactPhone contactPhone in contact.phones)
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(contactPhone.number),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: _buildCallActions(contactPhone, contact),
                                      ),
                                    ),
                                  for (ContactEmail contactEmail in contact.emails)
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(contactEmail.address),
                                      trailing: IconButton(
                                        splashRadius: 24,
                                        icon: const Icon(Icons.email),
                                        onPressed: () {},
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ] else
                            const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (state.busy)
                Container(
                  color: Colors.black.withValues(alpha: 0.1),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  /// Returns a list of call action buttons based on provided configuration.
  List<Widget> _buildCallActions(ContactPhone contactPhone, Contact contact) {
    return [
      if (widget.isAudioCallEnabled)
        IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.call),
          onPressed: () => _onCall(contactPhone, contact, false),
        ),
      if (widget.isVideoCallEnabled)
        IconButton(
          splashRadius: 24,
          icon: const Icon(Icons.videocam),
          onPressed: () => _onCall(contactPhone, contact, true),
        ),
    ];
  }
}
