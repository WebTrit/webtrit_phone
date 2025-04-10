import 'dart:io';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/data/media_storage.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MultisourceImageView extends StatelessWidget {
  const MultisourceImageView(
    this.path, {
    this.fit = BoxFit.cover,
    this.placeholder = const Icon(Icons.image),
    this.error = const Icon(Icons.error),
    super.key,
  });

  final String path;
  final BoxFit fit;
  final Widget placeholder;
  final Widget error;

  @override
  Widget build(BuildContext context) {
    Widget frameBuilder(Widget child, int? frame, bool syncLoaded) {
      if (syncLoaded) return child;
      if (frame == null) return Center(child: placeholder);
      return FadeIn(child: child);
    }

    return FutureBuilder(
        future: path.isLocalPath ? Future.value(File(path)) : MediaStorage().downloadOrGetFile(path),
        builder: (_, snapshot) {
          final data = snapshot.data;
          if (snapshot.hasError) return Center(child: error);
          if (data == null) return Center(child: placeholder);
          return Image.file(
            data,
            fit: fit,
            frameBuilder: (_, child, frame, syncLoaded) => frameBuilder(child, frame, syncLoaded),
            errorBuilder: (_, __, ___) => Center(child: error),
          );
        });
  }
}
