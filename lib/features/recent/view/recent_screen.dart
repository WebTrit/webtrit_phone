import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({
    super.key,
    required this.videoVisible,
  });

  final bool videoVisible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RecentBloc, RecentState>(
        builder: (context, state) {
          final recent = state.recent;

          if (recent == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final logEntry = recent.callLogEntry;
            final contact = recent.contact;

            final callLog = state.callLog;

            final title = contact?.displayTitle ?? logEntry.number;

            final themeData = Theme.of(context);
            final outlinedButtonStyles = themeData.extension<OutlinedButtonStyles>();

            return ListView(
              children: [
                Padding(
                  padding: kAllPadding16,
                  child: LeadingAvatar(
                    username: title,
                    thumbnail: contact?.thumbnail,
                    thumbnailUrl: contact?.thumbnailUrl,
                    registered: contact?.registered,
                    radius: 50,
                  ),
                ),
                CopyToClipboard(
                  data: logEntry.number,
                  child: Text(
                    logEntry.number,
                    style: themeData.textTheme.labelLarge?.copyWith(
                      color: themeData.colorScheme.outlineVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  title,
                  style: themeData.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      style: outlinedButtonStyles?.neutral,
                      child: const AppIcon(Icons.call),
                      onPressed: () => _initiateCall(context, recent, false),
                    ),
                    if (videoVisible) ...[
                      const SizedBox(
                        width: 16,
                      ),
                      OutlinedButton(
                        style: outlinedButtonStyles?.neutral,
                        child: const AppIcon(Icons.videocam),
                        onPressed: () => _initiateCall(context, recent, true),
                      ),
                    ]
                  ],
                ),
                const Divider(
                  height: 16,
                ),
                if (callLog == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  for (final entry in callLog)
                    RecentHistoryTile(
                      callLogEntry: entry,
                      dateFormat: context.read<RecentBloc>().dateFormat,
                      onDeleted: (callLogEntry) {
                        context.showSnackBar(context.l10n.recents_snackBar_deleted(entry.number));
                        context.read<RecentBloc>().add(CallLogEntryDeleted(entry));
                      },
                    )
              ],
            );
          }
        },
      ),
    );
  }

  void _initiateCall(BuildContext context, Recent recent, bool video) {
    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.started(
      number: recent.callLogEntry.number,
      displayName: recent.contact?.maybeName,
      video: video,
    ));
    context.maybePop();
  }
}
