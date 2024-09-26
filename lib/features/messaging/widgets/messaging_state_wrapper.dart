import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/features/features.dart';

class MessagingStateWrapper extends StatelessWidget {
  const MessagingStateWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<MessagingBloc, MessagingState>(
            buildWhen: (previous, current) => previous.userId != current.userId,
            builder: (context, state) {
              if (state.userId != null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        BlocBuilder<MessagingBloc, MessagingState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status != ConnectionStatus.connected) {
              return Material(
                color: Colors.white,
                child: StateBar(status: state.status),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
