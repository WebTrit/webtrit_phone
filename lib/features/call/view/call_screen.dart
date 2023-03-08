import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

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

class _CallScreenState extends State<CallScreen> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  late Future<List<void>> _renderersInitialized;

  @override
  void initState() {
    super.initState();

    _renderersInitialized = _renderersInitialize();
  }

  @override
  void dispose() {
    _renderersDispose();

    super.dispose();
  }

  Future<List<void>> _renderersInitialize() {
    return Future.wait([
      _localRenderer.initialize(),
      _remoteRenderer.initialize(),
    ]);
  }

  Future<List<void>> _renderersDispose() {
    return Future.wait([
      _localRenderer.dispose(),
      _remoteRenderer.dispose(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _renderersInitialized,
      builder: (context, AsyncSnapshot<List<void>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final callBloc = context.read<CallBloc>();
          // assign streams of active call to handle the case
          // when they are created before renderers finish the initialization
          if (callBloc.state.isActive) {
            final activeCall = callBloc.state.activeCall;
            _localRenderer.srcObject = activeCall.localStream;
            _remoteRenderer.srcObject = activeCall.remoteStream;
          }
          return BlocConsumer<CallBloc, CallState>(
            bloc: callBloc,
            listener: (context, state) async {
              if (state.isActive) {
                final activeCall = state.activeCall;
                _localRenderer.srcObject = activeCall.localStream;
                _remoteRenderer.srcObject = activeCall.remoteStream;

                final activeCallFailure = activeCall.failure;
                if (activeCallFailure != null) {
                  context.read<CallBloc>().add(CallControlEvent.failureApproved(activeCall.callId.uuid));
                  AcknowledgeDialog.show(
                    context,
                    title: context.l10n.call_FailureAcknowledgeDialog_title,
                    content: activeCallFailure.toString(),
                  );
                }
              } else {
                _localRenderer.srcObject = null;
                _remoteRenderer.srcObject = null;
              }
            },
            builder: (context, state) {
              if (state.isActive) {
                final activeCall = state.activeCall;
                return CallActiveScaffold(
                  speaker: state.speaker,
                  activeCall: activeCall,
                  localRenderer: _localRenderer,
                  remoteRenderer: _remoteRenderer,
                  localePlaceholderBuilder: widget.localePlaceholderBuilder,
                  remotePlaceholderBuilder: widget.remotePlaceholderBuilder,
                );
              } else {
                return const CallInitScaffold();
              }
            },
          );
        } else {
          return const CallInitScaffold(
            showProgressIndicator: true,
          );
        }
      },
    );
  }
}
