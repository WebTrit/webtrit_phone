import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/call/call.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../bloc/bloc.dart';
import '../models/models.dart';
import '../utils/utils.dart';

import 'voicemail_screen.dart';

@RoutePage()
class VoicemailScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailScreenPage();

  @override
  Widget build(BuildContext context) {
    final secureStorage = context.read<SecureStorage>();
    final appTime = context.read<AppTime>();
    final appPath = context.read<AppPath>();
    final callBloc = context.read<CallBloc>();
    final notificationsBloc = context.read<NotificationsBloc>();

    final mediaHeaders = MediaHeadersBuilder(secureStorage: secureStorage).build();

    final screenContext = VoicemailScreenContext(
      mediaCacheBasePath: appPath.mediaCacheBasePath,
      dateFormat: appTime.formatDateTime(true),
      mediaHeaders: mediaHeaders,
      cacheManagementAvailable: context.read<AppCacheManager>().sections.isNotEmpty,
    );

    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => VoicemailCubit(
            repository: context.read<VoicemailRepository>(),
            onCallStarted: (number) => callBloc.add(CallControlEvent.started(number: number, video: false)),
            onSubmitNotification: (n) => notificationsBloc.add(NotificationsSubmitted(n)),
          ),
        ),
        Provider<VoicemailScreenContext>(create: (_) => screenContext),
        ChangeNotifierProvider(create: (_) => VoicemailPlaybackController()),
      ],
      child: const VoicemailScreen(),
    );
  }
}
