import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

final _logger = Logger('SafeNetworkImage');

class SafeNetworkImage extends StatefulWidget {
  final String url;
  final Widget Function()? placeholderBuilder;
  final Widget Function()? errorBuilder;
  final BoxFit fit;

  const SafeNetworkImage(this.url, {super.key, this.placeholderBuilder, this.errorBuilder, this.fit = BoxFit.cover});

  @override
  State<SafeNetworkImage> createState() => _SafeNetworkImageState();
}

class _SafeNetworkImageState extends State<SafeNetworkImage> {
  /// What is painted. It stays painted while a different url loads, so asking for the
  /// same picture in another size does not drop back to the placeholder for the length
  /// of a request.
  ImageProvider? _shown;
  bool _hasError = false;

  ImageStream? _stream;
  ImageStreamListener? _listener;

  /// Whether the state is far enough along to rebuild. A cached image resolves inside
  /// [_load], which the first time around runs before this state has ever built.
  bool _canRebuild = false;

  @override
  void initState() {
    super.initState();
    _load();
    _canRebuild = true;
  }

  @override
  void didUpdateWidget(covariant SafeNetworkImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) _load();
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  /// A resolved stream keeps its entry alive in [ImageCache] for as long as something
  /// listens to it, so the listener is dropped on every reload and on the way out.
  void _load() {
    _stopListening();

    final provider = NetworkImage(widget.url);
    final listener = ImageStreamListener(
      (imageInfo, _) => _apply(() {
        _shown = provider;
        _hasError = false;
      }),
      onError: (error, stackTrace) {
        _logger.finest('Error loading image: $error', error);
        _apply(() => _hasError = true);
      },
    );

    _listener = listener;
    _stream = provider.resolve(const ImageConfiguration())..addListener(listener);
  }

  void _stopListening() {
    final stream = _stream;
    final listener = _listener;
    if (stream != null && listener != null) stream.removeListener(listener);

    _stream = null;
    _listener = null;
  }

  void _apply(VoidCallback change) {
    if (!_canRebuild) {
      change();
    } else if (mounted) {
      setState(change);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shown = _shown;
    // A picture already on screen outlives a failed reload: the last good one says more
    // than the fallback for a photo that was there a moment ago.
    if (shown != null) return Image(image: shown, fit: widget.fit);

    if (_hasError) return widget.errorBuilder?.call() ?? const SizedBox.shrink();

    return widget.placeholderBuilder?.call() ?? const SizedBox.shrink();
  }
}
