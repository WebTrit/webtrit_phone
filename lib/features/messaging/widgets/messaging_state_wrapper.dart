import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/data/feature_access.dart';
import 'package:webtrit_phone/features/features.dart';

class MessagingStateWrapper extends StatelessWidget {
  const MessagingStateWrapper({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final messagingFeature = FeatureAccess().messagingFeature;

    return Column(
      children: [
        Expanded(child: child),
        if (messagingFeature.anyMessagingEnabled)
          BlocBuilder<MessagingBloc, MessagingState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status != ConnectionStatus.connected) {
                return StateBar(status: state.status);
              } else {
                return const SizedBox();
              }
            },
          ),
      ],
    );
  }
}

class MessagingStateBar extends StatelessWidget {
  const MessagingStateBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagingBloc, MessagingState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status != ConnectionStatus.connected) {
          return StateBar(status: state.status);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
