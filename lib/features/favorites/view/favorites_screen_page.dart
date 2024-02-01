import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

@RoutePage()
class FavoritesScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const FavoritesScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = FavoritesScreen(
      title: Text(EnvironmentConfig.APP_NAME),
    );
    final provider = BlocProvider(
      create: (context) => FavoritesBloc(
        favoritesRepository: context.read<FavoritesRepository>(),
      )..add(const FavoritesStarted()),
      child: widget,
    );
    return provider;
  }
}
