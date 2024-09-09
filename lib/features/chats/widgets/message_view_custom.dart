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
import 'package:webtrit_phone/widgets/widgets.dart';

class MessageView extends StatefulWidget {
  const MessageView({
    super.key,
    required this.userId,
    this.chatMessage,
    this.outboxMessage,
    this.outboxEditEntry,
    this.outboxDeleteEntry,
    this.userReadedUntil,
    this.membersReadedUntil,
    required this.handleSetForReply,
    required this.handleSetForForward,
    required this.handleSetForEdit,
    required this.handleDelete,
    this.onRendered,
  });

  final String userId;
  final ChatMessage? chatMessage;
  final ChatOutboxMessageEntry? outboxMessage;
  final ChatOutboxMessageEditEntry? outboxEditEntry;
  final ChatOutboxMessageDeleteEntry? outboxDeleteEntry;

  /// Timestamp of the last message read by the user
  /// Used to display the read status of the message that user didnt see
  final DateTime? userReadedUntil;

  /// Timestamp of the last message read by the members
  /// Used to display the read status of the message sent by the user
  final DateTime? membersReadedUntil;

  /// Callback function on popup menu reply item selected
  final Function(ChatMessage refMessage) handleSetForReply;

  /// Callback function on popup menu forward item selected
  final Function(ChatMessage refMessage) handleSetForForward;

  /// Callback function on popup menu edit item selected
  final Function(ChatMessage refMessage) handleSetForEdit;

  /// Callback function on popup menu delete item selected
  final Function(ChatMessage refMessage) handleDelete;

  /// Callback function that is called when the message is mounted by flutter framework
  /// using [PostFrameCallback] to ensure that the message is rendered before calling the function
  final Function()? onRendered;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  // Key to get the position of the message body to show the popup menu
  late final bodyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Call the onRendered callback after the message is mounted by flutter framework
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onRendered?.call());
  }

  // Get the position of the message body on the screen overlay to show the popup menu
  RelativeRect getPosition(bool isMine) {
    final RenderBox renderBox = bodyKey.currentContext!.findRenderObject()! as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    late Offset offset = const Offset(0, 0);
    return RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(offset, ancestor: overlay),
        isMine
            ? renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero) + offset, ancestor: overlay)
            : renderBox.localToGlobal(renderBox.size.bottomLeft(Offset.zero) + offset, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final chatMessage = widget.chatMessage;
    final outboxMessage = widget.outboxMessage;
    final outboxEditEntry = widget.outboxEditEntry;
    final outboxDeleteEntry = widget.outboxDeleteEntry;
    final userReadedUntil = widget.userReadedUntil;
    final membersReadedUntil = widget.membersReadedUntil;

    final content = outboxEditEntry?.newContent ?? outboxMessage?.content ?? chatMessage?.content ?? '';
    final hasContent = (content.isNotEmpty == true) && content != '-';

    final senderId = chatMessage?.senderId ?? widget.userId;
    final isMine = senderId == widget.userId;
    final isSended = chatMessage != null;
    final isEdited = outboxEditEntry != null || chatMessage?.editedAt != null;
    final isDeleted = outboxDeleteEntry != null || chatMessage?.deletedAt != null;

    final isForward = chatMessage?.forwardFromId != null && chatMessage?.authorId != null;
    final isReply = chatMessage?.replyToId != null;

    var isViewedByMembers = false;
    var isViewedByUser = false;

    if (isSended && membersReadedUntil != null) isViewedByMembers = !chatMessage.createdAt.isAfter(membersReadedUntil);
    if (isSended && userReadedUntil != null) isViewedByUser = !chatMessage.createdAt.isAfter(userReadedUntil);

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
          onTap: () => widget.handleSetForReply(chatMessage),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_reply),
            leading: const Icon(Icons.question_answer_outlined),
            dense: true,
          ),
        ),
      if (isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForForward(chatMessage),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_forward),
            leading: const Icon(Icons.forward_outlined),
            dense: true,
          ),
        ),
      if (isMine && isSended && !isForward && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleSetForEdit(chatMessage),
          child: ListTile(
            title: Text(context.l10n.chats_MessageView_edit),
            leading: const Icon(Icons.edit_note_outlined),
            dense: true,
          ),
        ),
      if (isMine && isSended && !isDeleted)
        PopupMenuItem(
          onTap: () => widget.handleDelete(chatMessage),
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
      child: Padding(
        padding: isMine
            ? const EdgeInsets.only(left: 48, right: 8, top: 4, bottom: 4)
            : const EdgeInsets.only(left: 8, right: 48, top: 4, bottom: 4),
        child: Row(
          mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMine) ...[
              ContactInfoBuilder(
                sourceType: ContactSourceType.external,
                sourceId: senderId,
                builder: (context, contact, {required bool loading}) {
                  return LeadingAvatar(
                    username: contact?.name,
                    thumbnail: contact?.thumbnail,
                    thumbnailUrl: contact?.thumbnailUrl,
                    registered: contact?.registered,
                    radius: 20,
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: isMine
                      ? colorScheme.secondaryFixed.withOpacity(0.3)
                      : colorScheme.surfaceContainer.withOpacity(isViewedByUser ? 1 : 0.85),
                  borderRadius: isMine
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                ),
                padding: const EdgeInsets.all(12),
                child: IntrinsicWidth(
                  child: Column(
                    key: bodyKey,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ParticipantName(
                        senderId: senderId,
                        userId: widget.userId,
                        key: Key(senderId),
                        style: theme.userNameStyle,
                      ),
                      const SizedBox(height: 4),
                      if (isReply) ...[
                        ReplyQuote(userId: widget.userId, chatMessage: chatMessage!),
                        const SizedBox(height: 4),
                      ],
                      if (isForward) ...[
                        ForwartQuote(context: context, userId: widget.userId, msg: chatMessage!),
                      ],
                      if (!isForward && !isDeleted) ...[
                        MessageBody(text: content, style: theme.contentStyle),
                      ],
                      if (isEdited && !isDeleted) ...[
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(context.l10n.chats_MessageView_edited, style: theme.subContentStyle),
                        ),
                      ],
                      if (isDeleted) ...[
                        Text(context.l10n.chats_MessageView_deleted, style: theme.subContentStyle),
                      ],
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isMine && isSended == false)
                            CircularProgressTemplate(color: colorScheme.onSurface, size: 12, width: 1),
                          if (isMine && isSended && !isViewedByMembers)
                            Icon(Icons.done, color: colorScheme.onSurface, size: 12),
                          if (isMine && isViewedByMembers) Icon(Icons.done_all, color: colorScheme.onSurface, size: 12),
                          const SizedBox(width: 2),
                          if (chatMessage?.createdAt != null)
                            Text(chatMessage!.createdAt.toHHmm, style: theme.subContentStyle)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReplyQuote extends StatefulWidget {
  const ReplyQuote({
    super.key,
    required this.userId,
    required this.chatMessage,
  });

  final String userId;
  final ChatMessage chatMessage;

  @override
  State<ReplyQuote> createState() => _ReplyQuoteState();
}

class _ReplyQuoteState extends State<ReplyQuote> {
  late final chatsRepository = context.read<ChatsRepository>();
  late final client = context.read<ChatsBloc>().state.client;

  /// Fetch the message from local
  /// If the message is not found in the local storage, it will fetch it from the server
  /// and store it in the local storage silently to other components
  /// to avoid inconsistency if message older than the current chat history
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder(
        future: fetchMessage(widget.chatMessage.replyToId!, widget.chatMessage.chatId),
        builder: (context, snapshot) {
          final message = snapshot.data;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: theme.quoteDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (message != null)
                      ParticipantName(
                        senderId: message.senderId,
                        userId: widget.userId,
                        key: Key(message.senderId),
                        style: theme.userNameStyle,
                      )
                    else
                      Text('...', style: theme.userNameStyle),
                    const SizedBox(width: 8),
                    Icon(Icons.reply_outlined, color: theme.contentColor, size: 14),
                  ],
                ),
                const SizedBox(height: 4),
                MessageBody(
                  text: message?.content ?? '...',
                  style: theme.contentStyle,
                ),
              ],
            ),
          );
        });
  }
}

class ForwartQuote extends StatelessWidget {
  const ForwartQuote({
    super.key,
    required this.context,
    required this.userId,
    required this.msg,
  });

  final BuildContext context;
  final String userId;
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: theme.quoteDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: ParticipantName(senderId: msg.authorId!, userId: userId, style: theme.userNameStyle)),
              const SizedBox(width: 8),
              Icon(Icons.forward_outlined, color: theme.contentColor, size: 14),
            ],
          ),
          const SizedBox(height: 4),
          MessageBody(text: msg.content, style: theme.contentStyle),
        ],
      ),
    );
  }
}

class MessageBody extends StatefulWidget {
  const MessageBody({
    required this.text,
    this.style,
    this.previewDecoration,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final BoxDecoration? previewDecoration;

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

    final style = widget.style ?? theme.contentStyle;
    final previewDecoration = widget.previewDecoration ?? theme.quoteDecoration;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (link != null) ...[
          Container(
            decoration: previewDecoration,
            padding: const EdgeInsets.all(8),
            child: LinkPreview(
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
            ),
          ),
          const SizedBox(height: 8),
        ],
        ParsedText(
          parse: [
            mailToMatcher(
              style: style.copyWith(decoration: TextDecoration.underline),
            ),
            urlMatcher(
              style: style.copyWith(decoration: TextDecoration.underline),
            ),
            boldMatcher(
              style: style.merge(PatternStyle.bold.textStyle),
            ),
            italicMatcher(
              style: style.merge(PatternStyle.italic.textStyle),
            ),
            lineThroughMatcher(
              style: style.merge(PatternStyle.lineThrough.textStyle),
            ),
            codeMatcher(
              style: style.merge(PatternStyle.code.textStyle),
            ),
          ],
          regexOptions: const RegexOptions(multiLine: true, dotAll: true),
          style: style.copyWith(fontFamily: theme.textTheme.bodyMedium?.fontFamily),
          text: widget.text,
          textWidthBasis: TextWidthBasis.longestLine,
        ),
      ],
    );
  }
}

extension MsgViewExt on ThemeData {
  TextStyle get userNameStyle =>
      TextStyle(color: colorScheme.onSecondaryContainer, fontSize: 12, fontWeight: FontWeight.w600);
  TextStyle get contentStyle => TextStyle(color: colorScheme.onSurface, fontSize: 12);
  TextStyle get subContentStyle => TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 10);
  Color get contentColor => colorScheme.onSecondaryFixed;
  BoxDecoration get quoteDecoration => BoxDecoration(
        color: colorScheme.secondaryFixed.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: colorScheme.secondaryFixed, width: 2)),
      );
}
