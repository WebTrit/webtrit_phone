import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    void retryPreparing() {
      context.read<ConversationCubit>().prepareConversation();
    }

    return Scaffold(
      body: BlocBuilder<ConversationCubit, ConversationState>(
        builder: (context, state) {
          if (state is CvnReady) {
            return StreamChannel(channel: state.channel, child: const ChannelView());
          }

          if (state is CvnError) {
            return NoDataPlaceholder(
              content: Text(context.l10n.chats_Conversation_failure),
              actions: [TextButton(onPressed: retryPreparing, child: Text(context.l10n.chats_ActionBtn_retry))],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
