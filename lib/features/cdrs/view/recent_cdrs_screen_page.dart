import 'package:auto_route/auto_route.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';

import '../cdrs.dart';

@RoutePage()
class RecentCdrsScreenPage extends StatelessWidget {
  const RecentCdrsScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FullRecentCdrsCubit(
            context.read<CdrsLocalRepository>(),
            context.read<CdrsRemoteRepository>(),
            (n) => context.read<NotificationsBloc>().add(NotificationsSubmitted(n)),
          )..init(),
        ),
        BlocProvider(
          create: (context) => MissedRecentCdrsCubit(
            context.read<CdrsLocalRepository>(),
            context.read<CdrsRemoteRepository>(),
            (n) => context.read<NotificationsBloc>().add(NotificationsSubmitted(n)),
          )..init(),
        ),
      ],
      child: RecentCdrsScreen(
        title: const Text(EnvironmentConfig.APP_NAME),
        transferEnabled: featureAccess.callFeature.callConfig.isBlindTransferEnabled,
        videoEnabled: featureAccess.callFeature.callConfig.isVideoCallEnabled,
        chatsEnabled: featureAccess.messagingFeature.chatsPresent,
        smssEnabled: featureAccess.messagingFeature.smsPresent,
      ),
    );
  }
}
