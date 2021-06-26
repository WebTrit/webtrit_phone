import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';

import './login_scaffold.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        webtritApiClient: context.read<WebtritApiClient>(),
        secureStorage: SecureStorage(),
      ),
      child: LockScaffold(),
    );
  }
}
