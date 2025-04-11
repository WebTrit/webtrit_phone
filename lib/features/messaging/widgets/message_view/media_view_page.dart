import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gal/gal.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/data/media_storage.dart';
import 'package:webtrit_phone/features/messaging/extensions/extensions.dart';
import 'package:webtrit_phone/features/messaging/widgets/message_view/video_view.dart';
import 'package:webtrit_phone/features/orientations/bloc/orientations_bloc.dart';
import 'package:webtrit_phone/features/orientations/models/preferred_orientation.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

import 'multisource_image_view.dart';

typedef AttPathAndFilename = ({String path, String filename});

class MediaViewPage extends StatefulWidget {
  const MediaViewPage({
    required this.attachments,
    required this.initialIndex,
    super.key,
  });

  final List<AttPathAndFilename> attachments;
  final int initialIndex;

  @override
  State<MediaViewPage> createState() => _MediaViewPageState();
}

class _MediaViewPageState extends State<MediaViewPage> {
  late final orientationsBloc = context.read<OrientationsBloc>();
  late final pageController = PageController(initialPage: widget.initialIndex);

  late int currentIndex = widget.initialIndex;
  AttPathAndFilename get currentAttachment => widget.attachments[currentIndex];

  int touchPointersCount = 0;
  double scale = 1.0;
  double interactionScale = 1.0;

  bool hideAppBar = false;

  Future<File> get currentFile async {
    return currentAttachment.path.isLocalPath
        ? File(currentAttachment.path)
        : await MediaStorage().downloadOrGetFile(currentAttachment.path);
  }

  bool get canSaveToGallery {
    if (currentAttachment.path.isLocalPath) return false;
    if (currentAttachment.path.isImagePath) return true;
    if (currentAttachment.path.isVideoPath) return true;
    return false;
  }

  void onSaveToGallery() async {
    final file = await currentFile;
    if (currentAttachment.path.isImagePath) {
      await Gal.putImage(file.path, album: 'Webtrit');
    }
    if (currentAttachment.path.isVideoPath) {
      await Gal.putVideo(file.path, album: 'Webtrit');
    }

    if (!mounted) return;
    context.showSuccessSnackBar(
      context.l10n.messaging_MediaView_saveToGallery_success,
      action: SnackBarAction(
        label: context.l10n.messaging_MediaView_saveToGallery_open,
        onPressed: () => Gal.open(),
      ),
    );
  }

  void onOpenWith() async {
    final file = await currentFile;
    OpenFile.open(file.path);
  }

  void onShare() async {
    final file = await currentFile;
    final filename = currentAttachment.filename;
    Share.shareXFiles([XFile(file.path)], fileNameOverrides: [filename]);
  }

  @override
  void initState() {
    super.initState();
    orientationsBloc.add(const OrientationsChanged(PreferredOrientation.full));
    SystemChrome.setSystemUIOverlayStyle(kSystemThemeDarkTransparent);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.top]);
  }

  @override
  void dispose() {
    super.dispose();
    orientationsBloc.add(const OrientationsChanged(PreferredOrientation.upDown));
    SystemChrome.setSystemUIOverlayStyle(kSystemThemeLight);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: kSystemThemeDarkTransparent,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: hideAppBar ? null : appBar(),
        body: GestureDetector(
          onTap: () => setState(() => hideAppBar = !hideAppBar),
          child: body(),
        ),
      ),
    );
  }

  AppBar appBar() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: colorScheme.secondary.withValues(alpha: 0.25),
      title: Text(
        '${currentAttachment.filename.limit(30)}\n'
        '${currentIndex + 1} / ${widget.attachments.length}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      systemOverlayStyle: kSystemThemeDarkTransparent,
      actions: [
        PopupMenuButton(
          color: Colors.white,
          iconColor: Colors.white,
          itemBuilder: (_) => [
            if (canSaveToGallery)
              PopupMenuItem(
                onTap: onSaveToGallery,
                child: ListTile(
                  title: Text(context.l10n.messaging_MediaView_saveToGallery),
                  leading: const Icon(Icons.download),
                  dense: true,
                ),
              ),
            PopupMenuItem(
              onTap: onOpenWith,
              child: ListTile(
                title: Text(context.l10n.messaging_MediaView_open),
                leading: const Icon(Icons.open_in_new),
                dense: true,
              ),
            ),
            PopupMenuItem(
              onTap: onShare,
              child: ListTile(
                title: Text(context.l10n.messaging_MediaView_share),
                leading: const Icon(Icons.share),
                dense: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget body() {
    return Listener(
      onPointerDown: (_) => setState(() => touchPointersCount++),
      onPointerUp: (_) => setState(() => touchPointersCount--),
      child: PageView.builder(
        onPageChanged: (value) => setState(() => currentIndex = value),
        controller: pageController,
        physics: (touchPointersCount == 2 || scale >= 1.1)
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        itemCount: widget.attachments.length,
        hitTestBehavior: HitTestBehavior.translucent,
        itemBuilder: (context, index) {
          final attachment = widget.attachments[index];

          if (attachment.path.isImagePath) {
            return InteractiveViewer(
              maxScale: 10,
              onInteractionUpdate: (details) {
                interactionScale = details.scale;
              },
              onInteractionEnd: (details) {
                scale = (scale * interactionScale).clamp(1.0, 10.0);
                setState(() {});
              },
              child: MultisourceImageView(
                attachment.path,
                fit: BoxFit.contain,
                placeholder: const Icon(Icons.image, color: Colors.white, size: 64),
                error: const Icon(Icons.error, color: Colors.white, size: 64),
              ),
            );
          } else if (attachment.path.isVideoPath) {
            return VideoView(
              attachment.path,
              onControlsDisplayChanged: (show) {
                if (!mounted) return;
                setState(() => hideAppBar = !show);
              },
            );
          } else {
            return Center(
              child: Text(
                'File: ${attachment.filename}',
                style: const TextStyle(fontSize: 24),
              ),
            );
          }
        },
      ),
    );
  }
}
