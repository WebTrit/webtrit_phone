import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/routes.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../call.dart';
import 'call_active_scaffold.dart';
import 'call_init_scaffold.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    super.key,
    this.localePlaceholderBuilder,
    this.remotePlaceholderBuilder,
  });

  final WidgetBuilder? localePlaceholderBuilder;
  final WidgetBuilder? remotePlaceholderBuilder;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MainRoute.observer.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    MainRoute.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    context.read<CallBloc>().add(CallScreenEvent.didPush());
  }

  @override
  void didPop() {
    context.read<CallBloc>().add(CallScreenEvent.didPop());
  }

  @override
  Widget build(BuildContext context) {
    final callBloc = context.read<CallBloc>();

    final scaffold = BlocConsumer<CallBloc, CallState>(
      bloc: callBloc,
      listener: (context, state) async {
        if (state.isActive) {
          final activeCall = state.activeCall;
          final activeCallFailure = activeCall.failure;
          if (activeCallFailure != null) {
            context.read<CallBloc>().add(CallControlEvent.failureApproved(activeCall.callId.uuid));
            AcknowledgeDialog.show(
              context,
              title: context.l10n.call_FailureAcknowledgeDialog_title,
              content: activeCallFailure.toString(),
            );
          }
        }
      },
      builder: (context, state) {
        if (state.isActive) {
          return CallActiveScaffold(
            speaker: state.speaker,
            activeCall: state.activeCall,
            localePlaceholderBuilder: widget.localePlaceholderBuilder,
            remotePlaceholderBuilder: widget.remotePlaceholderBuilder,
          );
        } else {
          return const CallInitScaffold();
        }
      },
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: scaffold,
    );
  }
}
