import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';

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
    final path = widget.path;

    final exitst = await DefaultCacheManager().getFileFromCache('${path}thumb');
    if (!mounted) return;

    if (exitst != null) {
      setState(() => file = exitst.file);
      return;
    }

    final data = await VideoThumbnail.thumbnailData(video: path, imageFormat: ImageFormat.JPEG, maxHeight: 1080);
    final cachedFile = await DefaultCacheManager().putFile('${path}thumb', data, fileExtension: 'jpg');
    if (!mounted) return;

    setState(() => file = cachedFile);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(file);
  }
}
