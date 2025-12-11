import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:clock/clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'package:screenshots/data/data.dart';
import 'package:screenshots/router.dart';

import 'package:screenshots/bootstrap.dart';

void main() async {
  await withClock(
    Clock.fixed(dFixedTime),
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final context = await bootstrap();

      runApp(
        MultiProvider(
          providers: context.providers,
          child: ScreenshotsApp(
            appBloc: context.appBloc,
          ),
        ),
      );
    },
  );
}

class ScreenshotsApp extends StatelessWidget {
  const ScreenshotsApp({
    super.key,
    required this.appBloc,
  });

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    return PresenceViewParams(
      viewSource: PresenceViewSource.contactInfo,
      child: BlocProvider.value(
        value: appBloc,
        child: const AppPairingContent(),
      ),
    );
  }
}
