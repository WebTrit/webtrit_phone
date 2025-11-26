import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';
import 'call_active_scaffold.dart';
import 'call_init_scaffold.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    super.key,
    this.localePlaceholderBuilder,
    this.remotePlaceholderBuilder,
    this.callConfig = const CallConfig(),
  });

  final CallConfig callConfig;

  final WidgetBuilder? localePlaceholderBuilder;
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with AutoRouteAwareStateMixin {
  @override
  void didPush() {
    context.read<CallBloc>().add(const CallScreenEvent.didPush());
  }

  @override
  void didPop() {
    context.read<CallBloc>().add(const CallScreenEvent.didPop());
  }

  @override
  Widget build(BuildContext context) {
    final callBloc = context.read<CallBloc>();

    final style = Theme.of(context).extension<CallScreenStyles>()?.primary?.systemUiOverlayStyle;

    final scaffold = MultiBlocListener(
      listeners: [
        BlocListener<CallBloc, CallState>(
          bloc: callBloc,
          listener: (context, state) {
            if (state.isActive) {
              final activeCall = state.activeCalls.current;
              final activeCallFailure = activeCall.failure;
              if (activeCallFailure != null) {
                context.read<CallBloc>().add(CallControlEvent.failureApproved(activeCall.callId));
                AcknowledgeDialog.show(
                  context,
                  title: context.l10n.call_FailureAcknowledgeDialog_title,
                  content: activeCallFailure.toString(),
                );
              }
            }
          },
        ),
        BlocListener<CallBloc, CallState>(
          bloc: callBloc,
          listenWhen: (previous, current) =>
              current.isActive && current.activeCalls.current.processingStatus != previous.activeCalls.current.processingStatus,
          listener: (context, state) {
            if (state.isActive) {
              final activeCall = state.activeCalls.current;
              if (activeCall.processingStatus == CallProcessingStatus.deniedMicrophone) {
                AcknowledgeDialog.show(
                  context,
                  title: context.l10n.call_MissingMicrophoneDialog_title,
                  content: context.l10n.call_MissingMicrophoneDialog_content,
                );
              }
            }
          },
        ),
      ],
      child: BlocBuilder<CallBloc, CallState>(
        bloc: callBloc,
        builder: (context, state) {
          if (state.isActive) {
            return CallActiveScaffold(
              callStatus: state.status,
              activeCalls: state.activeCalls,
              audioDevice: state.audioDevice,
              availableAudioDevices: state.availableAudioDevices,
              callConfig: widget.callConfig,
              localePlaceholderBuilder: widget.localePlaceholderBuilder,
              remotePlaceholderBuilder: widget.remotePlaceholderBuilder,
            );
          } else {
            return const CallInitScaffold();
          }
        },
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(value: style ?? SystemUiOverlayStyle.light, child: scaffold);
  }
}
