import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../call.dart';

class CallFailureScaffold extends StatelessWidget {
  const CallFailureScaffold({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CallFailure state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              state.reason,
              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Tooltip(
                message: 'Ok',
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () => context.read<CallBloc>().add(const CallFailureApproved()),
                  child: const Text('Ok'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
