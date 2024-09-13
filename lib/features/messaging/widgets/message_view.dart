import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:quiver/collection.dart';

import 'package:webtrit_phone/extensions/datetime.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    super.key,
    required this.userId,
    required this.message,
    required this.handleSetForReply,
    required this.handleSetForForward,
    required this.handleSetForEdit,
    required this.handleDelete,
  });

  final String userId;
  final types.TextMessage message;

  final Function(ChatMessage refMessage) handleSetForReply;
  final Function(ChatMessage refMessage) handleSetForForward;
  final Function(ChatMessage refMessage) handleSetForEdit;
  final Function(ChatMessage refMessage) handleDelete;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  late final chatsRepository = context.read<ChatsRepository>();
  late final client = context.read<MessagingBloc>().state.client;

  Future<ChatMessage?> fetchMessage(int msgId, int chatId) async {
    final msg = await chatsRepository.getMessageById(msgId);
    if (msg != null) return msg;

    final channel = client.getChatChannel(chatId);
    if (channel == null) return null;

    final req = await channel.push('message:get:$msgId', {}).future;
    if (req.isOk) {
      final msg = ChatMessage.fromMap(req.response);
      await chatsRepository.upsertMessage(msg, silent: true);
      return msg;
    }

    return null;
  }

  RelativeRect getPosition(bool isMine) {
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    late Offset offset = Offset(isMine ? -48 : 48, 16);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final uiMessage = widget.message;
    final chatMessage = widget.message.chatMessage;

    final isEdited = uiMessage.isEdited;
    final isDeleted = uiMessage.isDeleted;
    final isSended = chatMessage?.id != null;
    final isMine = chatMessage == null || chatMessage.senderId == widget.userId;
    final isForward = chatMessage?.forwardFromId != null && chatMessage?.authorId != null;
    final isReply = chatMessage?.replyToId != null;

    final senderId = chatMessage?.senderId ?? widget.userId;
    final hasContent = (chatMessage?.content.isNotEmpty == true) && chatMessage?.content != '-';

    final popupItems = [
      if (hasContent)
        PopupMenuItem(
          onTap: () => Clipboard.setData(ClipboardData(text: chatMessage!.content)),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_textcopy),
            leading: const Icon(Icons.copy_rounded),
            dense: true,
          ),
        ),
      if (isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForReply(chatMessage!),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_reply),
            leading: const Icon(Icons.question_answer_outlined),
            dense: true,
          ),
        ),
      if (isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForForward(chatMessage!),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_forward),
            leading: const Icon(Icons.forward_outlined),
            dense: true,
          ),
        ),
      if (isMine && isSended && !isForward && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForEdit(chatMessage!),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_edit),
            leading: const Icon(Icons.edit_note_outlined),
            dense: true,
          ),
        ),
      if (isMine && isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleDelete(chatMessage!),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_delete),
            leading: const Icon(Icons.remove),
            dense: true,
          ),
        ),
    ];

    return GestureDetector(
      onLongPress: () async {
        // Dismiss keyboard if it's open and wait for it to close before showing the popup
        // to keep the popup in the right position
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
          await Future.delayed(const Duration(milliseconds: 400));
          if (!mounted) return;
        }

        // Check if has any items to show
        if (popupItems.isEmpty) return;

        final position = getPosition(isMine);
        showMenu(context: this.context, position: position, items: popupItems);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        // 0.01 is for background press recognition
        color: Colors.blueGrey.withOpacity(0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ParticipantName(senderId: senderId, userId: widget.userId, key: Key(senderId)),
            const SizedBox(height: 4),
            if (isReply) ...[
              replyQuote(chatMessage!),
              const SizedBox(height: 8),
            ],
            if (isForward) ...[
              forwardQuote(chatMessage!),
            ],
            if (!isForward && !isDeleted) ...[
              MessageBody(text: chatMessage?.content ?? uiMessage.text),
            ],
            if (isEdited && !isDeleted) ...[
              Text(context.l10n.chats_MessageView_edited, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (isDeleted) ...[
              Text(context.l10n.chats_MessageView_deleted, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
            if (chatMessage?.createdAt != null) ...[
              const SizedBox(height: 4),
              Text(chatMessage!.createdAt.toHHmm, style: TextStyle(color: colorScheme.secondaryFixed, fontSize: 10))
            ],
          ],
        ),
      ),
    );
  }

  Widget replyQuote(ChatMessage chatMessage) {
    final colorScheme = Theme.of(context).colorScheme;
    return FutureBuilder(
        future: fetchMessage(chatMessage.replyToId!, chatMessage.chatId),
        builder: (context, snapshot) {
          final msg = snapshot.data;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 0, blurRadius: 16)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (msg != null)
                      ParticipantName(senderId: msg.senderId, userId: widget.userId, key: Key(msg.senderId))
                    else
                      Text('loading...', style: TextStyle(color: colorScheme.secondaryFixed, fontSize: 14)),
                    const SizedBox(width: 8),
                    Icon(Icons.reply_outlined, color: colorScheme.secondaryFixed, size: 14),
                  ],
                ),
                const SizedBox(height: 4),
                MessageBody(text: msg?.content ?? 'loading...'),
              ],
            ),
          );
        });
  }

  Widget forwardQuote(ChatMessage msg) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 0, blurRadius: 16)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: ParticipantName(senderId: msg.authorId!, userId: widget.userId, key: Key(msg.authorId!))),
              const SizedBox(width: 8),
              Icon(Icons.forward_outlined, color: colorScheme.secondaryFixed, size: 14),
            ],
          ),
          const SizedBox(height: 4),
          MessageBody(text: msg.content),
        ],
      ),
    );
  }
}

class MessageBody extends StatefulWidget {
  const MessageBody({
    super.key,
    required this.text,
    this.style = const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      decorationColor: Colors.white,
    ),
  });

  final String text;
  final TextStyle style;

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  String? link;
  types.PreviewData? linkPreview;
  static final previewsCache = LruMap<String, types.PreviewData>(maximumSize: 100);

  @override
  void initState() {
    super.initState();
    findLink(widget.text);
  }

  @override
  void didUpdateWidget(covariant MessageBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) findLink(widget.text);
  }

  findLink(String text) {
    final regex = RegExp(regexLink, caseSensitive: false);
    final match = regex.stringMatch(text);
    linkPreview = previewsCache[match];
    if (mounted) setState(() => link = match);
  }

  setLinkPreview(data) {
    if (link != null) previewsCache[link!] = data;
    if (mounted) setState(() => linkPreview = data);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (link != null) ...[
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.25),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 0, blurRadius: 16)],
            ),
            padding: const EdgeInsets.all(8),
            // margin: const EdgeInsets.symmetric(vertical: 8),
            child: LayoutBuilder(builder: (context, constrains) {
              return LinkPreview(
                textStyle: widget.style,
                linkStyle: widget.style,
                headerStyle: widget.style,
                metadataTextStyle: widget.style,
                metadataTitleStyle: widget.style,
                enableAnimation: true,
                onPreviewDataFetched: setLinkPreview,
                previewData: linkPreview,
                text: link!,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(0),
              );
            }),
          ),
          const SizedBox(height: 8),
        ],
        ParsedText(
          parse: [
            mailToMatcher(
              style: widget.style.copyWith(decoration: TextDecoration.underline),
            ),
            urlMatcher(
              style: widget.style.copyWith(decoration: TextDecoration.underline),
            ),
            boldMatcher(
              style: widget.style.merge(PatternStyle.bold.textStyle),
            ),
            italicMatcher(
              style: widget.style.merge(PatternStyle.italic.textStyle),
            ),
            lineThroughMatcher(
              style: widget.style.merge(PatternStyle.lineThrough.textStyle),
            ),
            codeMatcher(
              style: widget.style.merge(PatternStyle.code.textStyle),
            ),
          ],
          regexOptions: const RegexOptions(multiLine: true, dotAll: true),
          style: widget.style.copyWith(fontFamily: theme.textTheme.bodyMedium?.fontFamily),
          text: widget.text,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
      ],
    );
  }
}
