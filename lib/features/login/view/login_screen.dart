import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';

import '../login.dart';
import './login_tabs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpClient = HttpClient();
    httpClient.connectionTimeout = kApiClientConnectionTimeout;
    return BlocProvider(
      create: (context) => LoginCubit(
        httpClient: httpClient,
      ),
      child: const LockTabs(),
    );
  }
}
