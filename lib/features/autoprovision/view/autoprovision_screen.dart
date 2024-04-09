import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/autoprovision/cubit/autoprovision_cubit.dart';
import 'package:webtrit_phone/features/autoprovision/widgets/relogin_dialog.dart';
import 'package:webtrit_phone/features/notifications/notifications.dart';

class AutoprovisionScreen extends StatelessWidget {
  const AutoprovisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final nfnBloc = context.read<NotificationsBloc>();
    final apnCubit = context.read<AutoprovisionCubit>();
    final router = context.router;

    onError(BuildContext context, Error state) {
      router.navigate(const AppShellRoute());
      nfnBloc.add(NotificationsMessaged(DefaultErrorNotification(state.error)));
    }

    onConfirmationNeeded(BuildContext context) async {
      final result = await showDialog(context: context, builder: (context) => const ReloginDialog());
      if (result == true) {
        apnCubit.confirmReplaceSession();
      } else {
        router.navigate(const AppShellRoute());
      }
    }

    onSessionCreated(BuildContext context, SessionCreated state) {
      appBloc.add(AppLogined(coreUrl: state.coreUrl, token: state.token, tenantId: state.tenantId ?? ''));
    }

    return Scaffold(
      body: BlocConsumer<AutoprovisionCubit, AutoprovisionState>(
        listener: (context, state) {
          if (state is Error) onError(context, state);
          if (state is SessionCreated) onSessionCreated(context, state);
          if (state is ReplaceConfirmationNeeded) onConfirmationNeeded(context);
        },
        builder: (context, state) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
