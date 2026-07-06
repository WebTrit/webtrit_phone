import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class LoginQrSigninScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginQrSigninScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrSigninCubit(
        appPermissions: context.read<AppPermissions>(),
        parser: QrSigninUriParser(context.read<FeatureAccess>().loginConfig.qrSignin),
      ),
      child: const LoginQrSigninScreen(),
    );
  }
}
