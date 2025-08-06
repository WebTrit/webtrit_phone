// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    super.key,
    super.title,
    super.bottom,
    required BuildContext context,
  }) : super(
          centerTitle: false,
          actions: [
            if (AppBarParams.of(context).pullableCalls.isNotEmpty)
              CallPullBadge(pullableCalls: AppBarParams.of(context).pullableCalls),
            if (AppBarParams.of(context).systemNotificationsEnabled) SystemNotificationsBadge(),
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
                          username: info?.name ?? info?.numbers.main,
                          thumbnailUrl: gravatarThumbnailUrl(info?.email),
                          radius: kMinInteractiveDimension / 2,
                          showLoading: true,
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

class AppBarParams extends InheritedWidget {
  const AppBarParams({
    required this.systemNotificationsEnabled,
    required this.pullableCalls,
    required super.child,
    super.key,
  });

  final bool systemNotificationsEnabled;
  final List<PullableCall> pullableCalls;
  static AppBarParams of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AppBarParams>();
    if (result == null) {
      throw Exception('AppBarParams not found in context');
    }
    return result;
  }

  @override
  bool updateShouldNotify(AppBarParams oldWidget) {
    return systemNotificationsEnabled != oldWidget.systemNotificationsEnabled ||
        pullableCalls != oldWidget.pullableCalls;
  }
}
