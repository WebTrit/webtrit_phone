import 'package:flutter/material.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:screenshots/data/data.dart';

/// Where a Gravatar photo is drawn in the app, at the sizes the app draws it.
///
/// A url is an image cache key, so the size a place asks for decides both how sharp the
/// photo looks there and whether it shares a download with the places around it. This
/// page puts every such place side by side with the size it paints and the url it asks
/// for, so a new call site can be compared against the ones that already exist.
class GravatarUsageScreenshot extends StatelessWidget {
  const GravatarUsageScreenshot({super.key});

  /// Radius, where it is written, and what the place is.
  static const _usages = <_Usage>[
    _Usage(12, 'group_contacts_selection_view.dart', 'chosen member in the group builder'),
    _Usage(
      20,
      'recent_tile.dart, contact_tile.dart, favorite_tile.dart, cdr_tile.dart',
      'a list row - the theme default',
    ),
    _Usage(20, 'main_app_bar.dart', 'the account button, sized from its icon box'),
    _Usage(24, 'sms_conversation_builder_view.dart', 'a row of the conversation builder'),
    _Usage(37, 'call_active_thumbnail.dart', 'the minimized call window'),
    _Usage(50, 'contact_screen.dart, call_log_screen.dart, number_cdrs_screen.dart', 'a screen header'),
    _Usage(115, 'call_controls.dart', 'the call screen: 30% of the shortest side'),
  ];

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);

    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          itemCount: _usages.length,
          separatorBuilder: (context, index) => const Divider(height: 32),
          itemBuilder: (context, index) => _Row(usage: _usages[index], devicePixelRatio: devicePixelRatio),
        ),
      ),
    );
  }
}

class _Usage {
  const _Usage(this.radius, this.where, this.what);

  final double radius;

  /// The file the size is written in.
  final String where;

  /// What the place is, in words.
  final String what;
}

class _Row extends StatelessWidget {
  const _Row({required this.usage, required this.devicePixelRatio});

  final _Usage usage;
  final double devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diameter = usage.radius * 2;
    final devicePixels = diameter * devicePixelRatio;
    final requested = GravatarUrl.requestSize(devicePixels);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LeadingAvatar(
          username: '${userInfo.firstName} ${userInfo.lastName}',
          thumbnailUrl: GravatarUrl.forEmail(userInfo.email),
          radius: usage.radius,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(usage.what, style: theme.textTheme.titleSmall),
              const SizedBox(height: 2),
              Text(
                usage.where,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline, fontFamily: 'monospace'),
              ),
              const SizedBox(height: 6),
              Text(
                'radius ${usage.radius.toStringAsFixed(0)} · '
                '${diameter.toStringAsFixed(0)} dp · '
                '${devicePixels.toStringAsFixed(0)} px at ${devicePixelRatio}x → s=$requested',
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
