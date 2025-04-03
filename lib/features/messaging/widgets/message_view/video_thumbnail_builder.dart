import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webtrit_phone/common/media_storage_service.dart';

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
        final thumb = await MediaStorageService.getVideoThumbnail(path);
        if (!mounted) return false;
        setState(() => file = thumb);
        return false;
      } catch (_) {
        // Retry if the file is not available
        await Future.delayed(const Duration(seconds: 1));
        return true; // Retry
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(file);
  }
}
