import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/view_params/app_bar_params.dart';

import 'package:screenshots/mocks/mocks.dart';

class RecentCdrsScreenScreenshot extends StatelessWidget {
  const RecentCdrsScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarParams(
      systemNotificationsEnabled: false,
      pullableCalls: const [],
      child: MultiProvider(
        providers: [
          Provider<ContactsRepository>(create: (_) => MockContactsRepository()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<FullRecentCdrsCubit>(create: (_) => MockFullRecentCdrsCubit.withCdrs()),
            BlocProvider<MissedRecentCdrsCubit>(create: (_) => MockMissedRecentCdrsCubit.withRecords()),
            BlocProvider<CallBloc>(create: (_) => MockCallBloc.mainScreen()),
            BlocProvider<CallRoutingCubit>(create: (_) => MockCallRoutingCubit.initial()),
            BlocProvider<UserInfoCubit>(create: (_) => MockUserInfoCubit.initial()),
            BlocProvider<MicrophoneStatusBloc>(create: (_) => MockMicrophoneStatusBloc.initial(isGranted: true)),
            BlocProvider<SessionStatusCubit>(create: (_) => MockSessionStatusCubit.initial()),
          ],
          child: const RecentCdrsScreen(
            transferEnabled: false,
            videoEnabled: true,
            chatsEnabled: false,
            smssEnabled: false,
          ),
        ),
      ),
    );
  }
}
