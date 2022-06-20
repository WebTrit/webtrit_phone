import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import './login_scaffold.dart';

import '../login.dart';

const kApiClientConnectionTimeout = Duration(seconds: 5);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final httpClient = HttpClient();
    httpClient.connectionTimeout = kApiClientConnectionTimeout;
    return BlocProvider(
      create: (context) => LoginCubit(
        httpClient: httpClient,
      ),
      child: const LockScaffold(),
    );
  }
}
