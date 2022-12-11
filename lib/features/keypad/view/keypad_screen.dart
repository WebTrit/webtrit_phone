import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../call/call.dart';
import '../keypad.dart';
import './keypad_scaffold.dart';

class KeypadScreen extends StatelessWidget {
  const KeypadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KeypadCubit(
        callBloc: context.read<CallBloc>(),
      ),
      child: const KeypadScaffold(),
    );
  }
}
