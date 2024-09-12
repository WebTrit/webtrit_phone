import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

const _loginJavascriptChannelName = 'WebtritLoginChannel';

class LoginCustomSigninScreen extends StatelessWidget {
  const LoginCustomSigninScreen({
    super.key,
    required this.title,
    required this.initialUri,
  });

  final String title;
  final Uri initialUri;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCustomSigninCubit, LoginCustomSigninState>(
      builder: (context, state) {
        final javaScriptChannels = {
          _loginJavascriptChannelName: (JavaScriptMessage message) =>
              context.read<LoginCustomSigninCubit>().manageScriptChannelsData(message.message),
        };

        return WebViewScaffold(
          title: Text(title),
          initialUri: initialUri,
          javaScriptChannels: javaScriptChannels,
        );
      },
      listener: _handleStateChange,
    );
  }

  void _handleStateChange(BuildContext context, LoginCustomSigninState state) {
    if (state.sessionToken != null) {
      context.read<LoginCubit>().loginSigninSubmitted(state.sessionToken!);
    }
  }
}
