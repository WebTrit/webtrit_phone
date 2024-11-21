import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../extensions/extensions.dart';

const _loginJavascriptChannelName = 'WebtritLoginChannel';

class LoginEmbeddedScreen extends StatefulWidget {
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
  State<LoginEmbeddedScreen> createState() => _LoginEmbeddedScreenState();
}

class _LoginEmbeddedScreenState extends State<LoginEmbeddedScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        _loginJavascriptChannelName,
        onMessageReceived: _onJavaScriptMessageReceived,
      )
      ..loadRequest(Uri.parse(widget.initialUrl.toString()));
  }

  void _onJavaScriptMessageReceived(JavaScriptMessage message) {
    // Log the raw message for debugging purposes
    print("Received message: ${message.message}");

    try {
      // Parse the JSON message
      final Map<String, dynamic> decodedMessage = jsonDecode(message.message);

      // Extract data from the decoded JSON
      final event = decodedMessage['event'];
      final data = decodedMessage['data'];

      print("Event: $event");
      print("Data: $data");

      // Trigger the OTP section display if the event matches
      if (event == 'sendOtp') {
        final phoneNumber = data["phoneNumber"] as String;
        context.read<LoginEmbeddedCubit>().loginByNumber(phoneNumber);

        // _controller.runJavaScript('showOtpVerify();');
      }

      if (event == 'validateOtp') {
        final otp = data["otp"] as String;
        context.read<LoginEmbeddedCubit>().verifyOtp(otp);
      }

      // Pass the decoded data to your cubit or state management logic
      // context.read<LoginEmbeddedCubit>().login(data);
    } catch (e) {
      // Handle JSON parsing errors
      print("Error decoding message: $e");
    }

// // Handle messages from the WebView
// print(message);
// _controller.runJavaScript('showOtpVerify();');

// final decodedMessage = message.message; // Process if needed
// context.read<LoginEmbeddedCubit>().login(decodedMessage);
  }

  /// Send a message to the WebView to perform an action.
  Future<void> _sendMessageToWebView(String event, Map<String, dynamic>? data) async {
    final payload = {
      'event': event,
      'data': data,
    };
    final script = '''
      window.flutter_invoke(${Uri.encodeComponent(payload.toString())});
    ''';
    await _controller.runJavaScript(script);
  }

  /// Example: Show a loading indicator in WebView.
  Future<void> showLoadingIndicator() async {
    await _sendMessageToWebView('showProgress', null);
  }

  /// Example: Hide the loading indicator in WebView.
  Future<void> hideLoadingIndicator() async {
    await _sendMessageToWebView('hideProgress', null);
  }

  /// Example: Notify WebView to display an OTP UI.
  Future<void> showOtpUI() async {
    await _sendMessageToWebView('showOtpUI', null);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final ElevatedButtonStyles? elevatedButtonStyles = themeData.extension<ElevatedButtonStyles>();

    return Scaffold(
      body: WebViewScaffold(
        controller: _controller,
        title: widget.title != null ? Text(widget.title!) : null,
        initialUri: widget.initialUrl,
        showToolbar: widget.showToolbar,
        addLocaleNameToQueryParameters: false,
        javaScriptChannels: {
          _loginJavascriptChannelName: (JavaScriptMessage message) => _onJavaScriptMessageReceived(message),
        },
        builder: (context, widget) {
          return BlocConsumer<LoginEmbeddedCubit, LoginEmbeddedState>(
            listener: (BuildContext context, LoginEmbeddedState state) {
              final [coreUrl, tenantId, token, userId] = [state.coreUrl, state.tenantId, state.token, state.userId];

              if (state.signupSessionOtpProvisionalWithDateTime != null && token == null) {
                _controller.runJavaScript('showOtpVerify();');
              }

              if (coreUrl != null && tenantId != null && token != null && userId != null) {
                _controller.runJavaScript('showSuccess();');
                final event = AppLogined(coreUrl: coreUrl, tenantId: tenantId, token: token, userId: userId);
                context.read<AppBloc>().add(event);
              }
            },
            builder: (context, state) {
              return Stack(children: [
                widget,
                if (state.processing)
                  SafeArea(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: Container(
                              color: Colors.white.withOpacity(0.25),
                            ),
                          ),
                        ),
                        const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )),
                      ],
                    ),
                  ),
              ]);
            },
          );
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
      ),
    );
  }
}
