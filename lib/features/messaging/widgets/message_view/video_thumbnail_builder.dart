import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webtrit_phone/data/media_storage.dart';

class VideoThumbnailBuilder extends StatefulWidget {
  const VideoThumbnailBuilder(this.path, this.builder, {super.key});
  final String path;

  final Widget Function(File? file) builder;

  @override
  State<VideoThumbnailBuilder> createState() => _VideoThumbnailBuilderState();
}

class _VideoThumbnailBuilderState extends State<VideoThumbnailBuilder> {
  File? file;

  @override
  void initState() {
    super.initState();
    generate();
  }

  generate() async {
    // Continuously try to get the thumbnail until it is available
    // or the widget is disposed
    await Future.doWhile(() async {
      try {
        final path = widget.path;
        final thumb = await MediaStorage().getVideoThumbnail(path);
        if (!mounted) return false;
        setState(() => file = thumb);
        return false;
      } catch (_) {
        // Retry if the file is not available
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return false;
        return true; // Retry
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(file);
  }
}
