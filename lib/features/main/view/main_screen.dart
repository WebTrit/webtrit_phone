import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_info_extractor/store_info_extractor.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../main.dart';
import 'main_scaffold.dart';

class MainScreen extends StatelessWidget {
  const MainScreen(
    this.flavor, {
    super.key,
  });

  final MainFlavor flavor;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainBloc(
          infoRepository: context.read<InfoRepository>(),
          storeInfoExtractor: StoreInfoExtractor(),
        )..add(const MainStarted());
      },
      child: MainScaffold(flavor),
    );
  }
}
