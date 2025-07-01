import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class CallLogScreen extends StatelessWidget {
  const CallLogScreen({
    super.key,
    required this.videoVisible,
  });

  final bool videoVisible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CallLogBloc, CallLogState>(builder: (context, state) {
        final number = state.number;
        final contact = state.contact;
        final callLog = state.callLog;

        final title = contact?.displayTitle ?? number;
        final email = contact?.emails.firstOrNull?.address;

        final themeData = Theme.of(context);
        final outlinedButtonStyles = themeData.extension<OutlinedButtonStyles>();

        return ListView(
          children: [
            Container(
              padding: kAllPadding16,
              alignment: Alignment.center,
              child: LeadingAvatar(
                username: title,
                thumbnail: contact?.thumbnail,
                thumbnailUrl: gravatarThumbnailUrl(email),
                registered: contact?.registered,
                radius: 50,
              ),
            ),
            CopyToClipboard(
              data: number,
              child: Text(
                number,
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
                  onPressed: () => _initiateCall(context, number, contact?.maybeName, false),
                ),
                if (videoVisible) ...[
                  const SizedBox(
                    width: 16,
                  ),
                  OutlinedButton(
                    style: outlinedButtonStyles?.neutral,
                    child: const AppIcon(Icons.videocam),
                    onPressed: () => _initiateCall(context, number, contact?.maybeName, true),
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
                CallLogHistoryTile(
                  callLogEntry: entry,
                  dateFormat: context.read<CallLogBloc>().dateFormat,
                  onDeleted: (callLogEntry) {
                    context.showSnackBar(context.l10n.recents_snackBar_deleted(entry.number));
                    context.read<CallLogBloc>().add(CallLogEntryDeleted(entry));
                  },
                )
          ],
        );
      }),
    );
  }

  void _initiateCall(BuildContext context, String number, String? name, bool video) {
    final callBloc = context.read<CallBloc>();
    callBloc.add(CallControlEvent.started(number: number, displayName: name, video: video));
    context.maybePop();
  }
}
