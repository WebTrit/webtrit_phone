import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';

import 'login_credentials_request_screen.dart';

@RoutePage()
class LoginCredentialsRequestScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginCredentialsRequestScreenPage();

  @override
  Widget build(BuildContext context) {
    return LoginCredentialsRequestScreen(
      initialUrl: Uri.parse(context.read<LoginCubit>().credentialsRequestUrl ?? kBlankUri),
    );
  }
}
