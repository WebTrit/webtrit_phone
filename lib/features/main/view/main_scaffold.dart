import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/blocs/blocs.dart';

import '../main.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold(
    this.flavor, {
    super.key,
  });

  final MainFlavor flavor;

  @override
  MainScaffoldState createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final scaffold = Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          fit: StackFit.expand,
          children: MainFlavor.values.map((flavor) {
            return FlavorScreenHolder(
              active: flavor == widget.flavor,
              builder: flavor.builder,
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: themeData.textTheme.bodySmall,
        unselectedLabelStyle: themeData.textTheme.bodySmall,
        currentIndex: widget.flavor.index,
        onTap: (index) {
          context.goNamed(AppRoute.main, queryParams: {MainFlavor.queryParameterName: MainFlavor.values[index].name});
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
          final result = await CompatibilityIssueDialog.show(
            context,
            error: error,
            onUpdatePressed: updateStoreViewUrl == null
                ? null
                : () {
                    context.read<MainBloc>().add(MainAppUpdated(updateStoreViewUrl));
                  },
          );
          if (!mounted) return;
          switch (result) {
            case CompatibilityIssueDialogResult.logout:
              context.read<AppBloc>().add(const AppLogouted());
              break;
            default:
              context.read<MainBloc>().add(const MainCompatibilityVerified());
              break;
          }
        }
      },
      child: scaffold,
    );
  }
}
