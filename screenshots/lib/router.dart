import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/screenshots/screenshots.dart';
import 'package:screenshots/widgets/widgets.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        RedirectRoute(path: '/', redirectTo: '/0'),
        AutoRoute(path: '/:$_kInitialIndexParameterName', page: IndexInputRoute.page),
      ];
}

@RoutePage()
class IndexInputScreen extends StatefulWidget {
  final int index;

  const IndexInputScreen({super.key, @PathParam(_kInitialIndexParameterName) required this.index});

  @override
  State<IndexInputScreen> createState() => _IndexInputScreenState();
}

class _IndexInputScreenState extends State<IndexInputScreen> {
  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();

    late final screenshots = [
      ScreenshotApp(
        appBloc: appBloc,
        child: LoginModeSelectScreenScreenshot(
          appGreeting: EnvironmentConfig.APP_GREETING.isEmpty ? null : EnvironmentConfig.APP_GREETING,
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginCoreUrlAssignScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginOtpSignInScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginOtpVerifyInScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginPasswordSignInScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginSignUpScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginSignUpVerifyScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.favorites,
          Text(EnvironmentConfig.APP_NAME),
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.recents,
          Text(EnvironmentConfig.APP_NAME),
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const MainScreenScreenshot(
          MainFlavor.keypad,
          Text(EnvironmentConfig.APP_NAME),
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const SettingScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(false),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(true),
      ),
    ];

    return DefaultTabController(
      key: ValueKey(widget.index),
      length: screenshots.length,
      initialIndex: widget.index,
      child: TabBarView(
        children: screenshots,
      ),
    );
  }
}

const _kInitialIndexParameterName = 'initialIndex';
