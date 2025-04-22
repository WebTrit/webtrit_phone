import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    super.key,
    super.title,
    super.bottom,
  }) : super(
          centerTitle: false,
          actions: [
            BlocBuilder<SessionStatusCubit, SessionStatusState>(
              builder: (context, sessionState) {
                return Ink(
                  decoration: ShapeDecoration(
                    shape: CircleBorder(
                      side: BorderSide(
                        color: sessionState.status.color(context),
                      ),
                    ),
                  ),
                  child: BlocBuilder<UserInfoCubit, UserInfoState>(
                    builder: (context, userinfoState) {
                      final info = userinfoState.userInfo;
                      return IconButton(
                        key: mainAppBarKey,
                        constraints: const BoxConstraints.tightFor(
                          width: kMinInteractiveDimension,
                          height: kMinInteractiveDimension,
                        ),
                        padding: const EdgeInsets.all(2),
                        icon: LeadingAvatar(
                          username: info?.name ?? info?.numbers.main ?? 'N/A',
                          thumbnailUrl: gravatarThumbnailUrl(info?.email),
                          radius: kMinInteractiveDimension / 2,
                        ),
                        onPressed: () {
                          context.router.navigate(const SettingsRouterPageRoute());
                        },
                      );
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
