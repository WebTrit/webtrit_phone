import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../bloc/voicemail_cubit.dart';
import 'voicemail_screen.dart';

@RoutePage()
class VoicemailScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = VoicemailScreen();
    final secureStorage = context.read<SecureStorage>();
    final notificationsBloc = context.read<NotificationsBloc>();

    //  TODO(Serdun): Move to better place
    final mediaHeaders = {
      'authorization': 'Bearer ${secureStorage.readToken()}',
    };

    return BlocProvider(
      create: (context) => VoicemailCubit(
        repository: context.read<VoicemailRepository>(),
        mediaHeaders: mediaHeaders,
        onCallStarted: (number) => context.read<CallBloc>().add(CallControlEvent.started(number: number, video: false)),
        onSubmitNotification: (n) => notificationsBloc.add(NotificationsSubmitted(n)),
      ),
      child: widget,
    );
  }
}
