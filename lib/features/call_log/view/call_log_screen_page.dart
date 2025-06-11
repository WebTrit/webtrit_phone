import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class CallLogScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CallLogScreenPage(@pathParam this.number);

  final String number;

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final widget = CallLogScreen(
      videoVisible: featureAccess.callFeature.callConfig.isVideoCallEnabled,
    );
    var provider = BlocProvider(
      create: (context) {
        return CallLogBloc(
          number,
          callLogsRepository: context.read<CallLogsRepository>(),
          recentsRepository: context.read<RecentsRepository>(),
          contactRepository: context.read<ContactsRepository>(),
          dateFormat: AppTime().formatDateTime(true),
        )..add(const CallLogStarted());
      },
      child: widget,
    );
    return provider;
  }
}
