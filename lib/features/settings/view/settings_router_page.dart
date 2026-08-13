import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../features/sessions/sessions.dart';

@RoutePage()
class SettingsRouterPage extends StatelessWidget {
  const SettingsRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provided above the router so the settings row badge and the sessions
    // screen share one list: revoking a session updates the badge right away.
    return BlocProvider(
      create: (context) => SessionsCubit(context.read<SessionsRepository>())..fetch(),
      child: const AutoRouter(),
    );
  }
}
