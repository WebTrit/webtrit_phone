import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/autoprovision/cubit/autoprovision_cubit.dart';

class AutoprovisionScreen extends StatelessWidget {
  const AutoprovisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Autoprovision'),
        ),
        body: BlocBuilder<AutoprovisionCubit, AutoprovisionState>(
          builder: (context, state) {
            return SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (state is Initial) const Text('Initial State'),
                  if (state is ProcessingToken) Text('Processing Token: ${state.configToken}'),
                  if (state is ReplaceConfirmationNeeded) Text('Relogin Confirmation Needed: ${state.token}'),
                  if (state is SessionCreated) Text('Session Created: ${state.token}'),
                  if (state is Error) Text('Error: ${state.error}'),
                  const Text('Config Toke'),
                ],
              ),
            );
          },
        ));
  }
}
