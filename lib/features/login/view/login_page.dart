import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_api/webtrit_api.dart';

import './login_scaffold.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        webtritApiClient: context.read<WebtritApiClient>(),
      ),
      child: const LockScaffold(),
    );
  }
}
