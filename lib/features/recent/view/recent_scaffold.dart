import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../recent.dart';

class RecentScaffold extends StatelessWidget {
  const RecentScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ExtAppBar(),
      body: BlocBuilder<RecentCubit, RecentState>(
        builder: (context, state) {
          final themeData = Theme.of(context);
          final recent = state.recent;
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
                style: themeData.textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 16,
              ),
              if (state is! RecentSuccess)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                for (final recent in state.recents)
                  RecentHistoryTile(
                    recent: recent,
                    onDeleted: (recent) {
                      context.showSnackBar('"${recent.number}" deleted');

                      context.read<RecentCubit>().delete(recent);
                    },
                  )
            ],
          );
        },
      ),
    );
  }
}
