import 'package:clock/clock.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class PresenceInfoView extends StatelessWidget {
  const PresenceInfoView({required this.presenceInfo, super.key});

  final List<PresenceInfo> presenceInfo;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Text(
            l10n.presence_infoView_title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          for (final info in presenceInfo)
            Builder(
              builder: (context) {
                final maybeActivityText = info.activities.isNotEmpty
                    ? info.activities.first.l10n(l10n)
                    : (info.available ? l10n.presence_infoView_available_true : l10n.presence_infoView_available_false);

                final shouldDisplayNote = info.note.isNotEmpty && info.note.trim() != maybeActivityText;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 2,
                  children: [
                    if (presenceInfo.length > 1)
                      Text(
                        '${l10n.presence_infoView_device} ${presenceInfo.indexOf(info) + 1}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: SipPresenceIndicator(
                            presenceInfo: presenceInfo,
                            presenceRect: Rect.fromLTWH(0, 0, 16, 16),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(maybeActivityText, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),

                    if (shouldDisplayNote)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(child: Text(info.note, style: Theme.of(context).textTheme.bodySmall)),
                          const SizedBox(width: 4),

                          if (info.statusIcon != null && info.statusIcon!.isNotEmpty)
                            Text(info.statusIcon!, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),

                    if (info.timeOffsetMin != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(l10n.presence_infoView_localTime, style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat.Hm().format(clock.now().toUtc().add(Duration(minutes: info.timeOffsetMin ?? 0))),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            ' (UTC${info.timeOffsetMin! >= 0 ? '+' : ''}${(info.timeOffsetMin! ~/ 60)})',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),

                    if (info.timestamp != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(l10n.presence_infoView_updated, style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(width: 4),

                          AgoTicker(
                            timestamp: info.timestamp!,
                            builder: (ago) => Text(ago, style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                      ),
                    if (info.device != null && info.device!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text(info.device!, style: Theme.of(context).textTheme.bodySmall)],
                      ),
                    // const Divider(),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
