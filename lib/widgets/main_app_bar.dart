import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    Key? key,
    PreferredSizeWidget? bottom,
  }) : super(
          key: key,
          title: const Text(EnvironmentConfig.APP_NAME),
          centerTitle: false,
          actions: [
            BlocBuilder<CallBloc, CallState>(
              builder: (context, state) {
                final themeData = Theme.of(context);
                final colorScheme = themeData.colorScheme;
                return Ink(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: state.signalingClientStatus.isReady ? colorScheme.tertiary : colorScheme.error,
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
