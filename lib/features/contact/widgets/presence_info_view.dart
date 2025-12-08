import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${l10n.presence_infoView_device} ${presenceInfo.indexOf(info) + 1}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(l10n.presence_infoView_available, style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(width: 4),
                    Text(
                      info.available ? l10n.presence_infoView_available_true : l10n.presence_infoView_available_false,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                if (info.note.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(l10n.presence_infoView_note, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      Text(info.note, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                if (info.activities.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(l10n.presence_infoView_activity, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      Text(info.activities.first.name, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                if (info.statusIcon != null && info.statusIcon!.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(l10n.presence_infoView_statusIcon, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      Text(info.statusIcon!, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                if (info.timeOffsetMin != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(l10n.presence_infoView_timeZone, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      Text(
                        'UTC${info.timeOffsetMin! >= 0 ? '+' : ''}${(info.timeOffsetMin! ~/ 60)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                if (info.timestamp != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(l10n.presence_infoView_updated, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat.yMd().add_Hm().format(info.timestamp!.toLocal()),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                if (info.device != null && info.device!.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(l10n.presence_infoView_client, style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      Text(info.device!, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                // const Divider(),
              ],
            ),
        ],
      ),
    );
  }
}
