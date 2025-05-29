import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/models/models.dart';

import 'login_signup_embedded_request_screen.dart';

@RoutePage()
class LoginSignupEmbeddedRequestScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSignupEmbeddedRequestScreenPage(this.embeddedData);

  final LoginEmbedded embeddedData;

  @override
  Widget build(BuildContext context) {
    // TODO(Serdun): Implement directly in LoginEmbedded
    final resource = ResourceLoader.fromUri(
      embeddedData.resource.toString(),
    );

    return FutureBuilder<String>(
      future: resource.loadContent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load content: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final content = snapshot.data!;
          return resource is NetworkResourceLoader
              ? LoginSignupEmbeddedRequestScreen(initialUrl: Uri.parse(content))
              : LoginSignupEmbeddedRequestScreen(
                  initialUrl: Uri.dataFromString(
                    content,
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
