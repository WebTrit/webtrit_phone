import 'package:auto_route/auto_route.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';

import '../number_cdrs_log.dart';

@RoutePage()
class NumberCdrsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NumberCdrsScreenPage(@pathParam this.number);

  final String number;

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();
    final videoVisible = featureAccess.callFeature.callConfig.isVideoCallEnabled;
    return BlocProvider(
      create: (context) => NumberCdrsLogCubit(
        number,
        context.read<CdrsLocalRepository>(),
        context.read<CdrsRemoteRepository>(),
        (n) => context.read<NotificationsBloc>().add(NotificationsSubmitted(n)),
      )..init(),
      child: NumberCdrsScreen(title: const Text(EnvironmentConfig.APP_NAME), videoVisible: videoVisible),
    );
  }
}
