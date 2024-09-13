import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class ChatFlavorOverlayView extends StatefulWidget {
  const ChatFlavorOverlayView({required this.userId, super.key});

  final String userId;
  @override
  State<ChatFlavorOverlayView> createState() => _ChatFlavorOverlayViewState();
}

class _ChatFlavorOverlayViewState extends State<ChatFlavorOverlayView> {
  late final chatsRepository = context.read<ChatsRepository>();
  StreamSubscription? updatesSub;

  int chatsWithUnreadedMessagesCount = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await loadCount();
    if (!mounted) return;
    updatesSub = chatsRepository.eventBus.debounce(const Duration(milliseconds: 100)).listen((_) => loadCount());
  }

  Future loadCount() async {
    final count = await chatsRepository.chatsWithUnreadedMessagesCountUsingReadCursors(widget.userId);
    if (mounted) setState(() => chatsWithUnreadedMessagesCount = count);
  }

  @override
  void dispose() {
    updatesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chatsWithUnreadedMessagesCount > 0) {
      return Container(
        width: 14,
        height: 14,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary, shape: BoxShape.circle),
        child: FittedBox(
          child: Text(chatsWithUnreadedMessagesCount.toString(), style: const TextStyle(color: Colors.white)),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

class ChatFlavorOverlay extends StatefulWidget {
  const ChatFlavorOverlay({required this.child, super.key});

  final Widget child;

  @override
  State<ChatFlavorOverlay> createState() => _ChatFlavorOverlayState();
}

class _ChatFlavorOverlayState extends State<ChatFlavorOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 0,
          bottom: 0,
          child: BlocBuilder<ChatsBloc, ChatsState>(
            buildWhen: (p, c) => p.userId != c.userId,
            builder: (context, state) {
              final userId = state.userId;
              if (userId != null) {
                return ChatFlavorOverlayView(userId: userId);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
