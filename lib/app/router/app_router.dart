import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/router/app_shell.dart';
import 'package:webtrit_phone/app/router/main_shell.dart';
import 'package:webtrit_phone/features/features.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: null,
)
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppShellRoute.page,
          children: [
            AutoRoute(
              page: LoginScreenPageRoute.page,
            ),
            AutoRoute(
              page: PermissionsScreenPageRoute.page,
            ),
            AutoRoute(
              page: MainShellRoute.page,
              path: '/main',
              children: [
                AutoRoute(
                  page: MainScreenPageRoute.page,
                  children: [],
                ),
                AutoRoute(
                  page: CallScreenPageRoute.page,
                  fullscreenDialog: true,
                ),
                AutoRoute(
                  page: SettingsScreenPageRoute.page,
                  path: 'settings',
                  fullscreenDialog: true,
                ),
                AutoRoute(
                  page: AboutScreenPageRoute.page,
                  path: 'settings/about',
                ),
                AutoRoute(
                  page: HelpScreenPageRoute.page,
                  path: 'settings/help',
                ),
                AutoRoute(
                  page: LanguageScreenPageRoute.page,
                  path: 'settings/language',
                ),
                AutoRoute(
                  page: NetworkScreenPageRoute.page,
                  path: 'settings/network',
                ),
                AutoRoute(
                  page: TermsConditionsScreenPageRoute.page,
                  path: 'settings/terms-conditions',
                ),
                AutoRoute(
                  page: ThemeModeScreenPageRoute.page,
                  path: 'settings/theme-mode',
                ),
                AutoRoute(
                  page: LogRecordsConsoleScreenPageRoute.page,
                  path: 'settings/log-records-console',
                ),
              ],
            ),
          ],
        ),
      ];
}
