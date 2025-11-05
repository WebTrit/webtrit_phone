import 'package:flutter/material.dart';

import 'package:quiver/collection.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/system_notification.dart';
import 'package:webtrit_phone/utils/utils.dart';

class SystemNotificationListTile extends StatefulWidget {
  const SystemNotificationListTile(this.notification, {this.seenPending = false, this.onSeen, super.key});

  final SystemNotification notification;
  final bool seenPending;
  final VoidCallback? onSeen;

  @override
  State<SystemNotificationListTile> createState() => _SystemNotificationListTileState();
}

class _SystemNotificationListTileState extends State<SystemNotificationListTile> with TickerProviderStateMixin {
  late final controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800), value: 1);
  late final animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);

  static final previewsCache = LruMap<String, OgPreview>(maximumSize: 100);
  OgPreview? preview;

  bool get seen => widget.notification.seen || widget.seenPending;
  late bool wasSeen = seen;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || seen) return;
      controller.value = 0;
      controller.forward();
      widget.onSeen?.call();
    });
    findLink(widget.notification.content);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  findLink(String text) {
    final match = RegExp(linkRegex, caseSensitive: false).stringMatch(text);

    if (match != null) {
      if (previewsCache[match] != null) {
        preview = previewsCache[match];
        if (mounted) setState(() {});
      } else {
        OgPreview.get(match).then((value) {
          if (value != null) previewsCache[match] = value;
          if (mounted) setState(() => preview = value);
        });
      }
    } else {
      if (mounted) setState(() => preview = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = TextStyle(color: colorScheme.onSurface, fontSize: 14);

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.05, -0.05), end: Offset.zero).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: Column(
          children: [
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(seconds: 5),
              curve: Curves.easeOut,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: seen ? colorScheme.surfaceBright : colorScheme.primaryContainer,
                border: Border(left: BorderSide(color: wasSeen ? colorScheme.primary : colorScheme.tertiary, width: 4)),
                boxShadow: [
                  BoxShadow(
                    color: (seen ? colorScheme.primary : colorScheme.tertiary).withAlpha(50),
                    blurRadius: 16,
                    spreadRadius: 4,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  content(style, theme),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 600),
                    sizeCurve: Curves.elasticOut,
                    firstCurve: Curves.easeInExpo,
                    alignment: Alignment.center,
                    firstChild: linkPreview(colorScheme, style),
                    secondChild: const SizedBox.shrink(),
                    crossFadeState: preview != null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  ),
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: time(style)),
          ],
        ),
      ),
    );
  }

  Widget time(TextStyle style) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        widget.notification.createdAt.timeOrDate,
        style: TextStyle(fontSize: 10, color: style.color),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget content(TextStyle style, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(widget.notification.title, style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            Icon(
              switch (widget.notification.type) {
                SystemNotificationType.announcement => Icons.announcement_outlined,
                SystemNotificationType.promotion => Icons.local_offer_outlined,
                SystemNotificationType.security => Icons.security_outlined,
                SystemNotificationType.system => Icons.settings_outlined,
              },
              size: 20,
              color: style.color,
            ),
          ],
        ),
        Divider(height: 12, color: style.color?.withAlpha(10)),
        ParsedText(
          text: widget.notification.content,
          parse: TextMatchers.matchers(style),
          regexOptions: const RegexOptions(multiLine: true, dotAll: true),
          style: style.copyWith(fontFamily: theme.textTheme.bodyMedium?.fontFamily),
          textWidthBasis: TextWidthBasis.longestLine,
        ),
      ],
    );
  }

  Widget linkPreview(ColorScheme colorScheme, TextStyle style) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: colorScheme.primaryFixed.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: colorScheme.primaryFixed, width: 3)),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          if (preview?.imageUrl != null) ...[
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: Image.network(preview!.imageUrl!),
            ),
            const SizedBox(height: 8),
          ],
          if ((preview?.title) != null)
            Row(
              children: [
                Expanded(
                  child: Text(
                    preview!.title!,
                    style: style.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.link_sharp, size: 16, color: Colors.grey.shade600),
              ],
            ),
          if (preview?.description != null) ...[Text(preview!.description!, style: style)],
          if (preview?.imageUrl != null && preview?.title == null && preview?.description == null)
            Row(
              children: [
                Expanded(
                  child: Text(
                    preview!.imageUrl!,
                    style: style.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.link_sharp, size: 16, color: Colors.grey.shade600),
              ],
            ),
        ],
      ),
    );
  }
}
