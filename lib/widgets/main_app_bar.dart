import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

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
    return AppBar(
      title: const Text(EnvironmentConfig.APP_NAME),
      centerTitle: false,
      actions: [
        BlocBuilder<CallBloc, CallState>(
          builder: (context, state) {
            final themeData = Theme.of(context);
            return Ink(
              decoration: ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    color: state is ReadyCallStateMixin ? themeData.colorScheme.tertiary : themeData.colorScheme.error,
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
                ),
                onPressed: () {
                  context.goNamed('settings');
                },
              ),
            );
          },
        ),
        const SizedBox(
          width: NavigationToolbar.kMiddleSpacing,
        ),
      ],
      bottom: bottom,
    );
  }
}
