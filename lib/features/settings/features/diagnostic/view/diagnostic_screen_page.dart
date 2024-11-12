import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

import '../bloc/diagnostic_cubit.dart';

import 'diagnostic_screen.dart';

@RoutePage()
class DiagnosticScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DiagnosticScreenPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiagnosticCubit>(
      create: (context) => DiagnosticCubit(
        appPermissions: AppPermissions(),
      ),
      child: const DiagnosticScreen(),
    );
  }
}
