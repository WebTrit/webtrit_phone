import 'package:flutter/material.dart';

import 'draggable_thumbnail.dart';

/// Manages the lifecycle and state of a draggable thumbnail overlay.
///
/// This class handles inserting the [OverlayEntry], updating its content,
/// and preserving the thumbnail's position across different show/hide sessions.
class ThumbnailOverlayManager {
  ThumbnailOverlayManager({required this.stickyPadding});

  /// The padding used to constrain the draggable area within the overlay.
  final EdgeInsets stickyPadding;

  Offset? _lastOffset;
  OverlayEntry? _entry;

  /// Drives the content of the active overlay, allowing updates without
  /// removing and re-inserting the [OverlayEntry].
  final ValueNotifier<Widget?> _contentNotifier = ValueNotifier<Widget?>(null);

  /// Whether the overlay entry is currently inserted in the view hierarchy.
  bool get isShowing => _entry != null;

  /// Displays the provided [child] in an overlay.
  ///
  /// If the overlay is already active, this updates the content without
  /// re-inserting the entry, preventing flickering.
  void show(BuildContext context, {required Widget child}) {
    _contentNotifier.value = child;

    if (_entry != null) {
      _entry!.markNeedsBuild();
      return;
    }

    final entry = OverlayEntry(
      builder: (context) => _ThumbnailOverlayContent(
        contentNotifier: _contentNotifier,
        stickyPadding: stickyPadding,
        initialOffset: _lastOffset,
        onOffsetUpdate: _updateOffset,
      ),
    );

    _entry = entry;
    Overlay.of(context).insert(entry);
  }

  /// Removes the overlay entry from the view hierarchy.
  ///
  /// The last known position of the thumbnail is preserved for the next usage.
  void hide() {
    final entry = _entry;
    if (entry != null) {
      entry.remove();
      _entry = null;
      _contentNotifier.value = null;
    }
  }

  /// Hides the overlay and releases resources used by the content notifier.
  void dispose() {
    hide();
    _contentNotifier.dispose();
  }

  void _updateOffset(Offset offset) => _lastOffset = offset;
}

class _ThumbnailOverlayContent extends StatelessWidget {
  const _ThumbnailOverlayContent({
    required this.contentNotifier,
    required this.stickyPadding,
    required this.onOffsetUpdate,
    this.initialOffset,
  });

  final ValueNotifier<Widget?> contentNotifier;
  final EdgeInsets stickyPadding;
  final ValueChanged<Offset> onOffsetUpdate;
  final Offset? initialOffset;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Widget?>(
      valueListenable: contentNotifier,
      builder: (BuildContext context, Widget? content, Widget? _) {
        if (content == null) {
          return const SizedBox.shrink();
        }

        return DraggableThumbnail(
          stickyPadding: stickyPadding,
          initialOffset: initialOffset,
          onOffsetUpdate: onOffsetUpdate,
          child: content,
        );
      },
    );
  }
}
