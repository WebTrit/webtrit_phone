import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

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

        if (coreVersionState is Incompatible) {
          final canUpdateApp = coreVersionState.updateStoreUrl != null;

          CompatibilityIssueDialog.show(
            context,
            coreVersionState.currentVersion,
            coreVersionState.supportedConstraint,
            onUpdatePressed: canUpdateApp
                ? () {
                    context.read<MainBloc>().add(MainBlocAppUpdatePressed(coreVersionState.updateStoreUrl!));
                  }
                : null,
            onLogoutPressed: () {
              Navigator.of(context).maybePop();
              context.read<SessionRepository>().logout();
            },
          );
        }
      },
      child: scaffold,
    );
  }
}
