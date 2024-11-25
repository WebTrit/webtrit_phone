import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/features/login/features/login_embedded/extensions/extensions.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

const _loginJavascriptChannelName = 'WebtritLoginChannel';

class LoginSignupEmbeddedRequestScreen extends StatelessWidget {
  const LoginSignupEmbeddedRequestScreen({
    super.key,
    required this.initialUrl,
  });

  final Uri initialUrl;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    return WebViewScaffold(
      initialUri: initialUrl,
      showToolbar: false,
      addLocaleNameToQueryParameters: false,
      javaScriptChannels: {
        _loginJavascriptChannelName: (JavaScriptMessage message) => _onJavaScriptMessageReceived(message, context),
      },
      errorPlaceholder: (context, error, controller) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 100,
            color: themeData.colorScheme.error,
          ),
          const SizedBox(height: kInset),
          Text(
            error.titleL10n(context),
            style: themeData.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            error.messageL10n(context),
            textAlign: TextAlign.center,
            style: themeData.textTheme.bodyMedium,
          ),
          const SizedBox(height: kInset),
          ElevatedButton(
            onPressed: controller.reload,
            style: elevatedButtonStyles?.primary,
            child: Text(
              context.l10n.common_noInternetConnection_retryButton,
            ),
          ),
        ],
      ),
    );
  }

  void _onJavaScriptMessageReceived(JavaScriptMessage message, BuildContext context) {
    try {
      final Map<String, dynamic> decodedMessage = jsonDecode(message.message);

      final event = decodedMessage['event'];
      final data = decodedMessage['data'];

      if (event == 'signup') {
        final phoneNumber = data["phoneNumber"] as String;

        context.read<LoginCubit>().signupEmailInputChanged(phoneNumber);
        context.read<LoginCubit>().loginSignupRequestSubmitted();
      }
    } catch (e) {
      // Handle JSON parsing errors
      print("Error decoding message: $e");
    }
  }
}
