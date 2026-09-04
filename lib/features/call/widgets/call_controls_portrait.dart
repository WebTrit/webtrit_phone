import 'package:flutter/material.dart';

import 'call_action_area.dart';
import 'call_controls.dart';
import 'call_info_block.dart';
import 'call_remote_avatar.dart';

/// The portrait arrangement of the call screen body: the info block on top,
/// the avatar flexing into the leftover height, the action area at the bottom.
///
/// It only places the shared pieces ([CallInfoBlock], [CallActionArea]) - what
/// each control does arrives in [params] as callbacks, and the toolbar belongs
/// to [CallControls]. In landscape it keeps the legacy scale-to-fit of the
/// whole block, until a landscape arrangement of its own takes that over.
class CallControlsPortrait extends StatelessWidget {
  const CallControlsPortrait({super.key, required this.params});

  final CallControlsParams params;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _buildBody);
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    final mediaQueryData = MediaQuery.of(context);
    final isPortrait = mediaQueryData.orientation == Orientation.portrait;
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CallInfoBlock(
          activeCalls: params.activeCalls,
          focusedCall: params.focusedCall,
          onCallSelected: params.onCallSelected,
        ),
        // Nothing to render in the video area (audio-only call,
        // remote camera off, or a held call): the remote party's
        // avatar takes its place, between the info block and the
        // action area. The avatar takes only the height LEFT OVER
        // by the info block and the action area and scales itself
        // down into it - so growing content (e.g. the open in-call
        // keypad) shrinks the avatar, never the controls.
        if (!params.focusedFrameRenderable && !params.keypadShown)
          if (isPortrait)
            Flexible(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  // The focused call, not the derived current one: the
                  // roster and the actions act on the focused call, and
                  // the picture must show the same person.
                  child: CallRemoteAvatar(
                    activeCall: params.focusedCall,
                    radius: CallRemoteAvatar.preferredRadius(mediaQueryData),
                    contactResolver: params.contactResolver,
                  ),
                ),
              ),
            )
          else
            CallRemoteAvatar(
              activeCall: params.focusedCall,
              radius: CallRemoteAvatar.preferredRadius(mediaQueryData),
              contactResolver: params.contactResolver,
            ),
        CallActionArea(params: params),
      ],
    );

    // Portrait has the room: controls render at natural size and the
    // avatar flexes into what is left. Landscape keeps the legacy
    // scale-to-fit of the whole block - heights there are too small
    // for the natural layout.
    if (isPortrait) {
      return SizedBox(width: constraints.maxWidth, height: constraints.maxHeight, child: content);
    }
    return FittedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: constraints.maxWidth, minHeight: constraints.minHeight),
        child: content,
      ),
    );
  }
}
