import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MultisourceImageView extends StatelessWidget {
  const MultisourceImageView(
    this.path, {
    this.fit = BoxFit.cover,
    this.iconsColor = Colors.white,
    super.key,
  });

  final String path;
  final BoxFit fit;
  final Color iconsColor;

  @override
  Widget build(BuildContext context) {
    Widget placeholderBuilder() {
      return Center(child: Icon(Icons.image, color: iconsColor));
    }

    Widget errorBuilder() {
      return Center(child: Icon(Icons.error, color: iconsColor));
    }

    Widget frameBuilder(Widget child, int? frame, bool syncLoaded) {
      if (syncLoaded) return child;
      if (frame == null) return placeholderBuilder();
      return FadeIn(child: child);
    }

    return FutureBuilder(
        future: path.isLocalPath ? Future.value(File(path)) : DefaultCacheManager().getSingleFile(path),
        builder: (_, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasError) return errorBuilder();
          if (data == null) return placeholderBuilder();
          return Image.file(
            data,
            fit: fit,
            frameBuilder: (_, child, frame, syncLoaded) => frameBuilder(child, frame, syncLoaded),
            errorBuilder: (_, __, ___) => errorBuilder(),
          );
        });
  }
}
