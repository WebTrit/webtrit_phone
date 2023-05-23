import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/blocs/blocs.dart';

import '../main.dart';

typedef MainFlavorWidgetBuilder = Widget Function(BuildContext context, MainFlavor flavor);

class MainScreen extends StatelessWidget {
  const MainScreen(
    this.flavor, {
    super.key,
    required this.flavorWidgetBuilder,
  });

  final MainFlavor flavor;
  final MainFlavorWidgetBuilder flavorWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final scaffold = Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            for (final flavor in MainFlavor.values)
              FlavorScreenHolder(
                active: flavor == this.flavor,
                builder: (context) => flavorWidgetBuilder(context, flavor),
              )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: themeData.textTheme.bodySmall,
        unselectedLabelStyle: themeData.textTheme.bodySmall,
        currentIndex: flavor.index,
        onTap: (index) {
          context.goNamed(AppRoute.main, queryParameters: {
            MainFlavor.queryParameterName: MainFlavor.values[index].name,
          });
        },
        items: MainFlavor.values.map((flavor) {
          return BottomNavigationBarItem(
            icon: Icon(flavor.icon),
            label: flavor.labelL10n(context),
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
