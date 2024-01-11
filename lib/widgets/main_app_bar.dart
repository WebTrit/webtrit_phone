import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    super.key,
    super.title,
    super.bottom,
  }) : super(
          centerTitle: false,
          actions: [
            BlocBuilder<CallBloc, CallState>(
              builder: (context, state) {
                return Ink(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: state.status.color(context),
                      ),
                    ),
                  ),
                  child: IconButton(
                    constraints: const BoxConstraints.tightFor(
                      width: kMinInteractiveDimension,
                      height: kMinInteractiveDimension,
                    ),
                    icon: const Icon(
                      Icons.person,
                    ),
                    onPressed: () {
                      context.router.push(const SettingsRouterPageRoute());
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              width: NavigationToolbar.kMiddleSpacing,
            ),
          ],
        );
}
