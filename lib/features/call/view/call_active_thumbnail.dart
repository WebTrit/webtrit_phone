import 'package:flutter/material.dart';

import 'package:webtrit_phone/utils/view_params/presence_view_params.dart';
import 'package:webtrit_phone/widgets/leading_avatar.dart';

import '../call.dart';

class CallActiveThumbnail {
  CallActiveThumbnail({required this.stickyPadding, this.onTap});

  final EdgeInsets stickyPadding;
  final GestureTapCallback? onTap;
  Offset? _offset;
  OverlayEntry? _entry;

  bool get inserted => _entry != null;

  void insert(BuildContext context, CallState state) {
    assert(_entry == null);

    final activeCall = state.activeCalls.current;

    final entry = OverlayEntry(
      builder: (_) {
        return PresenceViewParams(
          viewSource: PresenceViewParams.of(context).viewSource,
          child: DraggableThumbnail(
            stickyPadding: stickyPadding,
            initialOffset: _offset,
            onOffsetUpdate: (offset) {
              _offset = offset;
            },
            onTap: onTap,
            child: StreamThumbnail(
              stream: activeCall.remoteStream,
              placeholderBuilder: (context) => LeadingAvatar(
                radius: 24,
                username: activeCall.displayName,
                placeholderIcon: Icons.phone_in_talk_outlined,
              ),
            ),
          ),
        );
      },
    );
    _entry = entry;
    Overlay.of(context).insert(entry);
  }

  void remove() {
    assert(_entry != null);

    _entry!.remove();
    _entry = null;
  }
}
