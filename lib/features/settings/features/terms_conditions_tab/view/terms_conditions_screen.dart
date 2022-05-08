import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/repositories/repositories.dart';

import '../terms_conditions_tab.dart';
import 'terms_conditions_scaffold.dart';

class TermsConditionsTabScreen extends StatelessWidget {
  const TermsConditionsTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return TermsConditionsTabBloc(
          accountInfoRepository: context.read<AccountInfoRepository>(),
        )..add(const TermsConditionsTabStarted());
      },
      child: const TermsConditionsTabScaffold(),
    );
  }
}
