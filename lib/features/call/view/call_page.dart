import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../call.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  CallPageState createState() => CallPageState();
}

class CallPageState extends State<CallPage> {
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
        return snapshot.connectionState == ConnectionState.done
            ? BlocBuilder<CallBloc, CallState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is IdleCallState) {
                    _localRenderer.srcObject = null;
                    _remoteRenderer.srcObject = null;

                    return Scaffold(
                      body: Container(
                        color: Colors.black,
                      ),
                    );
                  }
                  if (state is ActiveCallState) {
                    _localRenderer.srcObject = state.localStream;
                    _remoteRenderer.srcObject = state.remoteStream;

                    return CallActiveScaffold(
                      state: state,
                      localRenderer: _localRenderer,
                      remoteRenderer: _remoteRenderer,
                    );
                  }
                  if (state is FailureCallState) {
                    return CallFailureScaffold(state: state);
                  }
                  throw StateError(''); // TODO fix if logic
                },
              )
            : Scaffold(
                body: Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
      },
    );
  }
}
