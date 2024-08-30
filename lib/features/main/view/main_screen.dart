import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.navigationBarFlavor,
    required this.allowedFlavors,
    this.onNavigationBarTap,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final MainFlavor navigationBarFlavor;
  final List<MainFlavor> allowedFlavors;
  final ValueChanged<MainFlavor>? onNavigationBarTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final currentIndex = allowedFlavors.indexOf(navigationBarFlavor);

    final scaffold = Scaffold(
      body: body,
      bottomNavigationBar: allowedFlavors.length > 1
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: themeData.textTheme.bodySmall,
              unselectedLabelStyle: themeData.textTheme.bodySmall,
              currentIndex: currentIndex,
              onTap: (index) {
                final onNavigationBarTap = this.onNavigationBarTap;
                if (onNavigationBarTap != null) {
                  onNavigationBarTap(allowedFlavors[index]);
                }
              },
              items: allowedFlavors.map((flavor) {
                return BottomNavigationBarItem(
                  icon: Icon(flavor.icon),
                  label: flavor.labelL10n(context),
                );
              }).toList(),
            )
          : null,
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
