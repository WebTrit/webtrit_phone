import 'package:clock/clock.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';

import 'package:screenshots/router.dart';
import 'package:screenshots/data/data.dart';
import 'package:screenshots/mocks/mocks.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/core_support.dart';

void main() async {
  withClock(
    Clock.fixed(dFixedTime),
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final appThemes = await AppThemes.init();
      final packageInfo = await PackageInfoFactory.init();
      final deviceInfo = await DeviceInfoFactory.init();

      final appPreferences = await AppPreferencesImpl.init();
      final secureStorage = await SecureStorageImpl.init();
      final activeMainFlavorRepository = ActiveMainFlavorRepositoryPrefsImpl(appPreferences);
      final systemInfoLocalRepository = SystemInfoLocalRepositoryPrefsImpl(secureStorage);
      final coreSupport = CoreSupportImpl(() => systemInfoLocalRepository.getSystemInfo());

      final themeSettings = appThemes.values.first.settings;

      final appBloc = MockAppBloc.allScreen(
        themeSettings: themeSettings,
        themeMode: ThemeMode.light,
        locale: const Locale('en'),
      );

      final featureAccess = FeatureAccess.init(
        appThemes.appConfig,
        appThemes.embeddedResources,
        activeMainFlavorRepository,
        coreSupport,
      );

      runApp(MultiProvider(
          providers: [
            Provider<FeatureAccess>(
              create: (context) => featureAccess,
            ),
            Provider<PackageInfo>(
              create: (context) => packageInfo,
            ),
            Provider<DeviceInfo>(
              create: (context) => deviceInfo,
            ),
          ],
          child: ScreenshotsApp(
            appBloc: appBloc,
          )));
    },
  );
}

class ScreenshotsApp extends StatelessWidget {
  const ScreenshotsApp({super.key, required this.appBloc});

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appBloc,
      child: const AppPairingContent(),
    );
  }
}
