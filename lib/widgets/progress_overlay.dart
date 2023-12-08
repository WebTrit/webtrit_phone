import 'dart:async';

import 'package:flutter/material.dart';

class ProgressOverlay extends StatelessWidget {
  static void insert<T>(BuildContext context, Future<T> removeFuture) {
    final overlayEntry = OverlayEntry(builder: (context) => const ProgressOverlay._());
    Overlay.of(context).insert(overlayEntry);
    removeFuture.whenComplete(() => overlayEntry.remove()).ignore();
  }

  const ProgressOverlay._();

  @override
  Widget build(BuildContext context) {
    return const AbsorbPointer(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
