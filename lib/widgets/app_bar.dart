import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/styles/styles.dart';

class ExtAppBar extends AppBar {
  ExtAppBar({
    Key? key,
    Widget? leading,
    Widget? title,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    bool? centerTitle,
  }) : super(
          key: key,
          leading: leading,
          title: title,
          actions: actions,
          titleSpacing: 0,
          bottom: bottom,
          centerTitle: centerTitle,
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
        ),
      ),
      title: Row(
        children: const [
          Text(EnvironmentConfig.APP_NAME),
          SizedBox(
            width: NavigationToolbar.kMiddleSpacing,
          ),
        ],
      ),
      actions: [
        BlocBuilder<CallBloc, CallState>(
          builder: (context, state) {
            return Ink(
              decoration: ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    color: state is ReadyCallStateMixin ? AppColors.green : AppColors.red,
                  ),
                ),
              ),
              child: IconButton(
                constraints: const BoxConstraints(
                  maxWidth: kMinInteractiveDimension,
                  maxHeight: kMinInteractiveDimension,
                ),
                icon: const Icon(
                  Icons.person,
                  color: AppColors.darkBlueSecondary,
                ),
                onPressed: () {
                  context.goNamed('settings');
                },
              ),
            );
          },
        ),
        const SizedBox(
          width: 8.0,
        ),
      ],
      bottom: bottom,
    );
  }
}
