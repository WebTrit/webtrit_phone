// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:screenshots/screenshots/call_screen_screenshot.dart';
import 'package:screenshots/screenshots/login_mode_select_screen_screenshot.dart';
import 'package:screenshots/screenshots/main_screen_screenshot.dart';
import 'package:screenshots/screenshots/setting_screen_screenshot.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/main/models/main_flavor.dart';

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
    const title = Text(EnvironmentConfig.APP_NAME);
    final greetings = EnvironmentConfig.APP_GREETING.isEmpty ? null : EnvironmentConfig.APP_GREETING;

    late final screenshots = [
      LoginModeSelectScreenScreenshot(appGreeting: greetings),
      const MainScreenScreenshot(MainFlavor.favorites, title),
      const MainScreenScreenshot(MainFlavor.recents, title),
      const MainScreenScreenshot(MainFlavor.keypad, title),
      const SettingScreenScreenshot(),
      const CallScreenScreenshot(false),
      const CallScreenScreenshot(true)
    ];

    return DefaultTabController(
      key: ValueKey(widget.index),
      length: screenshots.length,
      initialIndex: widget.index,
      child: TabBarView(children: screenshots),
    );
  }
}

const _kInitialIndexParameterName = 'initialIndex';
