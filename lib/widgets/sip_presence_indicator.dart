import 'package:flutter/material.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';

/// The status mark for a contact whose status has actually arrived.
///
/// Resolves the signals into one state and hands it to [PresenceMark], which
/// is what draws every mark in the app - so a mark built from a different
/// signal (registration, say) looks and sizes exactly the same.
class SipPresenceIndicator extends StatelessWidget {
  const SipPresenceIndicator({
    super.key,
    required this.presenceInfo,
    required this.dialogInfo,
    required Rect presenceRect,
  }) : _presenceRect = presenceRect;

  final List<PresenceInfo> presenceInfo;
  final List<DialogInfo> dialogInfo;
  final Rect _presenceRect;

  @override
  Widget build(BuildContext context) {
    return PresenceMark(
      presence: ContactPresence.resolve(presenceInfo: presenceInfo, dialogInfo: dialogInfo),
      presenceRect: _presenceRect,
    );
  }
}

/// One state, drawn.
///
/// Two axes carry the answer, so neither has to be read alone: the colour says
/// whether to call now, the glyph says what is going on. The glyph is the half
/// that survives for anyone who cannot tell the fills apart, which is why
/// every state has one.
class PresenceMark extends StatelessWidget {
  const PresenceMark({super.key, required this.presence, required Rect presenceRect}) : _presenceRect = presenceRect;

  final ContactPresence presence;
  final Rect _presenceRect;

  @override
  Widget build(BuildContext context) {
    final badge = LeadingAvatarStyles.of(context).presenceBadge!;
    final colors = Theme.of(context).colorScheme;

    final color = switch (presence) {
      ContactPresence.onCall || ContactPresence.busy => badge.busyColor,
      ContactPresence.onCallReported || ContactPresence.available => badge.availableColor,
      ContactPresence.away || ContactPresence.unavailable => badge.unavailableColor,
    };

    // No mark is ever left blank: a circle this size with nothing inside reads
    // as an unfinished element rather than a status. Twelve activities collapse
    // into a handful of glyphs on purpose - the mark is about ten points
    // across, where only the simplest silhouette survives, and the exact
    // wording a contact chose is spoken instead.
    final glyph = switch (presence) {
      ContactPresence.onCall || ContactPresence.onCallReported => Icons.phone_in_talk_rounded,
      ContactPresence.busy => Icons.remove_rounded,
      ContactPresence.away => Icons.schedule_rounded,
      ContactPresence.available => Icons.check_rounded,
      ContactPresence.unavailable => Icons.power_settings_new_rounded,
    };

    // The glyph sits inside the mark rather than on top of it: an icon laid
    // over the dot cuts into its outline and the mark reads as smaller and
    // busier than it is. Ring and glyph are proportional to the mark, so the
    // availability colour keeps the same share of it at every size - this
    // widget is also rendered at 16 px in the presence pickers, where a fixed
    // ring plus a fixed glyph would leave the colour a sliver.
    final side = _presenceRect.width;
    final separator = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: separator, width: side * 0.1),
      ),
      child: Center(
        child: Icon(glyph, color: badge.iconColor ?? colors.surface, size: side * 0.55),
      ),
    );
  }
}
