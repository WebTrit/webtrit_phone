import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';

class CallProcessingStatusView extends StatelessWidget {
  final CallProcessingStatus? status;
  final Color? color;

  const CallProcessingStatusView({super.key, required this.status, this.color});

  @override
  Widget build(BuildContext context) {
    if (status == null) return const SizedBox();

    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;

    final statusStyle = textTheme.labelLarge!.copyWith(color: color);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        status!.l10n(context),
        style: statusStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
