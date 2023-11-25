import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    super.key,
    super.bottom,
    required String title,
  }) : super(
          title: Text(title),
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
                      context.pushNamed(MainRoute.settings);
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
