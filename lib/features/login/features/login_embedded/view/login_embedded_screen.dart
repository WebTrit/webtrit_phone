import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import '../extensions/extensions.dart';

const _loginJavascriptChannelName = 'WebtritLoginChannel';

class LoginEmbeddedScreen extends StatelessWidget {
  const LoginEmbeddedScreen({
    super.key,
    required this.title,
    required this.initialUrl,
    required this.showToolbar,
  });

  final String? title;
  final Uri initialUrl;
  final bool showToolbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginEmbeddedCubit, LoginEmbeddedState>(
        builder: (context, state) {
          final themeData = Theme.of(context);

          final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

          return WebViewScaffold(
            title: title != null ? Text(title!) : null,
            initialUri: initialUrl,
            showToolbar: showToolbar,
            javaScriptChannels: {
              _loginJavascriptChannelName: (JavaScriptMessage message) =>
                  context.read<LoginEmbeddedCubit>().login(message.message),
            },
            errorBuilder: (context, error, controller) => Column(
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
        },
      ),
    );
  }
}
