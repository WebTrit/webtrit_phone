import 'dart:async';

import 'package:flutter/material.dart';

class ProgressOverlay extends StatelessWidget {
  static void insert<T>(BuildContext context, Future<T> removeFuture) {
    final overlayEntry = OverlayEntry(builder: (context) => const ProgressOverlay._());
    final overlay = Overlay.of(context);
    if (overlay != null) {
      overlay.insert(overlayEntry);
      removeFuture.whenComplete(() => overlayEntry.remove()).ignore();
    }
  }

  const ProgressOverlay._({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AbsorbPointer(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
