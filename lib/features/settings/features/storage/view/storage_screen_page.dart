import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/data/app_preferences.dart';

import '../storage.dart';

@RoutePage()
class StorageScreenPage extends StatelessWidget {
  const StorageScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StorageCubit(context.read<AppPreferences>()),
      child: const StorageScreen(),
    );
  }
}
