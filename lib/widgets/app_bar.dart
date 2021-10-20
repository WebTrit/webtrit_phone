import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/gen/assets.gen.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

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
          StreamBuilder(
            stream: context.read<AccountInfoRepository>().info(),
            builder: (context, AsyncSnapshot<AccountInfo> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final info = snapshot.data!;
                return Text(
                  '${info.balance.toStringAsFixed(2)} ${info.currency}',
                  style: themeData.textTheme.button!.copyWith(
                    color: themeData.textTheme.caption!.color,
                  ),
                );
              } else {
                return SizedBox(
                  width: 10,
                  height: 10,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
            },
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
