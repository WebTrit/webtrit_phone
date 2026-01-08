import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/single_child_widget.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/common/common.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'package:screenshots/mocks/mocks.dart';

typedef AppContext = ({AppBloc appBloc, List<SingleChildWidget> providers});

Future<AppContext> bootstrap() async {
  final appThemes = await AppThemes.init();
  final packageInfo = await PackageInfoFactory.init();
  final deviceInfo = await DeviceInfoFactory.init();
  final secureStorage = await SecureStorageImpl.init();
  final appPreferences = await AppPreferencesImpl.init();
  final appInfo = await AppInfo.init(SharedPreferencesAppIdProvider());

  final activeMainFlavorRepository = ActiveMainFlavorRepositoryPrefsImpl(appPreferences);
  final systemInfoLocalRepository = SystemInfoLocalRepositoryPrefsImpl(secureStorage);
  final coreSupport = CoreSupportImpl(() => systemInfoLocalRepository.getSystemInfo());

  final mockAppMetadataProvider = await DefaultAppMetadataProvider.init(
    packageInfo,
    deviceInfo,
    appInfo,
    secureStorage,
  );

  final featureAccess = FeatureAccess.init(
    appThemes.appConfig,
    appThemes.embeddedResources,
    activeMainFlavorRepository,
    coreSupport,
  );

  final appBloc = MockAppBloc.allScreen(
    themeSettings: appThemes.values.first.settings,
    themeMode: ThemeMode.light,
    locale: const Locale('en'),
  );

  final providers = [
    Provider<FeatureAccess>.value(value: featureAccess),
    Provider<PackageInfo>.value(value: packageInfo),
    Provider<DeviceInfo>.value(value: deviceInfo),
    Provider<AppMetadataProvider>.value(value: mockAppMetadataProvider),
  ];

  return (appBloc: appBloc, providers: providers);
}
