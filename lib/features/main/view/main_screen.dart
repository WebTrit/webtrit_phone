import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.body, required this.bottomNavigationBar})
    : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final BottomNavigationBar bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(body: body, bottomNavigationBar: bottomNavigationBar);

    return BlocListener<MainBloc, MainBlocState>(
      listener: (context, state) async {
        final coreVersionState = state.coreVersionState;

        // Capture the blocs while this context is mounted: the gate dialog outlives
        // MainScreen during logout, so its button closures must not read a possibly
        // defunct context. Dismissal lives inside the dialog; here we only wire the
        // pure update/logout intents.
        final appBloc = context.read<AppBloc>();
        final mainBloc = context.read<MainBloc>();

        if (coreVersionState is AppVersionUnsupported) {
          final canUpdateApp = coreVersionState.updateStoreUrl != null;

          AppUpdateRequiredDialog.show(
            context,
            coreVersionState.currentVersion,
            coreVersionState.minSupportedVersion,
            onUpdatePressed: canUpdateApp
                ? () => mainBloc.add(MainBlocAppUpdatePressed(coreVersionState.updateStoreUrl!))
                : null,
            onLogoutPressed: () => appBloc.add(const AppLogoutRequested(reason: AppLogoutReason.userRequest)),
          );
        } else if (coreVersionState is Incompatible) {
          final canUpdateApp = coreVersionState.updateStoreUrl != null;

          CompatibilityIssueDialog.show(
            context,
            coreVersionState.currentVersion,
            coreVersionState.supportedConstraint,
            onUpdatePressed: canUpdateApp
                ? () => mainBloc.add(MainBlocAppUpdatePressed(coreVersionState.updateStoreUrl!))
                : null,
            onLogoutPressed: () => appBloc.add(const AppLogoutRequested(reason: AppLogoutReason.userRequest)),
          );
        }
      },
      child: scaffold,
    );
  }
}
