import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart' hide ConfirmDialog;

class DialogInfo extends StatefulWidget {
  const DialogInfo(this.userId, this.participantId, {super.key});

  final String userId;
  final String participantId;

  @override
  State<DialogInfo> createState() => _DialogInfoState();
}

class _DialogInfoState extends State<DialogInfo> {
  late final conversationCubit = context.read<ConversationCubit>();

  onDeleteDialog() async {
    final askResult = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(askText: context.l10n.messaging_DialogInfo_deleteAsk),
    );

    if (!mounted) return;
    if (askResult != true) return;

    final result = await conversationCubit.deleteChat();

    if (!mounted) return;
    if (result != true) return;
    context.router.navigate(const MainScreenPageRoute(children: [ConversationsScreenPageRoute()]));
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
                    sourceId: participant,
                    sourceType: ContactSourceType.external,
                    builder: (context, contact, {required loading}) {
                      if (loading) return const SizedBox();

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
                              radius: 50,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              contact?.displayTitle ?? participant,
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
                            Expanded(
                                child: ListView(
                              children: [
                                for (ContactPhone contactPhone in contact?.phones ?? [])
                                  ListTile(
                                    title: Text(contactPhone.number),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          splashRadius: 24,
                                          icon: const Icon(Icons.call),
                                          onPressed: () {
                                            final callBloc = context.read<CallBloc>();
                                            callBloc.add(CallControlEvent.started(
                                              number: contactPhone.number,
                                              displayName: contact?.maybeName,
                                              video: false,
                                            ));
                                            context.router.maybePop();
                                          },
                                        ),
                                        IconButton(
                                          splashRadius: 24,
                                          icon: const Icon(Icons.videocam),
                                          onPressed: () {
                                            final callBloc = context.read<CallBloc>();
                                            callBloc.add(CallControlEvent.started(
                                              number: contactPhone.number,
                                              displayName: contact?.maybeName,
                                              video: true,
                                            ));
                                            context.router.maybePop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                for (ContactEmail contactEmail in contact?.emails ?? [])
                                  ListTile(
                                    title: Text(contactEmail.address),
                                    trailing: IconButton(
                                      splashRadius: 24,
                                      icon: const Icon(Icons.email),
                                      onPressed: () {},
                                    ),
                                  ),
                              ],
                            )),
                            const SizedBox(height: 8),
                          ],
                        ),
                      );
                    }),
              ),
              if (state.busy)
                Container(
                  color: Colors.black.withOpacity(0.1),
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
}
