import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'login_custom_signin_screen.dart';

@RoutePage()
class LoginCustomSigninScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginCustomSigninScreenPage(this.url, this.title10n);

  final Uri url;
  final String title10n;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCustomSigninCubit(
        context.read<NotificationsBloc>(),
        context.read<LoginCubit>(),
      ),
      child: LoginCustomSigninScreen(
        title: context.parseL10n(title10n),
        initialUri: url,
      ),
    );
  }
}
