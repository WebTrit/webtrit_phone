import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gal/gal.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/video_view.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import 'multisource_image_view.dart';

class MediaViewPage extends StatefulWidget {
  const MediaViewPage({
    required this.attachments,
    required this.initialIndex,
    super.key,
  });

  final List<String> attachments;
  final int initialIndex;

  @override
  State<MediaViewPage> createState() => _MediaViewPageState();
}

class _MediaViewPageState extends State<MediaViewPage> {
  late final pageController = PageController(initialPage: widget.initialIndex);
  double prevRightScroll = 0;
  double prevLeftScroll = 0;

  int get currentIndex => pageController.page?.round() ?? 0;
  String get currentAttachment => widget.attachments[currentIndex];

  Future<File> get currentFile async {
    final file = currentAttachment.isLocalPath
        ? File(currentAttachment)
        : await DefaultCacheManager().getSingleFile(currentAttachment);
    return file;
  }

  void onSaveToGallery() async {
    final file = await currentFile;
    await Gal.putImage(file.path);

    if (!mounted) return;
    context.showSuccessSnackBar(
      'Image saved to gallery',
      action: SnackBarAction(label: 'Open', onPressed: () => Gal.open()),
    );
  }

  void onOpenWith() async {
    final file = await currentFile;
    OpenFile.open(file.path);
  }

  void onShare() async {
    final file = await currentFile;
    Share.shareXFiles([XFile(file.path)]);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        title: const Text('Media', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        systemOverlayStyle: kSystemThemeDark,
        actions: [
          PopupMenuButton(
            color: Colors.white,
            iconColor: Colors.white,
            itemBuilder: (_) => [
              if ((currentAttachment.isImagePath || currentAttachment.isVideoPath) && !currentAttachment.isLocalPath)
                PopupMenuItem(
                  onTap: onSaveToGallery,
                  child: const ListTile(
                    title: Text('Save to gallery'),
                    leading: Icon(Icons.download),
                    dense: true,
                  ),
                ),
              PopupMenuItem(
                onTap: onOpenWith,
                child: const ListTile(
                  title: Text('Open with'),
                  leading: Icon(Icons.open_in_new),
                  dense: true,
                ),
              ),
              PopupMenuItem(
                onTap: onShare,
                child: const ListTile(
                  title: Text('Share'),
                  leading: Icon(Icons.share),
                  dense: true,
                ),
              ),
            ],
          ),
        ],
      ),
      body: PageView.builder(
        pageSnapping: false,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.attachments.length,
        hitTestBehavior: HitTestBehavior.translucent,
        itemBuilder: (context, index) {
          final attachment = widget.attachments[index];
          final isFirst = index == 0;
          final isLast = index == widget.attachments.length - 1;

          Widget content;
          if (attachment.isImagePath) {
            content = InteractiveViewer(
              maxScale: 10,
              child: MultisourceImageView(
                attachment,
                fit: BoxFit.contain,
                iconsColor: Colors.white,
              ),
            );
          } else if (attachment.isVideoPath) {
            content = VideoView(attachment);
          } else {
            content = Center(
              child: Text(
                'File: ${attachment.split('/').last}',
                style: const TextStyle(fontSize: 24),
              ),
            );
          }

          return Stack(
            children: [
              Positioned.fill(child: content),
              if (!isLast)
                Positioned(
                  right: 0,
                  child: Dismissible(
                    key: const ValueKey('right_swipe'),
                    direction: DismissDirection.endToStart,
                    movementDuration: const Duration(milliseconds: 0),
                    dismissThresholds: const {DismissDirection.endToStart: 0.95},
                    onUpdate: (details) {
                      if (details.reached == false && details.previousReached == false) {
                        pageController.jumpTo(
                          pageController.offset +
                              (details.progress - prevRightScroll) * MediaQuery.of(context).size.width / 10,
                        );
                      }
                      prevRightScroll = details.progress;
                      setState(() {});
                    },
                    confirmDismiss: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutExpo,
                        );
                      }
                      return Future.value(false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black.withValues(alpha: prevRightScroll.clamp(0, 0.5)),
                        ),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          size: 32,
                          color: Colors.white.withValues(alpha: prevRightScroll),
                        ),
                      ),
                    ),
                  ),
                ),
              if (!isFirst)
                Positioned(
                  left: 0,
                  child: Dismissible(
                    key: const ValueKey('left_swipe'),
                    direction: DismissDirection.startToEnd,
                    movementDuration: const Duration(milliseconds: 0),
                    dismissThresholds: const {DismissDirection.startToEnd: 0.95},
                    onUpdate: (details) {
                      if (details.reached == false && details.previousReached == false) {
                        pageController.jumpTo(
                          pageController.offset -
                              (details.progress - prevLeftScroll) * MediaQuery.of(context).size.width / 10,
                        );
                      }
                      prevLeftScroll = details.progress;
                      setState(() {});
                    },
                    confirmDismiss: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutExpo,
                        );
                      }
                      return Future.value(false);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black.withValues(alpha: prevLeftScroll.clamp(0, 0.5)),
                        ),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          size: 32,
                          color: Colors.white.withValues(alpha: prevLeftScroll),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
