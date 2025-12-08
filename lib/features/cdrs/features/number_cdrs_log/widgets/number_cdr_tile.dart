import 'package:flutter/material.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

class NumberCdrTile extends StatelessWidget {
  const NumberCdrTile({required this.cdr, super.key});

  final CdrRecord cdr;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 32)],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Row(
          children: [
            Icon(
              cdr.direction.icon(cdr.status == CdrStatus.accepted),
              size: 16,
              color: cdr.direction == CallDirection.incoming ? Colors.blue : Colors.green,
            ),
            const SizedBox(width: 4),
            Flexible(child: Text(cdr.duration.format())),
          ],
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(cdr.connectTime.toHHmm),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(cdr.connectTime.toDayOfMonth),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
