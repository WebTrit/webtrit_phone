import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/models/feature_access/exports.dart';

import 'login_signup_embedded_request_screen.dart';

@RoutePage()
class LoginSignupEmbeddedRequestScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSignupEmbeddedRequestScreenPage(this.embeddedData);

  final LoginEmbeddedModeButton embeddedData;

  /// Loads the HTML content from an asset file specified in the resource path.
  Future<String> _loadHtmlFromAsset() async {
    final resourcePath = embeddedData.customLoginFeature.resource.path;
    return await rootBundle.loadString(resourcePath);
  }

  @override
  Widget build(BuildContext context) {
    final resourceUri = embeddedData.customLoginFeature.resource;

    // Check if the resource is a valid HTTPS URL.
    if (resourceUri.isScheme('https')) {
      return LoginSignupEmbeddedRequestScreen(initialUrl: resourceUri);
    }

    // Load and render the HTML from local assets.
    return FutureBuilder<String>(
      future: _loadHtmlFromAsset(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load content: ${snapshot.error}', textAlign: TextAlign.center),
          );
        } else if (snapshot.hasData) {
          final htmlContent = snapshot.data!;
          return LoginSignupEmbeddedRequestScreen(
            initialUrl: Uri.dataFromString(
              htmlContent,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ),
          );
        } else {
          return const Center(
            child: Text('Unexpected error occurred.'),
          );
        }
      },
    );
  }
}
