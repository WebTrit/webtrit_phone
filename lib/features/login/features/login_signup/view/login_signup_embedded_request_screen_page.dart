import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/assets.gen.dart';

import 'login_signup_embedded_request_screen.dart';

@RoutePage()
class LoginSignupEmbeddedRequestScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSignupEmbeddedRequestScreenPage();

  Future<String> _loadHtml() async {
    return await rootBundle.loadString(Assets.html.index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadHtml(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final html = snapshot.data!;
          return LoginSignupEmbeddedRequestScreen(
            initialUrl: Uri.dataFromString(
              html,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ),
          );
        } else {
          return const Center(child: Text('Unexpected error'));
        }
      },
    );
  }
}
