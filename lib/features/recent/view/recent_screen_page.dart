import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class RecentScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RecentScreenPage(@pathParam this.callId);

  final int callId;

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final widget = RecentScreen(
      videoVisible: featureAccess.callFeature.callConfig.isVideoCallEnabled,
    );
    var provider = BlocProvider(
      create: (context) {
        return RecentBloc(
          callId,
          callLogsRepository: context.read<CallLogsRepository>(),
          recentsRepository: context.read<RecentsRepository>(),
          dateFormat: AppTime().formatDateTime(true),
        )..add(const RecentStarted());
      },
      child: widget,
    );
    return provider;
  }
}
