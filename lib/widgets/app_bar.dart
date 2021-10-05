import 'package:flutter/material.dart';

import 'package:webtrit_phone/gen/assets.gen.dart';

class ExtAppBar extends AppBar {
  ExtAppBar({
    Key? key,
    Widget? leading,
    Widget? title,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
  }) : super(
          key: key,
          leading: leading,
          title: title,
          actions: actions,
          titleSpacing: 0,
          bottom: bottom,
        );
}

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  MainAppBar({
    Key? key,
    this.bottom,
  })  : preferredSize = Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  final PreferredSizeWidget? bottom;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ExtAppBar(
      leading: Center(
        child: Assets.logo.svg(
          height: themeData.appBarTheme.titleTextStyle!.fontSize! * 1.4,
          color: themeData.accentColor,
        ),
      ),
      title: Row(
        children: [
          Text('WebTrit'),
          const Spacer(),
          Icon(
            Icons.account_balance_wallet_outlined,
            size: themeData.textTheme.button!.fontSize! * 1.2,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            '\$1,340.56',
            style: themeData.textTheme.button!.copyWith(
              color: themeData.textTheme.caption!.color,
            ),
          ),
          const SizedBox(
            width: NavigationToolbar.kMiddleSpacing,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.cloud_outlined,
          ),
          onPressed: () async {
            // TODO
          },
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
          ),
          onPressed: () async {
            Navigator.pushNamed(context, '/main/settings');
          },
        ),
      ],
      bottom: bottom,
    );
  }
}
