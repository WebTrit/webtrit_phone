import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/screenshots/screenshots.dart';
import 'package:screenshots/widgets/widgets.dart';

class AppPairingContent extends StatelessWidget {
  const AppPairingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebTrit App Pairing',
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name ?? '/0');
        final indexStr = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '0';
        final index = int.tryParse(indexStr) ?? 0;
        return MaterialPageRoute(
          builder: (_) => IndexInputScreen(index: index),
          settings: settings,
        );
      },
    );
  }
}

class IndexInputScreen extends StatefulWidget {
  final int index;

  const IndexInputScreen({super.key, required this.index});

  @override
  State<IndexInputScreen> createState() => _IndexInputScreenState();
}

class _IndexInputScreenState extends State<IndexInputScreen> {
  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();

    final screenshots = [
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginModeSelectScreenScreenshot(),
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
        child: const PrivacyScreenScreenshot(),
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
        child: Builder(
          builder: (context) => const MainScreenScreenshot(
            MainFlavor.messaging,
            Text(EnvironmentConfig.APP_NAME),
          ),
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const SettingScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: MediaSettingsScreenScreenshot(
          initialOpenSection: 1,
        ),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(false),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallScreenScreenshot(true),
      ),
      // Contact & messaging
      ScreenshotApp(
        appBloc: appBloc,
        child: const ContactScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const ChatConversationScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const SmsConversationScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const SystemNotificationsScreenScreenshot(),
      ),
      // CDRs & call log
      ScreenshotApp(
        appBloc: appBloc,
        child: const RecentCdrsScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const NumberCdrsScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallLogScreenScreenshot(),
      ),
      // Settings sub-screens
      ScreenshotApp(
        appBloc: appBloc,
        child: const NetworkScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const LanguageScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const DiagnosticScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const CallerIdSettingsScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const PresenceSettingsScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const ThemeModeScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const VoicemailScreenScreenshot(),
      ),
      // Login variant
      ScreenshotApp(
        appBloc: appBloc,
        child: const LoginSwitchScreenScreenshot(),
      ),
      // Utility screens
      ScreenshotApp(
        appBloc: appBloc,
        child: const LogRecordsConsoleScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const ContactsAgreementScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const TeardownScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const PermissionsScreenScreenshot(),
      ),
      ScreenshotApp(
        appBloc: appBloc,
        child: const UserAgreementScreenScreenshot(),
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
