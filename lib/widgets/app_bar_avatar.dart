import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/models/models.dart';

import 'leading_avatar.dart';
import 'semantic_action.dart';

/// The account button of the main app bar: the user's avatar inside a ring that
/// carries the colour of the session status.
///
/// It is a widget of its own so the ring can be looked at in every status without
/// standing up the three blocs the app bar reads - see
/// `test/widgets/app_bar_avatar_golden_test.dart`, which keeps a picture per status.
class AppBarAvatar extends StatelessWidget {
  const AppBarAvatar({
    super.key,
    required this.status,
    required this.semanticsLabel,
    required this.identifier,
    required this.onPressed,
    this.buttonKey,
    this.username,
    this.thumbnailUrl,
    this.overlays = const [],
  });

  /// The session status the ring is coloured by.
  final SessionStatus status;

  /// What the button announces; the avatar itself is visual only.
  final String semanticsLabel;

  /// Stable automation id of the button.
  final String identifier;

  final VoidCallback onPressed;

  /// Key of the button itself, for the tests and automation that press it.
  final Key? buttonKey;

  final String? username;
  final Uri? thumbnailUrl;

  /// Badges drawn over the avatar. They are `Positioned` in the avatar's square,
  /// and may hang outside it - nothing here clips.
  final List<Widget> overlays;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Ink(
      decoration: ShapeDecoration(
        shape: CircleBorder(side: BorderSide(color: status.color(context))),
      ),
      child: SemanticAction(
        label: semanticsLabel,
        identifier: identifier,
        child: IconButton(
          key: buttonKey,
          constraints: const BoxConstraints.tightFor(width: kMinInteractiveDimension, height: kMinInteractiveDimension),
          padding: const EdgeInsets.all(2),
          // The avatar's initials and status badges are visual-only here; the
          // button announces itself with a fixed name instead.
          icon: ExcludeSemantics(
            // The avatar keeps its own palette: without this reset the app bar
            // pushes its foreground color into the subtree and tints it.
            child: IconTheme(
              data: theme.iconTheme,
              child: DefaultTextStyle(
                style: theme.textTheme.bodyMedium!,
                // The box the button hands down is not square, and an avatar takes the
                // shape of the box it is given - so it is sized from the shorter side
                // and centred, which keeps it a circle sitting evenly inside the ring.
                child: LayoutBuilder(
                  builder: (context, constraints) => Center(
                    child: SizedBox.square(
                      dimension: constraints.biggest.shortestSide,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          LeadingAvatar(
                            username: username,
                            thumbnailUrl: thumbnailUrl,
                            radius: constraints.biggest.shortestSide / 2,
                            showLoading: true,
                          ),
                          ...overlays,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
