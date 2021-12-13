import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../recent.dart';
import 'recent_scaffold.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen(this.recent, {Key? key}) : super(key: key);

  final Recent recent;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return RecentCubit(
          recent,
          recentsRepository: context.read<RecentsRepository>(),
        )..getRecentHistory();
      },
      child: const RecentScaffold(),
    );
  }
}
