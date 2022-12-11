import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/features/features.dart';

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
    return Scaffold(
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
        selectedLabelStyle: themeData.textTheme.caption,
        unselectedLabelStyle: themeData.textTheme.caption,
        currentIndex: widget.flavor.index,
        onTap: (index) {
          context.goNamed(AppRoute.main, queryParams: {'$MainFlavor': MainFlavor.values[index].name});
        },
        items: MainFlavor.values.map((flavor) {
          return BottomNavigationBarItem(
            icon: Icon(flavor.icon),
            label: flavor.labelL10n(context),
          );
        }).toList(),
      ),
    );
  }
}
