import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_api/webtrit_api.dart';

import '../features/otp/otp.dart';
import '../features/password/password.dart';

import 'supported_logins_screen.dart';

@RoutePage()
class SupportedLoginsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SupportedLoginsScreenPage({
    required this.supportedLogins,
    required this.coreUrl,
    required this.demo,
    required this.defaultTenantId,
  });

  final List<SupportedLoginType> supportedLogins;
  final String coreUrl;
  final bool demo;
  final String defaultTenantId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OtpCubit(coreUrl, demo, defaultTenantId),
        ),
        BlocProvider(
          create: (context) => PasswordRequestCubit(coreUrl, demo, defaultTenantId),
        ),
      ],
      child: SupportedLoginsScreen(
        supportedLoginType: supportedLogins,
      ),
    );
  }
}
