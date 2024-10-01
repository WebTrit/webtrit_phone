import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'login_embedded_screen.dart';

@RoutePage()
class LoginEmbeddedScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginEmbeddedScreenPage({
    required this.url,
    required this.title10n,
    required this.showToolbar,
  });

  final Uri url;
  final String title10n;
  final bool showToolbar;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginEmbeddedCubit(
        context.read<NotificationsBloc>(),
        context.read<LoginCubit>(),
      ),
      child: LoginEmbeddedScreen(
        title: context.parseL10n(title10n),
        initialUri: url,
        showToolbar: showToolbar,
      ),
    );
  }
}
