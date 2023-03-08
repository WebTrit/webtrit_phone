import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recent.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({
    super.key,
  });

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
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LeadingAvatar(
                    username: recent.name,
                    radius: 50,
                  ),
                ),
                Text(
                  recent.name,
                  style: themeData.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
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
}
