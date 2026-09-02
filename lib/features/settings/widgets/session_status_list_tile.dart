import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../../microphone_status/microphone_status.dart';
import '../settings.dart';

class SessionStatusListTile extends StatelessWidget {
  const SessionStatusListTile({
    super.key,
    required this.status,
    required this.registered,
    this.updating = false,
    this.topIssue,
    this.info,
    this.onTap,
    this.contentPadding,
  });

  final SessionStatus status;

  /// Last known server-side registration setting; feeds the status subtitle so
  /// a deliberately unregistered session is not described as a fault.
  final bool registered;

  /// A registration change is in flight, so an unregistered session is a
  /// normal transition rather than a problem.
  final bool updating;

  /// Most severe active side issue, surfaced as a warning subtitle. It outranks
  /// the descriptive status subtitle, which is hidden while an issue is shown.
  final SessionIssue? topIssue;
  final UserInfo? info;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            // The row is the button. It used to be a bare gesture detector
            // wrapped around the whole column, which answered a tap without
            // ever saying it could be pressed - and gave no ripple either.
            SemanticAction(
              identifier: sessionStatusTileId,
              child: ListTile(
                onTap: onTap,
                contentPadding: contentPadding,
                leading: CircleAvatar(
                  radius: 12,
                  backgroundColor: themeData.colorScheme.surface.withValues(alpha: 0.5),
                  child: CircleAvatar(radius: 4, backgroundColor: status.color(context)),
                ),
                title: Text(status.l10n(context), key: status.key, style: themeData.textTheme.labelLarge),
                // A single subtitle line in every state: the row must keep its
                // height when the status changes, or the whole list below jumps.
                // The plain caption takes the list default so it reads exactly
                // like the supporting line of the row below it; a warning only
                // recolors that same style, or the two rows drift apart in size.
                // Both are captions the reader needs in full - a warning most
                // of all - so what does not fit is shown by sliding rather than
                // dropped behind an ellipsis.
                subtitle: switch (topIssue) {
                  final SessionIssue issue => OverflowMarquee(
                    child: Text(
                      issue.caption(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: themeData.textTheme.bodyMedium?.copyWith(color: issue.color(context)),
                    ),
                  ),
                  null => OverflowMarquee(
                    child: Text(
                      status.subtitleL10n(context, registered: registered, updating: updating),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                },
              ),
            ),
            BlocBuilder<MicrophoneStatusBloc, MicrophoneStatusState>(
              builder: (context, microphoneStatusState) {
                return Visibility(
                  visible:
                      microphoneStatusState.microphonePermissionGranted != null &&
                      !microphoneStatusState.microphonePermissionGranted!,
                  // The warning leads where it can be dealt with, same as the
                  // row above it: it was part of the gesture area that used to
                  // cover the whole thing, and moving the tap onto the row
                  // alone would have quietly taken that away.
                  // The margin sits outside the tap target, and the splash
                  // takes the chip's own shape - inside an opaque container it
                  // would be painted underneath it, leaving a rectangular halo
                  // in the margin as the only feedback.
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: SemanticAction.button(
                      child: InkWell(
                        onTap: onTap,
                        customBorder: const StadiumBorder(),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: ShapeDecoration(color: themeData.colorScheme.error, shape: const StadiumBorder()),
                          child: Row(
                            spacing: 5,
                            children: [
                              Icon(Icons.warning_amber, color: themeData.colorScheme.onError, size: 14),
                              Flexible(
                                child: Text(
                                  context.l10n.settings_missingMicrophoneIndicator_title,
                                  style: themeData.textTheme.bodySmall?.copyWith(color: themeData.colorScheme.onError),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
