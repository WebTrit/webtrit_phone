import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webtrit_phone/app/routes.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import '../../../call/bloc/call_bloc.dart';
import '../../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.navigationBarFlavor,
    this.onNavigationBarTap,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final MainFlavor navigationBarFlavor;
  final ValueChanged<int>? onNavigationBarTap;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      body: SafeArea(
        top: false,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            NavigationRail(
              selectedIndex: navigationBarFlavor.index,
              onDestinationSelected: onNavigationBarTap,
              labelType: NavigationRailLabelType.all,
              leading: Column(
                children: [
                  const SizedBox(
                    height: 0,
                  ),
                  BlocBuilder<CallBloc, CallState>(
                    builder: (context, state) {
                      return Ink(
                        decoration: ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: state.status.color(context),
                            ),
                          ),
                        ),
                        child: IconButton(
                          constraints: const BoxConstraints.tightFor(
                            width: kMinInteractiveDimension,
                            height: kMinInteractiveDimension,
                          ),
                          icon: const Icon(
                            Icons.person,
                          ),
                          onPressed: () {
                            context.pushNamed(MainRoute.settings);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
              // navigation rail items
              destinations: MainFlavor.values.map((flavor) {
                return NavigationRailDestination(
                  icon: Icon(flavor.icon),
                  label: Text(flavor.labelL10n(context)),
                );
              }).toList(),
            ),
            Expanded(
              child: body,
            ),
          ],
        ),
      ),
    );

    return BlocListener<MainBloc, MainState>(
      listener: (context, state) async {
        final error = state.error;
        final updateStoreViewUrl = state.updateStoreViewUrl;
        if (error != null) {
          final appBloc = context.read<AppBloc>();
          final mainBloc = context.read<MainBloc>();
          final result = await CompatibilityIssueDialog.show(
            context,
            error: error,
            onUpdatePressed: updateStoreViewUrl == null
                ? null
                : () {
                    context.read<MainBloc>().add(MainAppUpdated(updateStoreViewUrl));
                  },
          );
          switch (result) {
            case CompatibilityIssueDialogResult.logout:
              appBloc.add(const AppLogouted());
              break;
            default:
              mainBloc.add(const MainCompatibilityVerified());
              break;
          }
        }
      },
      child: scaffold,
    );
  }
}
