import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';

import '../cubit/sessions_cubit.dart';
import 'sessions_screen.dart';

/// The [SessionsCubit] is owned by the settings router so the settings row
/// badge and this screen share one list; the screen only refreshes it on open.
@RoutePage()
class SessionsScreenPage extends StatefulWidget {
  const SessionsScreenPage({super.key});

  @override
  State<SessionsScreenPage> createState() => _SessionsScreenPageState();
}

class _SessionsScreenPageState extends State<SessionsScreenPage> {
  @override
  void initState() {
    super.initState();
    context.read<SessionsCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return SessionsScreen(dateFormat: context.read<AppTime>().formatDateTime(true));
  }
}
