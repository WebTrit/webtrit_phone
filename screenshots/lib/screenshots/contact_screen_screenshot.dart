import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'package:screenshots/mocks/mocks.dart';

class ContactScreenScreenshot extends StatefulWidget {
  const ContactScreenScreenshot({super.key});

  @override
  State<ContactScreenScreenshot> createState() => _ContactScreenScreenshotState();
}

class _ContactScreenScreenshotState extends State<ContactScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return MultiProvider(
              providers: [
                Provider<ContactsRepository>(create: (_) => MockContactsRepository()),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<ContactBloc>(create: (_) => MockContactBloc.contactScreen()),
                  BlocProvider<CallBloc>(create: (_) => MockCallBloc.mainScreen()),
                  BlocProvider<CallRoutingCubit>(create: (_) => MockCallRoutingCubit.initial()),
                  BlocProvider<UserInfoCubit>(create: (_) => MockUserInfoCubit.initial()),
                  BlocProvider<NotificationsBloc>(create: (_) => MockNotificationsBloc.initial()),
                ],
                child: const ContactScreen(
                  enableAppBarChat: true,
                  enableTileFavorite: true,
                  enableTileVoiceCall: true,
                  enableTileVideoCall: true,
                  enableTileSms: true,
                  enableTileChat: true,
                  enableTileTransfer: false,
                  enableTileCallLog: true,
                  enableTileEmail: true,
                  useCdrsForHistory: false,
                ),
              ),
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          fullscreenDialog: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
