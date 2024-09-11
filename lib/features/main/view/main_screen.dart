import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.flavors,
    required this.activeFlavor,
    this.onNavigationBarTap,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final List<MainFlavor> flavors;
  final MainFlavor activeFlavor;
  final ValueChanged<MainFlavor>? onNavigationBarTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final scaffold = Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: themeData.textTheme.bodySmall,
        unselectedLabelStyle: themeData.textTheme.bodySmall,
        currentIndex: flavors.indexOf(activeFlavor),
        onTap: (index) {
          final onNavigationBarTap = this.onNavigationBarTap;
          if (onNavigationBarTap != null) {
            onNavigationBarTap(flavors[index]);
          }
        },
        items: flavors.map((flavor) {
          return BottomNavigationBarItem(
            icon: Icon(flavor.icon),
            label: context.getL10n(flavor.title),
          );
        }).toList(),
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
