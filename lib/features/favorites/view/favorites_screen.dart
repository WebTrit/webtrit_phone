import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import 'favorites_scaffold.dart';

import '../favorites.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
        favoritesRepository: context.read<FavoritesRepository>(),
      )..add(const FavoritesStarted()),
      child: const FavoritesScaffold(),
    );
  }
}
