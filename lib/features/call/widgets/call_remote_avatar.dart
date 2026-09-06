import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../bloc/call_bloc.dart';
import '../utils/utils.dart';

/// Remote party avatar rendered in the area the remote video normally occupies.
///
/// Shown while there is nothing to render there - an audio-only call, the remote camera
/// switched off, or a held call - so the screen is not just an empty background.
///
/// Deliberately not `LeadingAvatar`: that widget is built for list-row sized icons and
/// carries presence/registration badges, a loading overlay and per-theme styling that
/// this screen has no use for. Only the pseudorandom name color ([AvatarColors]) is
/// shared, so a contact looks the same here as in the lists.
class CallRemoteAvatar extends StatefulWidget {
  const CallRemoteAvatar({super.key, required this.activeCall, required this.radius, this.contactResolver});

  /// Radius of the avatar. The caller derives it from the screen (not from the local
  /// constraints): the call layout sits inside a `FittedBox`, so the incoming
  /// constraints there are unbounded.
  final double radius;

  final ActiveCall activeCall;
  final ContactResolver? contactResolver;

  @override
  State<CallRemoteAvatar> createState() => _CallRemoteAvatarState();
}

class _CallRemoteAvatarState extends State<CallRemoteAvatar> {
  /// Resolved once per number: the call screen rebuilds on every bloc state change,
  /// so resolving inside `build` would hit the contacts repository continuously.
  late Future<Contact?> _contact;

  @override
  void initState() {
    super.initState();
    _resolveContact();
  }

  @override
  void didUpdateWidget(covariant CallRemoteAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeCall.handle.value != widget.activeCall.handle.value ||
        oldWidget.contactResolver != widget.contactResolver) {
      _resolveContact();
    }
  }

  void _resolveContact() {
    _contact = widget.contactResolver?.resolve(widget.activeCall.handle.value) ?? Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diameter = widget.radius * 2;

    // Taps belong to the call screen behind it, which toggles the controls.
    return IgnorePointer(
      child: FutureBuilder<Contact?>(
        future: _contact,
        builder: (context, snapshot) {
          final contact = snapshot.data;
          final name = contact?.maybeName ?? widget.activeCall.displayName ?? widget.activeCall.handle.value;

          final background = AvatarColors.background(name, theme.brightness) ?? theme.colorScheme.secondaryContainer;

          return SizedBox.square(
            dimension: diameter,
            child: ClipOval(
              child: ColoredBox(
                color: background,
                child: _CallRemoteAvatarContent(
                  name: name,
                  thumbnail: contact?.thumbnail,
                  thumbnailUrl: contact?.thumbnailUrl,
                  diameter: diameter,
                  foregroundColor: AvatarColors.foreground(background, theme.brightness),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CallRemoteAvatarContent extends StatelessWidget {
  const _CallRemoteAvatarContent({
    required this.name,
    required this.thumbnail,
    required this.thumbnailUrl,
    required this.diameter,
    required this.foregroundColor,
  });

  final String name;
  final Uint8List? thumbnail;
  final Uri? thumbnailUrl;
  final double diameter;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    final initials = _Initials(name: name, diameter: diameter, color: foregroundColor);

    if (thumbnailUrl != null) {
      // Ask the remote for the resolution actually painted; the list-sized default
      // would be upscaled to a blur at this diameter. The size is one of the shared
      // request sizes, so this is the same url the rest of the app already asked for.
      final devicePixels = diameter * MediaQuery.devicePixelRatioOf(context);
      final url = GravatarUrl.withSize(thumbnailUrl, GravatarUrl.requestSize(devicePixels)) ?? thumbnailUrl!;

      return Image.network(
        url.toString(),
        fit: BoxFit.cover,
        width: diameter,
        height: diameter,
        filterQuality: FilterQuality.medium,
        errorBuilder: (context, error, stackTrace) => _localImage ?? initials,
        loadingBuilder: (context, child, progress) => progress == null ? child : (_localImage ?? initials),
      );
    }

    return _localImage ?? initials;
  }

  Widget? get _localImage {
    final thumbnail = this.thumbnail;
    if (thumbnail == null) return null;

    return Image.memory(
      thumbnail,
      fit: BoxFit.cover,
      width: diameter,
      height: diameter,
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stackTrace) => _Initials(name: name, diameter: diameter, color: foregroundColor),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.name, required this.diameter, required this.color});

  final String name;
  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name.initialism,
        softWrap: false,
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: diameter * 0.35, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
