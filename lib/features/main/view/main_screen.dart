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

        // The gate dialog is pushed on the root navigator (showDialog defaults to
        // useRootNavigator: true), so dismissal must target the root navigator -
        // Navigator.of(context) here would resolve the nested auto_route navigator.
        // Capture the blocs and navigator while this context is still mounted: the
        // dialog outlives MainScreen during logout, so its button closures must not
        // touch a possibly-defunct context.
        final appBloc = context.read<AppBloc>();
        final mainBloc = context.read<MainBloc>();
        final rootNavigator = Navigator.of(context, rootNavigator: true);

        if (coreVersionState is AppVersionUnsupported) {
          final canUpdateApp = coreVersionState.updateStoreUrl != null;

          AppUpdateRequiredDialog.show(
            context,
            coreVersionState.currentVersion,
            coreVersionState.minSupportedVersion,
            onUpdatePressed: canUpdateApp
                ? () => mainBloc.add(MainBlocAppUpdatePressed(coreVersionState.updateStoreUrl!))
                : null,
            onLogoutPressed: () {
              // Force pop (not maybePop, which PopScope(canPop: false) blocks) to
              // close the gate before logout tears the screen down.
              rootNavigator.pop();
              appBloc.add(const AppLogoutRequested(reason: AppLogoutReason.userRequest));
            },
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
            onLogoutPressed: () {
              rootNavigator.pop();
              appBloc.add(const AppLogoutRequested(reason: AppLogoutReason.userRequest));
            },
          );
        }
      },
      child: scaffold,
    );
  }
}
