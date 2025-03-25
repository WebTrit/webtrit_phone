import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

final _logger = Logger('SafeNetworkImage');

class SafeNetworkImage extends StatefulWidget {
  final String url;
  final Widget Function()? placeholderBuilder;
  final Widget Function()? errorBuilder;
  final BoxFit fit;

  const SafeNetworkImage(
    this.url, {
    super.key,
    this.placeholderBuilder,
    this.errorBuilder,
    this.fit = BoxFit.cover,
  });

  @override
  State<SafeNetworkImage> createState() => _SafeNetworkImageState();
}

class _SafeNetworkImageState extends State<SafeNetworkImage> {
  bool _hasError = false;
  bool _isLoaded = false;

  late final ImageProvider _imageProvider;

  @override
  void initState() {
    super.initState();
    _imageProvider = NetworkImage(widget.url);
    _imageProvider.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (imageInfo, _) {
              if (mounted) setState(() => _isLoaded = true);
            },
            onError: (error, stackTrace) {
              _logger.warning('Error loading image: $error', error);
              if (mounted) setState(() => _hasError = true);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) return widget.errorBuilder?.call() ?? const SizedBox.shrink();

    if (!_isLoaded) return widget.placeholderBuilder?.call() ?? const SizedBox.shrink();

    return Image(image: _imageProvider, fit: widget.fit);
  }
}
