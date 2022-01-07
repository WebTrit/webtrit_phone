import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/features/main/main.dart';

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
          color: themeData.colorScheme.secondary,
        ),
      ),
      title: Row(
        children: [
          const Text(EnvironmentConfig.APP_NAME),
          const Spacer(),
          Icon(
            Icons.account_balance_wallet_outlined,
            size: themeData.textTheme.button!.fontSize! * 1.2,
          ),
          const SizedBox(
            width: 2,
          ),
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              final info = state.info;
              if (info != null) {
                return Text(
                  '${info.balance.toStringAsFixed(2)} ${info.currency}',
                  style: themeData.textTheme.button!.copyWith(
                    color: themeData.textTheme.caption!.color,
                  ),
                );
              } else {
                return const SizedBox(
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
        BlocBuilder<CallBloc, CallState>(
          builder: (context, state) {
            if (state is CallAttachFailure || state is CallInitial) {
              return IconButton(
                icon: const Icon(
                  Icons.public_off,
                ),
                onPressed: () async {
                  if (await _showCallDetached(context) == true) {
                    context.read<CallBloc>().add(const CallAttached());
                  }
                },
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.public,
                ),
                onPressed: () async {
                  if (await _showCallAttached(context) == true) {
                    context.read<CallBloc>().add(const CallDetached());
                  }
                },
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(
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

  Future<bool?> _showCallAttached(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Registered"),
          content: const Text("Are you sure you want to unregister?"),
          actions: [
            TextButton(
              child: Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showCallDetached(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Unregistered"),
          content: const Text("Are you sure you want to register?"),
          actions: [
            TextButton(
              child: Text("No".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("Yes".toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
