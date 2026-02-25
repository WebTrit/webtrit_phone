import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import 'package:screenshots/mocks/mocks.dart';

class NumberCdrsScreenScreenshot extends StatefulWidget {
  const NumberCdrsScreenScreenshot({super.key});

  @override
  State<NumberCdrsScreenScreenshot> createState() => _NumberCdrsScreenScreenshotState();
}

class _NumberCdrsScreenScreenshotState extends State<NumberCdrsScreenScreenshot> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (!mounted) return;

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, _, __) {
            return MultiProvider(
              providers: [
                Provider<ContactsRepository>(create: (_) => MockContactsRepository()),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<NumberCdrsLogCubit>(create: (_) => MockNumberCdrsLogCubit.withRecords()),
                  BlocProvider<CallBloc>(create: (_) => MockCallBloc.mainScreen()),
                ],
                child: const NumberCdrsScreen(
                  title: Text('Thomas Anderson'),
                  videoVisible: true,
                ),
              ),
            );
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          fullscreenDialog: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
