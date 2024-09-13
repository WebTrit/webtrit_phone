import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/messaging/messaging.dart';

import '../main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.body,
    required this.navigationBarFlavor,
    this.onNavigationBarTap,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final Widget body;
  final MainFlavor navigationBarFlavor;
  final ValueChanged<MainFlavor>? onNavigationBarTap;

  @override
  Widget build(BuildContext context) {
    const isMessagingFeatureEnabled = EnvironmentConfig.CHAT_FEATURE_ENABLE;

    List<BottomNavigationBarItem> navBarItems = [];

    for (var flavor in MainFlavor.values) {
      Widget icon = Icon(flavor.icon);
      String label = flavor.labelL10n(context);

      if (flavor == MainFlavor.chats) {
        if (!isMessagingFeatureEnabled) continue;
        icon = ChatFlavorOverlay(child: icon);
      }

      final item = BottomNavigationBarItem(icon: icon, label: label);
      navBarItems.add(item);
    }

    final themeData = Theme.of(context);
    final scaffold = Scaffold(
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: themeData.textTheme.bodySmall,
        unselectedLabelStyle: themeData.textTheme.bodySmall,
        currentIndex: navigationBarFlavor.index,
        onTap: (index) => onNavigationBarTap?.call(MainFlavor.values[index]),
        items: navBarItems,
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
