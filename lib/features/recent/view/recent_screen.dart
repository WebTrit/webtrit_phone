import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
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
          final recents = state.recents;
          if (recent == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final themeData = Theme.of(context);
            final buttonStyle = OutlinedButton.styleFrom(
              side: BorderSide(color: themeData.colorScheme.surfaceTint),
              elevation: 0,
            );
            return ListView(
              children: [
                Padding(
                  padding: kAllPadding16,
                  child: LeadingAvatar(
                    username: recent.name,
                    radius: 50,
                  ),
                ),
                CopyToClipboard(
                  data: recent.number,
                  child: Text(
                    recent.number,
                    style: themeData.textTheme.labelLarge?.copyWith(
                      color: themeData.colorScheme.outlineVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  recent.name,
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
                      style: buttonStyle,
                      child: const Icon(Icons.call),
                      onPressed: () => _initiateCall(context, recent, false),
                    ),
                    if (videoVisible) ...[
                      const SizedBox(
                        width: 16,
                      ),
                      OutlinedButton(
                        style: buttonStyle,
                        child: const Icon(Icons.videocam),
                        onPressed: () => _initiateCall(context, recent, true),
                      ),
                    ]
                  ],
                ),
                const Divider(
                  height: 16,
                ),
                if (recents == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  for (final recent in recents)
                    RecentHistoryTile(
                      recent: recent,
                      dateFormat: context.read<RecentBloc>().dateFormat,
                      onDeleted: (recent) {
                        context.showSnackBar(context.l10n.recents_snackBar_deleted(recent.name));

                        context.read<RecentBloc>().add(RecentDeleted(recent));
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
      number: recent.number,
      displayName: recent.name,
      video: video,
    ));
    context.maybePop();
  }
}
