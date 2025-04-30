import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../bloc/voicemail_cubit.dart';
import '../models/models.dart';
import '../utils/utils.dart';

import 'voicemail_screen.dart';

@RoutePage()
class VoicemailScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailScreenPage();

  @override
  Widget build(BuildContext context) {
    final voicemailRepository = context.read<VoicemailRepository>();
    final secureStorage = context.read<SecureStorage>();
    final notificationsBloc = context.read<NotificationsBloc>();
    final appTime = context.read<AppTime>();
    final appPath = context.read<AppPath>();
    final callBloc = context.read<CallBloc>();

    final mediaHeaders = MediaHeadersBuilder(secureStorage: secureStorage).build();

    final screenContext = VoicemailScreenContext(
      mediaCacheBasePath: appPath.mediaCacheBasePath,
      dateFormat: appTime.formatDateTime(true),
      mediaHeaders: mediaHeaders,
    );

    return BlocProvider(
      create: (context) => VoicemailCubit(
        repository: voicemailRepository,
        onCallStarted: (number) => callBloc.add(CallControlEvent.started(number: number, video: false)),
        onSubmitNotification: (n) => notificationsBloc.add(NotificationsSubmitted(n)),
      ),
      child: Provider<VoicemailScreenContext>(
        create: (context) => screenContext,
        child: const VoicemailScreen(),
      ),
    );
  }
}
