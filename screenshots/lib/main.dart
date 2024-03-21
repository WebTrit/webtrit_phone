import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshots/router.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/data/data.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/mocks/mocks.dart';

void main() async {
  withClock(
    Clock.fixed(dFixedTime),
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await AppThemes.init();
      final themeSettings = AppThemes().values.first.settings;

      final appBloc = MockAppBloc.allScreen(
        themeSettings: themeSettings,
        themeMode: ThemeMode.light,
        locale: const Locale('en'),
      );
      runApp(ScreenshotsApp(appBloc: appBloc));
    },
  );
}

class ScreenshotsApp extends StatelessWidget {
  ScreenshotsApp({super.key, required this.appBloc});

  final AppBloc appBloc;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appBloc,
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
