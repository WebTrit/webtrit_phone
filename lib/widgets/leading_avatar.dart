import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

class LeadingAvatar extends StatefulWidget {
  const LeadingAvatar({
    super.key,
    required this.username,
    this.thumbnail,
    this.thumbnailUrl,
    this.placeholderIcon = Icons.person_outline,
    this.registered,
    this.smart = false,
    this.radius = 20.0, // value of private _defaultRadius variable in CircleAvatar class
  });

  final String? username;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final IconData placeholderIcon;
  final bool? registered;
  final bool smart;
  final double radius;

  @override
  State<LeadingAvatar> createState() => _LeadingAvatarState();
}

class _LeadingAvatarState extends State<LeadingAvatar> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final colorScheme = themeData.colorScheme;
    final diameter = widget.radius * 2;

    final registeredStatusStyle = themeData.extension<RegisteredStatusStyles>()!.primary;
    final cacheSize = (diameter * MediaQuery.of(context).devicePixelRatio).toInt();

    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.secondaryContainer,
      ),
      child: Stack(
        children: [
          _Placeholder(
            placeholderIcon: widget.placeholderIcon,
            username: widget.username,
          ),
          if (widget.thumbnail != null)
            _BlobImage(
              blob: widget.thumbnail!,
              cacheSize: cacheSize,
            ),
          if (widget.thumbnailUrl != null)
            _UrlImage(
              url: widget.thumbnailUrl.toString(),
              cacheSize: cacheSize,
            ),
          if (widget.smart)
            _SmartIndicator(
              diameter: diameter,
              colorScheme: colorScheme,
            ),
          if (widget.registered != null)
            _RegisteredIndicator(
              diameter: diameter,
              registered: widget.registered!,
              registeredStatusStyle: registeredStatusStyle,
            ),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.placeholderIcon,
    this.username,
  });

  final IconData placeholderIcon;
  final String? username;

  @override
  Widget build(BuildContext context) {
    return username != null
        ? Center(
            child: Text(
              username!.initialism,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          )
        : Center(
            child: Icon(placeholderIcon),
          );
  }
}

class _BlobImage extends StatelessWidget {
  const _BlobImage({
    required this.blob,
    required this.cacheSize,
  });

  final Uint8List blob;
  final int cacheSize;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.memory(
        blob,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        cacheHeight: cacheSize,
        cacheWidth: cacheSize,
      ),
    );
  }
}

class _UrlImage extends StatelessWidget {
  const _UrlImage({
    required this.url,
    required this.cacheSize,
  });

  final String url;
  final int cacheSize;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        cacheHeight: cacheSize,
        cacheWidth: cacheSize,
      ),
    );
  }
}

class _SmartIndicator extends StatelessWidget {
  const _SmartIndicator({
    required this.diameter,
    required this.colorScheme,
  });

  final double diameter;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: diameter * -0.1,
      bottom: diameter * -0.1,
      width: diameter * 0.4,
      height: diameter * 0.4,
      child: CircleAvatar(
        backgroundColor: colorScheme.surfaceContainerLowest,
        child: Icon(
          Icons.person,
          size: diameter * 0.4 * 0.9,
        ),
      ),
    );
  }
}

class _RegisteredIndicator extends StatelessWidget {
  const _RegisteredIndicator({
    required this.diameter,
    required this.registered,
    required this.registeredStatusStyle,
  });

  final double diameter;
  final bool registered;

  final RegisteredStatusStyle registeredStatusStyle;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      width: diameter * 0.2,
      height: diameter * 0.2,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: registered ? registeredStatusStyle.registered : registeredStatusStyle.unregistered,
        ),
      ),
    );
  }
}
