import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/incoming_call_type/incoming_call_type_repository.dart';

import '../bloc/network_cubit.dart';

@RoutePage()
class NetworkScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NetworkScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = NetworkScreen();
    final featureAccess = context.read<FeatureAccess>();

    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => NetworkCubit(
            featureAccess.callFeature.callTriggerConfig,
            context.read<DeviceInfo>(),
            context.read<IncomingCallTypeRepository>(),
            BackgroundSignalingBootstrapService(),
          ),
        ),
      ],
      child: widget,
    );
  }
}
