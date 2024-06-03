import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/notifications/notifications.dart';

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

  Future navigateBack() async {
    if (router.canPop(ignorePagelessRoutes: true)) {
      // For case when app is launched with the autoprovision screen on top of any screen.
      await router.pop();
    } else {
      // For the case when the app is launched with the autoprovision screen as initial route.
      await router.replace(const MainShellRoute());
    }
  }

  void onError(BuildContext context, Error state) async {
    await navigateBack();
    final error = state.error;
    if (error is RequestFailure && error.statusCode == 401) {
      nfnBloc.add(const NotificationSubmitted(InvalidAutoProvisioningToken()));
    } else {
      nfnBloc.add(NotificationSubmitted(DefaultErrorNotification(state.error)));
    }
  }

  void onConfirmationNeeded() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => const ReloginDialog(),
      useRootNavigator: false,
    );

    // Drop the result if the screen was disposed during the dialog.
    if (!mounted) return;

    if (confirm == true) apnCubit.confirmReplaceSession();
    if (confirm != true) navigateBack();
  }

  void onSessionCreated(SessionCreated state) async {
    if (router.canPop()) {
      final loginUnderneeth = router.stack.first.name == LoginRouterPageRoute.name;
      final mainShellUnderneeth = router.stack.first.name == MainShellRoute.name;

      // For case when app is launched with the autoprovision screen on top of the login screen.
      if (loginUnderneeth) {
        await router.pop();
        appBloc.add(AppLogined(coreUrl: state.coreUrl, token: state.token, tenantId: state.tenantId));
      }

      // For case when app is launched with the autoprovision screen on top of the main shell.
      // To avoid callkeep and signaling panic it required full sequence of dispose and init.
      if (mainShellUnderneeth) {
        await router.pop();
        appBloc.add(const AppLogouted());
        await appBloc.stream.firstWhere((element) => element.token == null);
        appBloc.add(AppLogined(coreUrl: state.coreUrl, token: state.token, tenantId: state.tenantId));
        await appBloc.stream.firstWhere((element) => element.token == state.token);
      }
    } else {
      // For the case when the app is launched with the autoprovision screen as initial route.
      appBloc.add(AppLogined(coreUrl: state.coreUrl, token: state.token, tenantId: state.tenantId));
      await appBloc.stream.firstWhere((element) => element.token == state.token);
      // Then will be redirected by router reevaluation and redirect inside [onAutoprovisionScreenPageRouteGuardNavigation]
    }

    nfnBloc.add(const NotificationSubmitted(SuccesfulUsedAutoProvisioningToken()));
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => apnCubit.init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AutoprovisionCubit, AutoprovisionState>(
        listener: (context, state) {
          if (state is Error) onError(context, state);
          if (state is SessionCreated) onSessionCreated(state);
          if (state is ReplaceConfirmationNeeded) onConfirmationNeeded();
        },
        builder: (context, state) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
