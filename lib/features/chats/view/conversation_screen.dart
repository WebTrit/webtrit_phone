import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/features.dart';

final logger = Logger('ConversationScreen');

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    required this.participantId,
    super.key,
  });

  final String participantId;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  Channel? channel;

  @override
  void initState() {
    super.initState();
    init();
  }

  // TODO: extract all that shit
  init() async {
    final client = StreamChat.of(context).client;
    final userId = client.state.currentUser?.id;

    final ch = client.channel('messaging', extraData: {
      'members': [userId, widget.participantId],
    });

    try {
      await ch.create();
      logger.info('Channel created: ${widget.participantId}');

      if (!mounted) return;
      setState(() => channel = ch);
    } catch (e) {
      logger.info('Error creating channel: $e');

      if (!mounted) return;
      await prepareConversation(widget.participantId);
      await init();
    }
  }

  Future<void> prepareConversation(String participantId) async {
    final appBloc = context.read<AppBloc>();
    final token = appBloc.state.token;
    final tenantId = appBloc.state.tenantId!;

    final response = await http.post(
      Uri.parse('$getStreamServiceUrl/api/prepare-conversation'),
      headers: {
        'Authorization': 'Bearer $token',
        'x-tenant-id': tenantId,
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({'participantId': participantId}),
    );

    logger.info('prepareConversation: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    if (channel != null) {
      return StreamChannel(
        channel: channel!,
        child: const ChannelView(),
      );
    }

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
