import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExtAppBar extends AppBar {
  ExtAppBar({
    Key key,
    Widget leading,
    Widget title,
    List<Widget> actions,
  }) : super(
          key: key,
          leading: leading,
          title: title,
          actions: actions,
          titleSpacing: 0,
        );
}

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  MainAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return ExtAppBar(
      leading: Center(
        child: SvgPicture.asset(
          'assets/logo.svg',
          height: themeData.appBarTheme.textTheme.headline6.fontSize * 1.4,
          color: themeData.accentColor,
        ),
      ),
      title: Row(
        children: [
          Text('WebTrit'),
          const Spacer(),
          Icon(
            Icons.account_balance_wallet_outlined,
            size: themeData.textTheme.button.fontSize * 1.2,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            '\$1,340.56',
            style: themeData.textTheme.button.copyWith(
              color: themeData.textTheme.caption.color,
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
    );
  }
}
