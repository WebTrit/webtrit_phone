import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/autoprovision/cubit/autoprovision_cubit.dart';
import 'package:webtrit_phone/features/autoprovision/widgets/relogin_dialog.dart';
import 'package:webtrit_phone/features/notifications/notifications.dart';

class AutoprovisionScreen extends StatefulWidget {
  const AutoprovisionScreen({super.key});

  @override
  State<AutoprovisionScreen> createState() => _AutoprovisionScreenState();
}

class _AutoprovisionScreenState extends State<AutoprovisionScreen> {
  late final appBloc = context.read<AppBloc>();
  late final nfnBloc = context.read<NotificationsBloc>();
  late final apnCubit = context.read<AutoprovisionCubit>();
  late final router = context.router;

  navigateBack() async {
    if (router.canPop(ignorePagelessRoutes: true)) {
      await router.pop();
    } else {
      // For the case when the app is launched with the autoprovision screen as initial route.
      await router.replaceAll([const AppShellRoute()]);
    }
  }

  onError(BuildContext context, Error state) async {
    await navigateBack();
    nfnBloc.add(NotificationsMessaged(DefaultErrorNotification(state.error)));
  }

  onConfirmationNeeded(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) => const ReloginDialog(),
      useRootNavigator: false,
    );

    if (!mounted) return;

    if (result == true) {
      apnCubit.confirmReplaceSession();
    } else {
      navigateBack();
    }
  }

  onSessionCreated(BuildContext context, SessionCreated state) async {
    await navigateBack();
    appBloc.add(AppLogined(coreUrl: state.coreUrl, token: state.token, tenantId: state.tenantId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
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
