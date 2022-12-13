import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../recent.dart';
import 'recent_scaffold.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen(
    this.recentId, {
    super.key,
  });

  final RecentId recentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RecentBloc(
          recentId,
          recentsRepository: context.read<RecentsRepository>(),
        )..add(const RecentStarted());
      },
      child: const RecentScaffold(),
    );
  }
}
