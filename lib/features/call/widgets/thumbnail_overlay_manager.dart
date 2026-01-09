import 'package:flutter/material.dart';

import 'draggable_thumbnail.dart';

/// Function type allowing the overlay content to be wrapped with additional widgets.
typedef OverlayContextWrapper = Widget Function(BuildContext context, Widget child);

class ThumbnailOverlayManager {
  ThumbnailOverlayManager({required this.stickyPadding});

  final EdgeInsets stickyPadding;

  Offset? _lastOffset;
  OverlayEntry? _entry;

  OverlayContextWrapper? _currentWrapper;
  final ValueNotifier<Widget?> _contentNotifier = ValueNotifier(null);

  bool get isShowing => _entry != null;

  /// Shows the overlay.
  ///
  /// [child] is the visual content (e.g., avatar).
  /// [contextWrapper] is an optional function to inject dependencies.
  void show(BuildContext context, {required Widget child, OverlayContextWrapper? contextWrapper}) {
    _contentNotifier.value = child;
    _currentWrapper = contextWrapper;

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
        wrapper: _currentWrapper,
      ),
    );

    _entry = entry;
    Overlay.of(context).insert(entry);
  }

  void hide() {
    final entry = _entry;
    if (entry != null) {
      entry.remove();
      _entry = null;
      _contentNotifier.value = null;
      _currentWrapper = null;
    }
  }

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
    this.wrapper,
  });

  final ValueNotifier<Widget?> contentNotifier;
  final EdgeInsets stickyPadding;
  final ValueChanged<Offset> onOffsetUpdate;
  final Offset? initialOffset;
  final OverlayContextWrapper? wrapper;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Widget?>(
      valueListenable: contentNotifier,
      builder: (BuildContext context, Widget? content, Widget? _) {
        if (content == null) {
          return const SizedBox.shrink();
        }

        final draggable = DraggableThumbnail(
          stickyPadding: stickyPadding,
          initialOffset: initialOffset,
          onOffsetUpdate: onOffsetUpdate,
          child: content,
        );

        final localWrapper = wrapper;
        if (localWrapper != null) {
          return localWrapper(context, draggable);
        }

        return draggable;
      },
    );
  }
}
