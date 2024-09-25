import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.currentTab,
    required this.tabs,
    this.onNavigationBarTap,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final BottomMenuTab currentTab;
  final List<BottomMenuTab> tabs;
  final ValueChanged<BottomMenuTab>? onNavigationBarTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final scaffold = Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: themeData.textTheme.bodySmall,
        unselectedLabelStyle: themeData.textTheme.bodySmall,
        currentIndex: tabs.indexOf(currentTab),
        items: tabs.map((tab) {
          final flavor = tab.flavor;
          Widget icon = Icon(tab.icon);
          String label = context.parseL10n(tab.titleL10n);
          if (flavor == MainFlavor.messaging) icon = MessagingFlavorOverlay(child: icon);
          return BottomNavigationBarItem(icon: icon, label: label);
        }).toList(),
        onTap: (index) => onNavigationBarTap?.call(tabs[index]),
        // items: navBarItems,
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
