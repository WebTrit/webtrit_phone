import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/blocs/blocs.dart';

import './keypad_scaffold.dart';

import '../keypad.dart';

class KeypadPage extends StatelessWidget {
  const KeypadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KeypadCubit(
        callBloc: context.read<CallBloc>(),
      ),
      child: KeypadScaffold(),
    );
  }
}
