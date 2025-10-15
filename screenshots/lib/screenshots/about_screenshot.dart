import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class AboutScreenshot extends StatelessWidget {
  const AboutScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutBloc>(
      create: (context) => MockAboutBloc.success(),
      child: const AboutScreen(),
    );
  }
}
