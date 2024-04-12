import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:webtrit_phone/features/chats/view/channel_view.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key, this.title});
  final Widget? title;

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late final _listController = StreamChannelListController(
    client: StreamChat.of(context).client,
    filter: Filter.in_(
      'members',
      [StreamChat.of(context).currentUser!.id],
    ),
    // sort: const [SortOption('last_message_at')],
    limit: 20,
  );

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.title),
      body: StreamChannelListView(
        controller: _listController,
        onChannelTap: (channel) {
          context.router.pushWidget(
            StreamChannel(
              channel: channel,
              child: const ChannelView(),
            ),
          );
        },
      ),
    );
  }
}
