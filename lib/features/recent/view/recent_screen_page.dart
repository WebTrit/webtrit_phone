import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class RecentScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RecentScreenPage(@pathParam this.recentId);

  final int recentId;

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final widget = RecentScreen(
      videoVisible: featureAccess.callFeature.enableVideo,
    );
    var provider = BlocProvider(
      create: (context) {
        return RecentBloc(
          recentId,
          recentsRepository: context.read<RecentsRepository>(),
          dateFormat: AppTime().formatDateTime(true),
        )..add(const RecentStarted());
      },
      child: widget,
    );
    return provider;
  }
}
