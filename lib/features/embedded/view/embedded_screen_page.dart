import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/router/app_router.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';

import '../bloc/embedded_cubit.dart';
import '../extensions/extensions.dart';

import 'embedded_screen.dart';

abstract class EmbeddedScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors const
  const EmbeddedScreenPage(this.data);

  final BottomMenuTabData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmbeddedCubit(),
      child: EmbeddedScreen(
        initialUri: Uri.parse(data.url),
        title: const Text(EnvironmentConfig.APP_NAME),
      ),
    );
  }

  static PageRouteInfo<dynamic>? getPageRouteInfo(RouteMatch route, BottomMenuTabData? bottomMenuTabData) {
    final routes = {
      EmbeddedScreenPage1Route.page: (data) => EmbeddedScreenPage1Route(data: data),
      EmbeddedScreenPage2Route.page: (data) => EmbeddedScreenPage2Route(data: data),
      EmbeddedScreenPage3Route.page: (data) => EmbeddedScreenPage3Route(data: data),
    };

    for (final entry in routes.entries) {
      final embedded = route.findRouteWithRequiredParams(entry.key);
      if (embedded != null && bottomMenuTabData != null) {
        return entry.value(bottomMenuTabData) as PageRouteInfo<dynamic>;
      }
    }
    return null;
  }

  static PageRouteInfo<dynamic>? getPageRoute(MainFlavor flavor, BottomMenuTabData data) {
    final routes = {
      MainFlavor.embedded1: () => EmbeddedScreenPage1Route(data: data),
      MainFlavor.embedded2: () => EmbeddedScreenPage2Route(data: data),
      MainFlavor.embedded3: () => EmbeddedScreenPage3Route(data: data),
    };

    return routes[flavor]?.call() as PageRouteInfo<dynamic>?;
  }
}

@RoutePage()
class EmbeddedScreenPage1 extends EmbeddedScreenPage {
  // ignore: use_key_in_widget_constructors const
  const EmbeddedScreenPage1(super.data);
}

@RoutePage()
class EmbeddedScreenPage2 extends EmbeddedScreenPage {
  // ignore: use_key_in_widget_constructors const
  const EmbeddedScreenPage2(super.data);
}

@RoutePage()
class EmbeddedScreenPage3 extends EmbeddedScreenPage {
  // ignore: use_key_in_widget_constructors const
  const EmbeddedScreenPage3(super.data);
}
